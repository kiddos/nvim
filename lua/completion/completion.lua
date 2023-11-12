local M = {}

local uv = vim.uv or vim.loop

local config = require('completion.config')
local lru = require('completion.lru')
local util = require('completion.util')
local snippet = require('completion.snippet')

local context = {
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
  snippet = {
    result = nil,
  },
  special_chars = {},
}

M.index_buffer = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local num_lines = vim.api.nvim_buf_line_count(current_buf)
  local current_line = vim.api.nvim__buf_stats(0).current_lnum
  local lines = nil

  if num_lines > config.completion.buffer_max_lines then
    lines = vim.api.nvim_buf_get_lines(current_buf,
      math.max(0, current_line - config.completion.buffer_reindex_line_range),
      math.min(num_lines, current_line + config.completion.buffer_reindex_line_range), false)
  else
    lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
  end

  if lines then
    if not context.buffer.cache[current_buf] then
      context.buffer.cache[current_buf] = lru.create_lru(config.completion.buffer_lru_size)
    end

    local current_cache = context.buffer.cache[current_buf]
    for i = 1, #lines do
      local words = util.get_words(lines[i])
      for _, word in pairs(words) do
        current_cache:add_data(word)
      end
    end
    context.buffer.result[current_buf] = current_cache:get_keys()
  end
end

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

M.prepare_buffer_completion = util.throttle(function()
  M.index_buffer()
  context.snippet.result = snippet.load_snippets()
end, config.completion.delay)

M.word_emb = function(s)
  local counts = {}
  for i = 1, 256 do
    counts[i] = 0
  end
  for i = 1, #s do
    local c = string.byte(s, i)
    if c >= 1 and c <= 256 then
      counts[c] = counts[c] +  1
    end
  end
  for i = 1, 256 do
    counts[i] = counts[i] / 256.0
  end
  return counts
end

M.cosine_similarity = function(e1, e2)
  local x = 0
  for i = 1, 256 do
    x = x + e1[i] * e2[i]
  end
  return x
end

M.filter_lsp_result = function(items, base, threshold)
  local emb = M.word_emb(base)
  return vim.tbl_filter(function(item)
    -- if item.kind == 15 then
    --   return false
    -- end

    local word = util.get_completion_word(item)
    local e2 = M.word_emb(word)
    local c = M.cosine_similarity(emb, e2)
    return vim.startswith(word, base) or c >= threshold
  end, items)
end

M.prepare_completion_item = function(base_word)
  local result = {}
  if context.lsp.result then
    result = util.process_lsp_response(context.lsp.result, function(response, client_id)
      local items = util.table_get(response, { 'items' }) or response
      if type(items) ~= 'table' then return {} end
      items = M.filter_lsp_result(items, base_word, 0.8)
      util.sort_lsp_result(items)
      return util.lsp_completion_response_items_to_complete_items(items, client_id)
    end)
  end

  if context.file.result then
    for _, item in pairs(context.file.result) do
      if vim.startswith(item.word, base_word) then
        table.insert(result, item)
      end
    end
  end

  if context.snippet.result then
    for _, item in pairs(context.snippet.result) do
      if vim.startswith(item.word, base_word) then
        table.insert(result, item)
      end
    end
  end

  local current_buf = vim.api.nvim_get_current_buf()
  if context.buffer.result[current_buf] then
    local items = util.buffer_result_to_complete_items(context.buffer.result[current_buf], base_word)
    for _, item in pairs(items) do
      if vim.startswith(item.word, base_word) then
        table.insert(result, item)
      end
    end
  end

  return result
end

M.find_completion_base_word = function()
  if context.lsp.result == nil and
      context.buffer.result == nil and
      context.file.result == nil and
      context.snippet.result == nil then
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

M.trigger_completion = util.debounce(function(bufnr)
  M.scan_paths()

  if util.has_lsp_capability(bufnr, 'completionProvider') then
    local params = vim.lsp.util.make_position_params()
    context.lsp.cancel_func = vim.lsp.buf_request_all(bufnr, 'textDocument/completion', params, function(result)
      context.lsp.result = result
      M.show_completion()
    end)
  else
    M.show_completion()
  end
end, config.completion.delay)

M.confirm_completion = function()
  local cr = config.completion.cr_mapping ~= nil and config.completion.cr_mapping()
      or vim.api.nvim_replace_termcodes('<CR>', true, true, true)

  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'selected' }).selected ~= -1 then
    local char = util.get_left_char()
    if context.special_chars[char] ~= nil then
      return vim.api.nvim_replace_termcodes('<C-E>', true, true, true) .. cr
    else
      return vim.api.nvim_replace_termcodes('<C-Y>', true, true, true)
    end
  else
    return cr
  end
end

M.clear_cache = function(bufnr)
  context.buffer.cache[bufnr] = nil
end

M.stop_completion = function()
  if context.lsp.cancel_func then
    pcall(context.lsp.cancel_func)
  end
  context.lsp.cancel_func = nil

  context.lsp.result = nil
  context.file.result = nil
  context.snippet.result = nil
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
      M.prepare_buffer_completion()
      M.stop_completion()
    end
  })

  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    callback = M.prepare_buffer_completion,
  })

  vim.api.nvim_create_autocmd({ 'BufLeave' }, {
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      M.clear_cache(bufnr)
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
