local config = require('completion.config')

local util = {}

util.trim_long_text = function(text, width)
  if not text then
    text = ''
  end
  if #text > width then
    return string.sub(text, 1, width + 1) .. '...'
  end
  return text
end

util.table_get = function(t, id)
  if type(id) ~= 'table' then return util.table_get(t, { id }) end
  local success, res = true, t
  for _, i in ipairs(id) do
    success, res = pcall(function() return res[i] end)
    if not success or res == nil then return end
  end
  return res
end

util.in_table = function(t, key)
  for _, value in pairs(t) do
    if value == key then
      return true
    end
  end
  return false
end

util.has_lsp_capability = function(capability)
  local clients = vim.lsp.buf_get_clients()
  if vim.tbl_isempty(clients) then
    return false
  end
  if not capability then
    return true
  end

  for _, c in pairs(clients) do
    local has_capability = util.table_get(c.server_capabilities, capability)
    if has_capability then
      return true
    end
  end
  return false
end

util.get_completion_start = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local line_to_cursor = line:sub(1, pos[2])
  return vim.fn.match(line_to_cursor, '\\k*$')
end

util.process_lsp_response = function(request_result, processor)
  if not request_result then return {} end

  local res = {}
  for client_id, item in pairs(request_result) do
    if not item.err and item.result then vim.list_extend(res, processor(item.result, client_id) or {}) end
  end
  return res
end

util.get_completion_word = function(item)
  return util.table_get(item, { 'textEdit', 'newText' }) or item.insertText or item.label or ''
end

util.filter_lsp_result = function(items, base)
  return vim.tbl_filter(function(item)
    return vim.startswith(util.get_completion_word(item), base) and item.kind ~= 15
  end, items)
end

util.sort_lsp_result = function(items)
  table.sort(items, function(a, b) return (a.sortText or a.label) < (b.sortText or b.label) end)
  return items
end

util.lsp_completion_response_items_to_complete_items = function(items, client_id)
  if vim.tbl_count(items) == 0 then return {} end

  local res = {}
  local docs, info
  for _, item in pairs(items) do
    -- Documentation info
    docs = item.documentation
    info = util.table_get(docs, { 'value' })
    if not info and type(docs) == 'string' then info = docs end
    info = info or ''

    table.insert(res, {
      word = util.get_completion_word(item),
      abbr = util.trim_long_text(item.label, config.completion.abbr_max_len),
      kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'Unknown',
      menu = util.trim_long_text(item.detail or '', config.completion.menu_max_len),
      info = info,
      icase = 1,
      dup = 1,
      empty = 1,
      user_data = {
        nvim = {
          lsp = {
            completion_item = item,
            source = 'lsp',
            client_id = client_id,
          }
        }
      },
    })
  end
  return res
end

util.buffer_result_to_complete_items = function(words, base)
  local res = {}
  for word, _ in pairs(words) do
    if vim.startswith(word, base) then
      table.insert(res, {
        word = word,
        abbr = word,
        kind = '\u{1F5D2}',
        menu = '',
        info = word,
        icase = 1,
        dup = 1,
        empty = 1,
      })
    end
  end
  return res
end

util.create_buffer = function(container, name)
  if container.buffer then
    return
  end

  container.buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(container.buffer, name)
  vim.fn.setbufvar(container.buffer, '&buftype', 'nofile')
end

util.get_left_char = function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return string.sub(line, col, col)
end

util.is_lsp_trigger = function(char, type)
  local triggers
  local providers = {
    completion = 'completionProvider',
    signature = 'signatureHelpProvider',
  }

  for _, client in pairs(vim.lsp.buf_get_clients()) do
    triggers = util.table_get(client, { 'server_capabilities', providers[type], 'triggerCharacters' })
    if vim.tbl_contains(triggers or {}, char) then
      return true
    end
  end
  return false
end

util.is_whitespace = function(s)
  if type(s) == 'string' then return s:find('^%s*$') end
  if type(s) == 'table' then
    for _, val in pairs(s) do
      if not util.is_whitespace(val) then return false end
    end
    return true
  end
  return false
end

