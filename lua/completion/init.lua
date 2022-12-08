local M = {}
local context = {}

local util = require('completion.util')
local config = require('completion.config')
local lru = require('completion.lru')

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

context.completion = {
  timer = vim.loop.new_timer(),
  lsp = {
    result = nil,
    cancel_func = nil,
  },
  buffer = {
    cache = {},
    result = {},
  },
  file = {
    result = nil,
  },
  special_chars = {},
}

context.info = {
  timer = vim.loop.new_timer(),
  lsp = {
    result = nil,
    cancel_func = nil,
    window = nil,
    buffer = nil,
  },
}

context.signature = {
  timer = vim.loop.new_timer(),
  lsp = {
    result = nil,
    cancel_func = nil,
    window = nil,
    buffer = nil,
    text = nil,
  },
}

context.index_buffer = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local num_lines = vim.api.nvim_buf_line_count(current_buf)
  local current_line = vim.api.nvim__buf_stats(0).current_lnum
  local lines = nil

  if num_lines > config.completion.buffer_max_size then
    lines = vim.api.nvim_buf_get_lines(current_buf,
      math.max(0, current_line - config.completion.buffer_reindex_range),
      math.min(num_lines, current_line + config.completion.buffer_reindex_range), false)
  else
    lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
  end

  if lines then
    if not context.completion.buffer.cache[current_buf] then
      context.completion.buffer.cache[current_buf] = lru.create_lru(config.completion.lru_size)
    end

    local current_cache = context.completion.buffer.cache[current_buf]
    for i = 1, #lines do
      local words = util.get_words(lines[i])
      for _, word in pairs(words) do
        current_cache:add_data(word)
      end
    end
    context.completion.buffer.result[current_buf] = current_cache:get_keys()
  end
end

context.scan_paths = function()
  local dirname = util.get_current_dirname()
  if not dirname then
    return
  end

  local stat = vim.loop.fs_stat(dirname)
  if not stat then
    return
  end

  local items = util.scan_directory(dirname)
  context.completion.file.result = items
end

context.prepare_buffer_completion = util.throttle(function()
  context.index_buffer()
end, config.completion.throttle_time)

context.trigger_auto_complete = util.throttle(function()
  if vim.fn.mode() == 'i' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-u>', true, false, true), 'n', false)
  end
end, config.completion.throttle_time)

context.trigger_file_completion = util.throttle(function()
  context.scan_paths()

  if vim.fn.mode() == 'i' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-u>', true, false, true), 'n', false)
  end
end, config.completion.throttle_time)

context.trigger_completion = util.debounce(function()
  context.trigger_file_completion()

  -- context.completion.lsp.result = nil
  if util.has_lsp_capability('completionProvider') then
    local buf = vim.api.nvim_get_current_buf()
    local params = vim.lsp.util.make_position_params()
    context.completion.lsp.cancel_func = vim.lsp.buf_request_all(buf, 'textDocument/completion', params, function(result)
      context.completion.lsp.result = result
      context.trigger_auto_complete()
    end)
  end
end, context.completion.timer, config.completion.debounce_time)

context.stop_completion = function()
  context.completion.timer:stop()
  if context.completion.lsp.cancel_func then
    context.completion.lsp.cancel_func()
  end
  context.completion.lsp.cancel_func = nil

  context.completion.lsp.result = nil
  context.completion.file.result = nil
end

context.get_completion_info_text = function(event, callback)
  local completed_item = util.table_get(event, { 'completed_item' }) or {}
  local text = completed_item.info or ''
  if not util.is_whitespace(text) then
    local lines = { '<text>' }
    vim.list_extend(lines, vim.split(text, '\n'))
    table.insert(lines, '</text>')
    callback(lines)
    return
  end

  local completed_item_source = util.table_get(completed_item, { 'user_data', 'nvim', 'lsp', 'source' })
  if completed_item_source ~= 'lsp' then
    callback(nil)
    return
  end

  local lsp_completion_item = util.table_get(completed_item, { 'user_data', 'nvim', 'lsp', 'completion_item' })
  if not lsp_completion_item then
    callback(nil)
    return
  end

  local doc = lsp_completion_item.documentation
  if doc then
    local lines = vim.lsp.util.convert_input_to_markdown_lines(doc)
    callback(vim.lsp.util.trim_empty_lines(lines))
    return
  end

  local current_buffer = vim.api.nvim_get_current_buf()

  vim.lsp.buf_request_all(current_buffer, 'completionItem/resolve', lsp_completion_item, function(result)
    util.process_lsp_response(result, function(response)
      if not response.documentation and not response.detail then
        callback(nil)
        return
      end
      local res = vim.lsp.util.convert_input_to_markdown_lines(response.documentation or response.detail)
      callback(vim.lsp.util.trim_empty_lines(res))
    end)
  end)
