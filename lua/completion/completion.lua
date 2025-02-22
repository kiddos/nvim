local M = {}

local config = require('completion.config').get_config()
local util = require('completion.util')

local CompletionTriggerKind = {
  Invoked = 1,
  TriggerCharacter = 2,
  TriggerForIncompleteCompletions = 3,
}

local context = {
  lsp = {
    completion_items = {},
    request_ids = {},
  },
}

local get_completion_word = function(completion_item)
  return util.table_get(completion_item, { 'textEdit', 'newText' }) or completion_item.insertText or
      completion_item.label or ''
end

local get_documentation = function(completion_item)
  -- documentation could be string | MarkupContent
  local doc = util.table_get(completion_item, { 'documentation' })
  if not doc then
    return ''
  end

  if type(doc) == 'string' then
    return doc
  end

  if type(doc) == 'table' then
    return util.table_get(doc, { 'value' })
  end

  return ''
end

local convert_completion_items = function(items)
  if vim.tbl_count(items) == 0 then
    return {}
  end

  local result = {}
  for _, item in pairs(items) do
    local word = get_completion_word(item)
    local completion_item = {
      word = word,
      abbr = util.trim_long_text(item.label, config.completion.abbr_max_len),
      kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'Unknown',
      menu = util.trim_long_text(item.detail or '', config.completion.menu_max_len),
      info = get_documentation(item),
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

local get_completion_start = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local line_to_cursor = line:sub(1, pos[2])
  local start = -1
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr });
  for _, client in pairs(clients) do
    local triggers = util.table_get(client, { 'server_capabilities', 'completionProvider', 'triggerCharacters' })
    if triggers then
      for _, trigger_char in pairs(triggers) do
        local result = util.find_last(line_to_cursor, trigger_char)
        if result then
          start = math.max(start, result)
        end
      end
    end
  end

  local result = vim.fn.match(line_to_cursor, '\\w*$')
  if result <= pos[2] then
    start = math.max(start, result)
  end
  return start
end

local find_completion_base_word = function()
  local start = get_completion_start()
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

local compute_item_score = function(items, base)
  for _, item in pairs(items) do
    local word = item.insertText or item.filterText or item.label or item.sortText or ''
    item.sort_score = edit_dist(base, word,
      config.completion.insert_cost, config.completion.delete_cost, config.completion.substitude_cost)
  end
end

local filter_completion_item = function(items)
  local filtered = {}
  for _, item in pairs(items) do
    local word = item.insertText or item.filterText or item.label or item.sortText or ''
    local matched = #word - item.sort_score
    if matched >= config.completion.edit_dist then
      table.insert(filtered, item)
    end
  end
  return filtered
end

local sort_completion_result = function(items)
  table.sort(items, function(a, b)
    if math.abs(a.sort_score - b.sort_score) <= config.completion.dist_difference then
      return (a.kind or 0) > (b.kind or 0)
    end
    return a.sort_score < b.sort_score
  end)
  return items
end

M.show_completion = util.debounce(function()
  local base_word = find_completion_base_word()
  if base_word ~= nil then
    compute_item_score(context.lsp.completion_items, base_word)
    if #base_word > 0 then
      context.lsp.completion_items = filter_completion_item(context.lsp.completion_items)
    end
    sort_completion_result(context.lsp.completion_items)

    local items = convert_completion_items(context.lsp.completion_items)
    if vim.fn.mode() == 'i' then
      vim.fn.complete(get_completion_start() + 1, items)
    end
  end
end, 10)

local make_completion_request_param = function(trigger_kind)
  local params = vim.lsp.util.make_position_params()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local trigger_char = string.sub(line, col, col)
  params.context = {
    triggerKind = trigger_kind,
    triggerCharacter = trigger_char,
  }
  return params
end

local could_trigger = function(client, cursor_char)
  if cursor_char:match("^[-%w_]+$") ~= nil then
    return true
  end
  local triggers = util.table_get(client, { 'server_capabilities', 'completionProvider', 'triggerCharacters' })
  if triggers and util.contains(triggers, cursor_char) then
    return true
  end
  return false
end

M.trigger_completion = util.debounce(function(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  context.lsp.completion_items = {}

  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local cursor_char = line:sub(pos[2], pos[2])

  for _, client in pairs(clients) do
    if util.table_get(client, { 'server_capabilities', 'completionProvider' }) then
      if could_trigger(client, cursor_char) then
        if context.lsp.request_ids[client.id] then
          client.cancel_request(context.lsp.request_ids[client.id])
          context.lsp.request_ids[client.id] = nil
        end

        local params = make_completion_request_param(CompletionTriggerKind.TriggerCharacter)
        local result, request_id = client.request('textDocument/completion', params, function(err, client_result, _, _)
          if not err then
            local items = util.table_get(client_result, { 'items' }) or client_result
            if items then
              for _, item in pairs(items) do
                table.insert(context.lsp.completion_items, item)
              end
            end
            M.show_completion()
          end
        end, bufnr)
        if result then
          context.lsp.request_ids[client.id] = request_id
        end
      end
    end
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
  else
    return cr
  end
end

M.stop_completion = function()
  for client_id, request_id in pairs(context.lsp.request_ids) do
    local client = vim.lsp.get_client_by_id(client_id)
    if client and request_id then
      client.cancel_request(request_id)
      context.lsp.request_ids[client_id] = nil
    end
  end
  context.lsp.completion_items = {}
end

M.auto_complete = function()
  local bufnr = vim.api.nvim_get_current_buf()
  M.trigger_completion(bufnr)
end

M.setup = function()
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
