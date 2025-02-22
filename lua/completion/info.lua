local M = {}

local config = require('completion.config').get_config()
local util = require('completion.util')

local context = {
  lsp = {
    result = nil,
    cancel_func = nil,
    window = nil,
    buffer = nil,
  },
}

local get_completion_doc = function(completed_item)
  local completion_item = util.table_get(completed_item, { 'user_data', 'nvim', 'lsp', 'completion_item' })
  if completion_item and completion_item.documentation then
    return vim.lsp.util.convert_input_to_markdown_lines(completion_item.documentation)
  end
  return nil
end

M.get_info_window_options = function(event)
  local lines = vim.api.nvim_buf_get_lines(context.lsp.buffer, 0, -1, false)
  local info_height, info_width = util.floating_dimensions(lines, config.info.max_height, config.info.max_width)

  local left_to_pum = event.col - 1
  local right_to_pum = event.col + event.width + (event.scrollbar and 1 or 0)

  local space_left, space_right = left_to_pum, vim.o.columns - right_to_pum

  local anchor, col, space
  -- Decide side at which info window will be displayed
  if info_width <= space_right or space_left <= space_right then
    anchor, col, space = 'NW', right_to_pum, space_right
  else
    anchor, col, space = 'NE', left_to_pum, space_left
  end

  -- Possibly adjust floating window dimensions to fit screen
  if space < info_width then
    info_height, info_width = util.floating_dimensions(lines, config.info.max_height, space)
  end

  return {
    relative = 'editor',
    anchor = anchor,
    row = event.row,
    col = col,
    width = info_width,
    height = info_height,
    focusable = false,
    style = 'minimal',
    border = 'rounded',
  }
end

M.show_info = util.debounce(function(info_text, event)
  if vim.fn.pumvisible() ~= 1 or vim.fn.mode() ~= 'i' then
    return
  end

  vim.lsp.util.stylize_markdown(context.lsp.buffer, info_text, {})
  local options = M.get_info_window_options(event)
  util.open_action_window(context.lsp, options)
end, config.info.delay)

M.trigger_info = function(event)
  util.create_buffer(context.lsp, 'completion-info')
  local completed_item = util.table_get(event, { 'completed_item' }) or {}
  local doc = get_completion_doc(completed_item)
  local text = {}
  if doc then
    if #text then
      table.insert(text, '\n')
    end
    for _, line in pairs(doc) do
      table.insert(text, line)
    end
  end

  if #text > 0 then
    vim.defer_fn(function()
      M.show_info(text, event)
    end, 0)
  end
end

M.stop_info = function()
  if context.cancel_func ~= nil then
    pcall(context.cancel_func)
  end
  context.cancel_func = nil
  util.close_action_window(context.lsp)
end

M.auto_info = util.debounce(function(event)
  if vim.tbl_isempty(event.completed_item) then
    return
  end

  M.trigger_info(event)
end, config.info.delay)

M.setup = function()
  vim.api.nvim_create_autocmd({ 'CompleteChanged' }, {
    callback = function()
      local event = vim.v.event
      M.auto_info(event)
    end
  })

  vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
    callback = M.stop_info
  })

  vim.api.nvim_create_autocmd({ 'InsertLeavePre' }, {
    callback = M.stop_info,
  })
end

return M