end

context.get_info_window_options = function(event)
  local lines = vim.api.nvim_buf_get_lines(context.info.lsp.buffer, 0, -1, {})
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
  }
end

context.trigger_info = function(event)
  util.create_buffer(context.info.lsp, 'completion-info')

  local info_handler = function(info_text)
    if not info_text or util.is_whitespace(info_text) then
      return
    end

    vim.lsp.util.stylize_markdown(context.info.lsp.buffer, info_text)
    local callback = vim.schedule_wrap(function()
      local options = context.get_info_window_options(event)
      if vim.fn.pumvisible() ~= 1 or vim.fn.mode() ~= 'i' then
        return
      end

      util.open_action_window(context.info.lsp, options)
    end)
    context.info.timer:start(10, 0, callback)
  end

  context.get_completion_info_text(event, info_handler)
end

context.stop_info = function()
  context.info.timer:stop()
  if context.info.cancel_func ~= nil then
    context.info.cancel_func()
  end
  context.info.cancel_func = nil
  util.close_action_window(context.info.lsp)
end

context.process_signature_response = function(response)
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

context.get_signature_lines = function()
  local signature_data = util.process_lsp_response(context.signature.lsp.result, context.process_signature_response)
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

context.signature_window_options = function()
  local lines = vim.api.nvim_buf_get_lines(context.signature.lsp.buffer, 0, -1, {})
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

context.show_signature_window = function()
  if not context.signature.lsp.result then
    return
  end

  local lines, hl_ranges = context.get_signature_lines()
  if not lines or util.is_whitespace(lines) then
    return
  end

  util.create_buffer(context.signature.lsp, 'function-signature')
  vim.lsp.util.stylize_markdown(context.signature.lsp.buffer, lines)

  local cur_text = table.concat(lines, '\n')
  if context.signature.lsp.window and cur_text == context.signature.lsp.text then
    return
  end

  if context.signature.lsp.window then
    util.close_action_window(context.signature.lsp)
  end

  context.signature.lsp.text = cur_text

  if vim.fn.mode() == 'i' then
    local options = context.signature_window_options()
    util.open_action_window(context.signature.lsp, options)
  end
end

context.trigger_signature = vim.schedule_wrap(function()
  if util.has_lsp_capability('signatureHelpProvider') then
    local bufnr = vim.api.nvim_get_current_buf()
    local params = vim.lsp.util.make_position_params()
    context.signature.lsp.cancel_func = vim.lsp.buf_request_all(bufnr, 'textDocument/signatureHelp', params, function(result)
      context.signature.lsp.result = result
      context.show_signature_window()
    end)
  end
end)

context.stop_signature = function()
  util.close_action_window(context.signature.lsp)
  context.signature.timer:stop()

  if context.signature.lsp.cancel_func then
    context.signature.lsp.cancel_func()
  end

  context.signature.lsp.cancel_func = nil
  context.signature.lsp.result = nil
  context.signature.lsp.text = nil
end

M.auto_complete = function()
  context.trigger_completion()
end

M.auto_info = util.debounce(function(event)
  if vim.tbl_isempty(event.completed_item) then
    return
  end

  context.trigger_info(event)
end, context.info.timer, config.info.delay)

M.auto_signature = util.debounce(function()
  local left_char = util.get_left_char()
  local char_is_trigger = left_char == ')' or util.is_lsp_trigger(left_char, 'signature')
  if not char_is_trigger then
    return
  end

  context.trigger_signature()
end, context.signature.timer, config.signature.delay)

