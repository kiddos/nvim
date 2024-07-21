local M = {}

local uv = vim.uv or vim.loop

local config = require('completion.config').get_config()
local util = require('completion.util')

local context = {
  lsp = {
    result = {},
    cancel_func = nil,
  },
  file = {
    result = nil,
  },
  special_chars = {},
}

M.scan_paths = function()
  local dirname = util.get_current_dirname()
  if not dirname then
    return
  end

  local stat = uv.fs_stat(dirname)
  if not stat then
    return
  end

  local items = util.scan_directory(dirname)
  context.file.result = items
end

M.is_subseq = function(word1, word2)
  local j = 1
  for i = 1, #word2 do
    if string.byte(word2, i) == string.byte(word1, j) then
      j = j + 1
    end

    if j == #word1 + 1 then
      return true
    end
  end
  return false
end

M.get_completion_word = function(completion_item)
  return util.table_get(completion_item, { 'textEdit', 'newText' }) or completion_item.insertText or completion_item.label or ''
end

M.filter_lsp_result = function(items, base)
  return vim.tbl_filter(function(item)
    -- if item.kind == 15 then
    --   return false
    -- end

    local word = M.get_completion_word(item)
    return M.is_subseq(base, word)
  end, items)
end

M.remove_prefix = function(word,  before_cursor)
  local i = 1
  local j = #before_cursor
  while i <= #word and j >= 1 and string.sub(word, i, 1) == string.sub(before_cursor, j, j) do
    j = j - 1
    i = i + 1
  end
  return string.sub(word, i)
end

M.lsp_completion_response_items_to_complete_items = function(items, client_id)
  if vim.tbl_count(items) == 0 then return {} end

  local res = {}
  --local current_line = vim.api.nvim_get_current_line()
  --local before_cursor = string.sub(current_line, 1, vim.fn.col('.') - 1)
  for _, completion_item in pairs(items) do
    local word = M.get_completion_word(completion_item)
    --word = M.remove_prefix(word, before_cursor)

    table.insert(res, {
      word = word,
      abbr = util.trim_long_text(completion_item.label, config.completion.abbr_max_len),
      kind = vim.lsp.protocol.CompletionItemKind[completion_item.kind] or 'Unknown',
      menu = util.trim_long_text(completion_item.detail or '', config.completion.menu_max_len),
      info = util.get_documentation(completion_item),
      icase = 1,
      dup = 1,
      empty = 1,
      user_data = {
        nvim = {
          lsp = {
            completion_item = completion_item,
            source = 'lsp',
            client_id = client_id,
          }
        }
      },
    })
  end
  return res
end

M.process_lsp_response = function(request_result, processor)
  if not request_result then
    return {}
  end

  if type(request_result) ~= 'table' then
    return {}
  end

  local res = {}
  for client_id, handler_result in pairs(request_result) do
    if not handler_result.err and handler_result.result then
      vim.list_extend(res, processor(handler_result.result, client_id) or {})
    end
  end
  return res
end


M.prepare_completion_item = function(base_word)
  local result = {}
  if context.lsp.result then
    result = M.process_lsp_response(context.lsp.result, function(response, client_id)
      local items = util.table_get(response, { 'items' }) or response
      if type(items) ~= 'table' then return {} end

      items = M.filter_lsp_result(items, base_word)
      return M.lsp_completion_response_items_to_complete_items(items, client_id)
    end)
    util.sort_completion_result(result, base_word)
  end

  if context.file.result then
    local filtered = {}
    for _, item in pairs(context.file.result) do
      if M.is_subseq(base_word, item.word) then
        table.insert(filtered, item)
      end
    end
    for _, item in pairs(filtered) do
      table.insert(result, item)
    end
  end

  return result
end

M.find_completion_base_word = function()
  if context.lsp.result == nil and
      context.file.result == nil then
    return nil
  else
    local start = util.get_completion_start()
    if start < 0 then
      return nil
    else
      local line = vim.api.nvim_get_current_line()
      return string.sub(line, start + 1, vim.fn.col('.') - 1)
    end
  end
end

M.show_completion = function()
  local base_word = M.find_completion_base_word()
  if base_word ~= nil then
    local items = M.prepare_completion_item(base_word)
    if vim.fn.mode() == 'i' then
      vim.fn.complete(util.get_completion_start() + 1, items)
    end
  end
end

M.find_lsp_result_start = function(list)
  if not list then
    return -1
  end

  for _, item in pairs(list) do
    if not item.err then
      local items = util.table_get(item, { 'result', 'items'})
      if items then
        for _, completion_item in pairs(items) do
          local start = util.table_get(completion_item, { 'textEdit', 'range', 'start' })
          if start then
            return start
          end
        end
      end
    end
  end

  return -1
