local M = {}

local config = require('completion.config')
local util = require('completion.util')

local context = {
  lsp = {
    result = nil,
    cancel_func = nil,
    window = nil,
    buffer = nil,
    text = nil,
  },
}

M.trigger_signature = function(bufnr)
  if util.has_lsp_capability(bufnr, 'signatureHelpProvider') then
    local params = vim.lsp.util.make_position_params()
    context.lsp.cancel_func = vim.lsp.buf_request_all(bufnr, 'textDocument/signatureHelp', params,
      function(result)
        context.lsp.result = result
        M.show_signature_window()
      end)
  end
end

M.auto_signature = util.debounce(function()
  local left_char = util.get_left_char()
  local char_is_trigger = left_char == ')' or util.is_lsp_trigger(left_char, 'signature')
  if not char_is_trigger then
    return
  end

  M.trigger_signature()
end, config.signature.delay)

M.process_signature_response = function(response)
  if not response.signatures or vim.tbl_isempty(response.signatures) then return {} end

  -- Get active signature (based on textDocument/signatureHelp specification)
  local signature_id = response.activeSignature or 0
  -- This is according to specification: "If ... value lies outside ...
  -- defaults to zero"
  local n_signatures = vim.tbl_count(response.signatures or {})
  if signature_id < 0 or signature_id >= n_signatures then signature_id = 0 end
  local signature = response.signatures[signature_id + 1]

  -- Get displayed signature label
  local signature_label = signature.label

  -- Get start and end of active parameter (for highlighting)
  local hl_range = {}
  local n_params = vim.tbl_count(signature.parameters or {})
  local has_params = signature.parameters and n_params > 0

  -- Take values in this order because data inside signature takes priority
  local parameter_id = signature.activeParameter or response.activeParameter or 0
  local param_id_inrange = 0 <= parameter_id and parameter_id < n_params

  -- Computing active parameter only when parameter id is inside bounds is not
  -- strictly based on specification, as currently (v3.16) it says to treat
  -- out-of-bounds value as first parameter. However, some clients seems to use
  -- those values to indicate that nothing needs to be highlighted.
  -- Sources:
  -- https://github.com/microsoft/pyright/pull/1876
  -- https://github.com/microsoft/language-server-protocol/issues/1271
  if has_params and param_id_inrange then
    local param_label = signature.parameters[parameter_id + 1].label

    -- Compute highlight range based on type of supplied parameter label: can
    -- be string label which should be a part of signature label or direct start
    -- (inclusive) and end (exclusive) range values
    local first, last = nil, nil
    if type(param_label) == 'string' then
      first, last = signature_label:find(vim.pesc(param_label))
      -- Make zero-indexed and end-exclusive
      if first then
        first, last = first - 1, last
      end
    elseif type(param_label) == 'table' then
      first, last = unpack(param_label)
    end
    if first then hl_range = { first = first, last = last } end
  end

  -- Return nested table because this will be a second argument of
  -- `vim.list_extend()` and the whole inner table is a target value here.
  return { { label = signature_label, hl_range = hl_range } }
end

M.get_signature_lines = function()
  local signature_data = util.process_lsp_response(context.lsp.result, M.process_signature_response)
  local lines, hl_ranges = {}, {}
  for _, t in pairs(signature_data) do
    -- `t` is allowed to be an empty table (in which case nothing is added) or
    -- a table with two entries. This ensures that `hl_range`'s integer index
    -- points to an actual line in future buffer.
    table.insert(lines, t.label)
    table.insert(hl_ranges, t.hl_range)
  end

  return lines, hl_ranges
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

  local lines, _ = M.get_signature_lines()
  if not lines or util.is_whitespace(lines) then
    return
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
  if context.lsp.cancel_func then
    pcall(context.lsp.cancel_func)
  end
  context.lsp.cancel_func = nil
  context.lsp.result = nil
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