M.complete_func = function(findstart, base)
  if findstart == 1 then
    if context.completion.lsp.result == nil and
        context.completion.buffer.result == nil and
        context.completion.file == nil then
	    return -3
	  else
	    local start = util.get_completion_start()
	    if start <= 0 then
	      return -3
	    else
	      return start
	    end
    end
  else
    local result = {}
    if context.completion.lsp.result then
      result = util.process_lsp_response(context.completion.lsp.result, function(response, client_id)
        local items = util.table_get(response, { 'items' }) or response
        if type(items) ~= 'table' then return {} end
        items = util.filter_lsp_result(items, base)
        util.sort_lsp_result(items)
        return util.lsp_completion_response_items_to_complete_items(items, client_id)
      end)
    end

    if context.completion.file.result then
      for _, item in pairs(context.completion.file.result) do
        if vim.startswith(item.word, base) then
          table.insert(result, item)
        end
      end
    end

    local current_buf = vim.api.nvim_get_current_buf()
    if context.completion.buffer.result[current_buf] then
      local items = util.buffer_result_to_complete_items(context.completion.buffer.result[current_buf], base)
      for _, item in pairs(items) do
        if vim.startswith(item.word, base) then
          table.insert(result, item)
        end
      end
    end

    return result
  end
end

M.stop = function()
  context.stop_completion()
  context.stop_info()
  context.stop_signature()
end

M.confirm_completion = function()
  local cr = config.completion.cr_mapping ~= nil and config.completion.cr_mapping()
    or vim.api.nvim_replace_termcodes('<CR>', true, true, true)

  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'selected' }).selected ~= -1 then
    local char = util.get_left_char()
    if context.completion.special_chars[char] ~= nil then
      return vim.api.nvim_replace_termcodes('<C-E>', true, true, true) .. cr
    else
      return vim.api.nvim_replace_termcodes('<C-Y>', true, true, true)
    end
  else
    return cr
  end
end

M.close_timers = function()
  context.completion.timer:close()
  context.info.timer:close()
  context.signature.timer:close()
end

M.apply_options = function(opts)
  opts = opts or {}
  if opts.cr_mapping ~= nil then
    config.completion.cr_mapping = opts.cr_mapping
  end
end

M.setup = function(opts)
  M.apply_options(opts)

  -- cache special characters
  for _, char in pairs(config.completion.special_chars) do
    context.completion.special_chars[char] = true
  end

  vim.api.nvim_create_autocmd({'InsertCharPre'}, {
    callback = M.auto_complete
  })

  vim.api.nvim_create_autocmd({'InsertLeavePre'}, {
    callback = function()
      context.prepare_buffer_completion()
      M.stop()
    end
  })
  vim.api.nvim_create_autocmd({'CompleteChanged'}, {
    callback = function()
      M.auto_info(vim.v.event)
    end
  })
  vim.api.nvim_create_autocmd({'VimEnter'}, {
    callback = context.prepare_buffer_completion,
  })

  vim.api.nvim_create_autocmd({'TextChangedI'}, {
    callback = context.stop_info
  })
  vim.api.nvim_create_autocmd({'CursorMovedI'}, {
    callback = M.auto_signature
  })

  vim.api.nvim_create_autocmd({'VimLeavePre'}, {
    callback = M.close_timers
  })

  _G.completion = M
  vim.opt.completefunc = 'v:lua.completion.complete_func'

  -- options
  vim.api.nvim_set_option('completeopt', 'menuone,noinsert')
  -- maximum number of items to show in the popup menu
  vim.api.nvim_set_option('pumheight', 30)
  -- keyword completion
  vim.api.nvim_set_option('complete', '.,w,b,u,U,t,k')
  -- do not show XXX completion (YYY)
  vim.api.nvim_set_option('shortmess', vim.api.nvim_get_option('shortmess') .. 'c')

  vim.api.nvim_set_keymap('i', '<CR>', '', {
    expr = true,
    noremap = true,
    callback = completion.confirm_completion,
  })
  vim.api.nvim_set_keymap('i', '<C-Space>', '', {
    expr = true,
    noremap = true,
    callback = M.auto_complete,
  })
end

return M