end

M.append_lsp_result = function(results, new_results)
  local indices = {}
  for _, entry in pairs(results) do
    if not entry.err then
      local items = util.table_get(entry, { 'result', 'items' })
      if items then
        for idx, item in pairs(items) do
          local sort_text = util.table_get(item, { 'sortText' })
          if sort_text then
            indices[sort_text] = idx
          end
        end
      end
    end
  end

  for _, entry in pairs(new_results) do
    if not entry.err then
      local items = util.table_get(entry, { 'result', 'items' })
      if items then
        for _, item in pairs(items) do
          local sort_text = util.table_get(item, { 'sortText' })
          if sort_text and indices[sort_text] then
            local idx = indices[sort_text]
            results[idx] = item
          else
            table.insert(results, item)
          end
        end
      end
    end
  end
end

M.trigger_completion = util.debounce(function(bufnr)
  M.scan_paths()

  local params = vim.lsp.util.make_position_params()

  if util.has_lsp_capability(bufnr, 'completionProvider') then
    if context.lsp.cancel_func then
      context.lsp.cancel_func()
    end
    context.lsp.cancel_func = vim.lsp.buf_request_all(bufnr, 'textDocument/completion', params, function(result)
      vim.defer_fn(function()
        -- context.lsp.result = result
        if vim.tbl_isempty(context.lsp.result) then
          context.lsp.result = result
        else
          local s1 = M.find_lsp_result_start(result)
          local s2 = M.find_lsp_result_start(context.lsp.result)
          if #context.lsp.result > 0 and s1 == s2 then
            M.append_lsp_result(context.lsp.result, result)
          else
            context.lsp.result = result
          end
        end

         --print(#result[1].result.items)
         --if #result[1].result.items > 0 then
           --print(vim.inspect(result[1].result.items[1]))
         --end
        M.show_completion()
      end, 0)
    end)
  else
    vim.defer_fn(function()
      M.show_completion()
    end, 0)
  end
end, config.completion.delay)

M.confirm_completion = function()
  local cr = config.cr_mapping ~= nil and config.cr_mapping()
      or vim.api.nvim_replace_termcodes('<CR>', true, true, true)

  local info = vim.fn.complete_info({ 'selected', 'items' })
  local items = info.items
  local index = info.selected
  if vim.fn.pumvisible() ~= 0 and index ~= -1 then
    local selected = items[index + 1]
    local char = util.get_left_char()
    -- TODO
    -- make this more robust
    if context.special_chars[char] ~= nil then
      return vim.api.nvim_replace_termcodes('<C-E>', true, true, true) .. cr
    else
      local text_edit = util.table_get(selected, { 'user_data', 'nvim', 'lsp', 'completion_item', 'textEdit' })
      if text_edit then
        local key = vim.api.nvim_replace_termcodes('<C-E>', true, true, true)
        vim.api.nvim_feedkeys(key, 'i', false)
        vim.defer_fn(function()
          if vim.fn.pumvisible() ~= 0 then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          vim.lsp.util.apply_text_edits({ text_edit }, bufnr, 'utf-8')

          local text = util.table_get(text_edit, { 'newText' })
          local row = util.table_get(text_edit, { 'range', 'start', 'line' })
          local col = util.table_get(text_edit, { 'range', 'start', 'character' })
          if text and row and col then
            vim.api.nvim_win_set_cursor(0, { row + 1, col + #text })
          end
        end, 100)
        return
      end

      return vim.api.nvim_replace_termcodes('<C-Y>', true, true, true)
    end
  else
    return cr
  end
end

M.stop_completion = function()
  if context.lsp.cancel_func then
    pcall(context.lsp.cancel_func)
  end
  context.lsp.cancel_func = nil

  context.lsp.result = {}
  context.file.result = nil
end

M.auto_complete = function()
  local bufnr = vim.api.nvim_get_current_buf()
  M.trigger_completion(bufnr)
end

M.setup = function()
  -- cache special characters
  for _, char in pairs(config.completion.special_chars) do
    context.special_chars[char] = true
  end

  vim.api.nvim_create_autocmd({ 'InsertCharPre' }, {
    callback = M.auto_complete
  })

  vim.api.nvim_create_autocmd({ 'InsertLeavePre' }, {
    callback = function()
      M.stop_completion()
    end
  })

  vim.api.nvim_set_keymap('i', '<CR>', '', {
    expr = true,
    noremap = true,
    callback = M.confirm_completion,
  })
  vim.api.nvim_set_keymap('i', '<C-Space>', '', {
    expr = true,
    noremap = true,
    callback = M.auto_complete,
  })

  vim.api.nvim_create_user_command('CompletionToggle', function()
    context.completion.enabled = not context.completion.enabled
  end, {})
end

return M