util.floating_dimensions = function(lines, max_height, max_width)
  local height = math.min(#lines, max_height)

  -- Width is a maximum width of the first `height` wrapped lines truncated to
  -- maximum width
  local width = 0
  local l_width
  for i, l in ipairs(lines) do
    -- Use `strdisplaywidth()` to account for 'non-UTF8' characters
    l_width = vim.fn.strdisplaywidth(l)
    if i <= height and width < l_width then width = l_width end
  end
  -- It should already be less that that because of wrapping, so this is "just
  -- in case"
  width = math.min(width, max_width)

  return height, width
end

util.open_action_window = function(container, opts)
  if container.window then
    util.close_action_window(container)
  end

  container.window = vim.api.nvim_open_win(container.buffer, false, opts)
  vim.api.nvim_win_set_option(container.window, 'linebreak', true)
  vim.api.nvim_win_set_option(container.window, 'breakindent', false)
end

util.close_action_window = function(container)
  if container.window then
    vim.api.nvim_win_close(container.window, true)
  end
  container.window = nil

  if container.buffer then
    vim.fn.setbufvar(container.buffer, '&buftype', 'nofile')
  end
end

util.get_words = function(line)
  local words = {}
  local buffer = line
  local pattern = vim.regex('\\%(-\\?\\d\\+\\%(\\.\\d\\+\\)\\?\\|\\h\\w*\\%(-\\w*\\)*\\)')
  while true do
    local s, e = pattern:match_str(buffer)
    if s then
      local word = string.sub(buffer, s + 1, e)
      if #word > 3 and string.sub(word, #word) ~= '-' then
        table.insert(words, word)
      end
    end
    local new_buffer = string.sub(buffer, e and e + 1 or 2)
    if buffer == new_buffer then
      break
    end
    buffer = new_buffer
  end
  return words
end

util.is_slash_comment = function(_)
  local commentstring = vim.bo.commentstring or ''
  local no_filetype = vim.bo.filetype == ''
  local is_slash_comment = false
  is_slash_comment = is_slash_comment or commentstring:match('/%*')
  is_slash_comment = is_slash_comment or commentstring:match('//')
  return is_slash_comment and not no_filetype
end

util.get_current_dirname = function()
  local name_pattern = [[\%([^/\\:\*?<>'"`\|]\)]]
  local dir_regex = vim.regex(([[\%(/PAT\+\)*\ze/PAT*$]]):gsub('PAT', name_pattern))
  local current_line = vim.api.nvim_get_current_line()
  local s, e = dir_regex:match_str(current_line)
  if not s then
    return nil
  end

  local dirname = string.sub(current_line, s + 1, e)
  local prefix = string.sub(current_line, 1, s + 1)
  local current_buffer = vim.api.nvim_get_current_buf()
  local buf_dirname = vim.fn.expand(('#%d:p:h'):format(current_buffer))
  if prefix:match('%.%./$') then
    return vim.fn.resolve(buf_dirname .. '/../' .. dirname)
  elseif prefix:match('%./$') then
    return vim.fn.resolve(buf_dirname .. '/' .. dirname)
  elseif prefix:match('~/$') then
    return vim.fn.expand('~/' .. dirname)
  elseif prefix:match('%$[%a_]+/$') then
    return vim.fn.expand(prefix:match('%$[%a_]+/$') .. dirname)
  elseif prefix:match('/$') then
    local accept = true
    -- Ignore URL components
    accept = accept and not prefix:match('%a/$')
    -- Ignore URL scheme
    accept = accept and not prefix:match('%a+:/$') and not prefix:match('%a+://$')
    -- Ignore HTML closing tags
    accept = accept and not prefix:match('</$')
    -- Ignore math calculation
    accept = accept and not prefix:match('[%d%)]%s*/$')
    -- Ignore / comment
    accept = accept and (not prefix:match('^[%s/]*$') or not util.is_slash_comment())
    if accept then
      return vim.fn.resolve('/' .. dirname)
    end
  end
  return nil
end

util.scan_directory = function(dirname)
  local fs, err = vim.loop.fs_scandir(dirname)
  if err then
    return nil
  end

  local items = {}

  while true do
    local name, type, e = vim.loop.fs_scandir_next(fs)
    if e then
      return items
    end
    if not name then
      break
    end

    local accept = false
    accept = accept or name:sub(1, 1) ~= '.'

    -- Create items
    if accept then
      if type == 'directory' then
        table.insert(items, {
          word = name,
          abbr = '/' .. name,
          kind = '\u{1F4C1}',
          menu = 'Dir',
          info = 'Directory',
          icase = 1,
          dup = 1,
          empty = 1,
        })
      elseif type == 'link' then
        local stat = vim.loop.fs_stat(dirname .. '/' .. name)
        if stat then
          if stat.type == 'directory' then
            table.insert(items, {
              word = name,
              abbr = '/' .. name,
              kind = '\u{1F4C1}',
              menu = 'Dir*',
              info = 'Directory Link',
              icase = 1,
              dup = 1,
              empty = 1,
            })
          else
            table.insert(items, {
              word = name,
              abbr = name,
              kind = '\u{1F4C2}',
              menu = 'File*',
              info = 'File Link',
              icase = 1,
              dup = 1,
              empty = 1,
            })
          end
        end
      else
        table.insert(items, {
          word = name,
          abbr = name,
          kind = '\u{1F4C2}',
          menu = 'File',
          info = 'File',
          icase = 1,
          dup = 1,
          empty = 1,
        })
      end
    end
  end
  return items
end

util.debounce = function(callback, timer, timeout)
  local state = 0
  local f = function(params)
    local handler = vim.schedule_wrap(function()
      if state ~= 0 then
        state = 0
        callback(params)
      end
    end)

    if state == 0 then
      state = 1
      timer:start(timeout, 0, handler)
    elseif state == 1 then
      timer:stop()
      timer:start(timeout, 0, handler)
    end
  end

  return f
end

return util
