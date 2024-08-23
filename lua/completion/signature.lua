local M = {}

local config = require('completion.config').get_config()
local util = require('completion.util')

local context = {
  lsp = {
    result = {},
    request_ids = {},
    window = nil,
    buffer = nil,
    text = nil,
  },
}

M.auto_signature = util.debounce(function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  context.lsp.result = {}

  local left_char = util.get_left_char()
  for _, client in pairs(clients) do
    local triggers = util.table_get(client, { 'server_capabilities', 'signatureHelpProvider', 'triggerCharacters' }) or {}
    if vim.tbl_contains(triggers, left_char) then
      if util.table_get(client, { 'server_capabilities', 'signatureHelpProvider' }) then
        if context.lsp.request_ids[client.id] then
          client.cancel_request(context.lsp.request_ids[client.id])
          context.lsp.request_ids[client.id] = nil
        end

        local params = vim.lsp.util.make_position_params()
        local result, request_id = client.request('textDocument/signatureHelp', params, function(err, client_result, _, _)
          if not err then
            context.lsp.result[client.id] = client_result
            M.show_signature_window()
          end
        end, bufnr)

        if result then
          context.lsp.request_ids[client.id] = request_id
        end
      end
    end
  end
end, config.signature.delay)

M.get_signature_lines = function()
  local lines = {}
  local docs = {}
  for _, result in pairs(context.lsp.result) do
    local signatures = result.signatures
    if type(signatures) == 'table' then
      for _, signature_help in pairs(signatures) do
        local label = signature_help.label or ''
        local document = signature_help.documentation
        if document and type(document) == 'table' then
          document = document.value or ''
        end
        table.insert(lines, label)
        table.insert(docs, document)
      end
    end
  end
  return lines, docs
end

M.signature_window_options = function()
  local lines = vim.api.nvim_buf_get_lines(context.lsp.buffer, 0, -1, false)
  local height, width = util.floating_dimensions(lines, config.signature.max_height, config.signature.max_width)

  -- Compute position
  local win_line = vim.fn.winline()
  local space_above, space_below = win_line - 1, vim.fn.winheight(0) - win_line

  local anchor = 'NW'
  local row = 1
  local space = space_below
  if height <= space_above or space_below <= space_above then
    anchor, row, space = 'SW', 0, space_above
  end

  -- Possibly adjust floating window dimensions to fit screen
  if space < height then
    height, width = util.floating_dimensions(lines, space, config.signature.max_width)
  end

  -- Get zero-indexed current cursor position
  local bufpos = vim.api.nvim_win_get_cursor(0)
  bufpos[1] = bufpos[1] - 1

  return {
    relative = 'win',
    bufpos = bufpos,
    anchor = anchor,
    row = row,
    col = 0,
    width = width,
    height = height,
    focusable = false,
    style = 'minimal',
    border = 'rounded',
  }
end

M.show_signature_window = function()
  if not context.lsp.result then
    return
  end

  local lines, docs = M.get_signature_lines()
  if not lines or util.is_whitespace(lines) then
    return
  end

  if docs and not util.is_whitespace(docs) then
    table.insert(lines, '')
    for _, doc in pairs(docs) do
      table.insert(lines, doc)
    end
  end

  util.create_buffer(context.lsp, 'function-signature')
  vim.lsp.util.stylize_markdown(context.lsp.buffer, lines, {})

  local cur_text = table.concat(lines, '\n')
  if context.lsp.window and cur_text == context.lsp.text then
    return
  end

  if context.lsp.window then
    util.close_action_window(context.lsp)
  end

  context.lsp.text = cur_text
  if vim.fn.mode() == 'i' then
    local options = M.signature_window_options()
    util.open_action_window(context.lsp, options)
  end
end

M.stop_signature = function()
  util.close_action_window(context.lsp)

  for client_id, request_id in pairs(context.lsp.request_ids) do
    local client = vim.lsp.get_client_by_id(client_id)
    if client and request_id then
      client.cancel_request(request_id)
      context.lsp.request_ids[client_id] = nil
    end
  end

  context.lsp.result = {}
  context.lsp.text = nil
end

M.setup = function()
  vim.api.nvim_create_autocmd({ 'CursorMovedI' }, {
    callback = M.auto_signature
  })

  vim.api.nvim_create_autocmd({ 'InsertLeavePre' }, {
    callback = M.stop_signature
  })
end

return M
