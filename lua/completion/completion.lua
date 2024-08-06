local M = {}

local config = require('completion.config').get_config()
local util = require('completion.util')

local context = {
  lsp = {
    completion_items = {},
    cancel_func = nil,
  },
  special_chars = {},
}

M.get_completion_word = function(completion_item)
  return util.table_get(completion_item, { 'textEdit', 'newText' }) or completion_item.insertText or
      completion_item.label or ''
end

M.convert_completion_items = function(items)
  if vim.tbl_count(items) == 0 then return {} end

  local result = {}
  for _, item in pairs(items) do
    local word = M.get_completion_word(item)
    local completion_item = {
      word = word,
      abbr = util.trim_long_text(item.label, config.completion.abbr_max_len),
      kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'Unknown',
      menu = util.trim_long_text(item.detail or '', config.completion.menu_max_len),
      info = util.get_documentation(item),
      icase = 1,
      dup = 1,
      empty = 1,
      user_data = {
        nvim = {
          lsp = {
            completion_item = item,
          }
        }
      },
    }
    table.insert(result, completion_item)
  end
  return result
end

M.find_completion_base_word = function()
  local start = util.get_completion_start()
  if start < 0 then
    return nil
  else
    local line = vim.api.nvim_get_current_line()
    return string.sub(line, start + 1, vim.fn.col('.') - 1)
  end
end

local edit_dist = function(w1, w2, insert_cost, delete_cost, substitude_cost)
  local dp = {}
  local n = #w1
  local m = #w2
  for i = 0, n do
    dp[i] = {}
    for j = 0, m do
      dp[i][j] = 0
    end
  end
  for i = 1, n do
    dp[i][0] = i
  end
  for j = 1, m do
    dp[0][j] = j
  end

  for i = 1, n do
    local c1 = string.sub(w1, i, i)
    for j = 1, m do
      local c2 = string.sub(w2, j, j)
      if c1 == c2 then
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = math.min(dp[i - 1][j] + delete_cost, dp[i][j - 1] + insert_cost, dp[i - 1][j - 1] + substitude_cost)
      end
    end
  end
  return dp[n][m]
end

local sort_completion_result = function(items, base)
  for _, item in pairs(items) do
    local word = item.insertText or item.filterText or item.label or item.sortText or ''
    item.sort_score = edit_dist(base, word, 1, 3, 1)
  end

  table.sort(items, function(a, b)
    if math.abs(a.sort_score - b.sort_score) <= 1 then
      return a.kind > b.kind
    end
    return a.sort_score < b.sort_score
  end)
  return items
end

M.show_completion = util.debounce(function()
  local base_word = M.find_completion_base_word()
  if base_word ~= nil then
    sort_completion_result(context.lsp.completion_items, base_word)
    local items = M.convert_completion_items(context.lsp.completion_items)
    if vim.fn.mode() == 'i' then
      vim.fn.complete(util.get_completion_start() + 1, items)
    end
  end
end, 10)

M.trigger_completion = util.debounce(function(bufnr)
  local params = vim.lsp.util.make_position_params()

  if util.has_lsp_capability(bufnr, 'completionProvider') then
    if context.lsp.cancel_func then
      pcall(context.lsp.cancel_func)
    end
    context.lsp.completion_items = {}
    context.lsp.cancel_func = vim.lsp.buf_request_all(bufnr, 'textDocument/completion', params, function(client_results)
      for _, client_result in pairs(client_results) do
        -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_completion
        -- the result could be CompletionItem[] | CompletionList | null
        local result = util.table_get(client_result, { 'result' }) or {}
        local items = util.table_get(result, { 'items' }) or result
        for _, item in pairs(items) do
          table.insert(context.lsp.completion_items, item)
        end
      end
      M.show_completion()
    end)
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
  context.lsp.completion_items = {}
end

M.auto_complete = function()
  local bufnr = vim.api.nvim_get_current_buf()
  M.trigger_completion(bufnr)
end

M.setup = function()
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
end

return M
