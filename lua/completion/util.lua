local util = {}

util.str_trim = function(s)
  return string.gsub(s, "^%s*(.-)%s*$", "%1")
end

util.trim_long_text = function(text, width)
  if not text then
    text = ''
  end
  text = util.str_trim(text)
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

util.find_last = function(s, pattern)
  if not s or not pattern then
    return nil
  end

  local last_index = nil
  local p = 0
  while true do
    local p2 = string.find(s, pattern, p + 1, true)
    if p2 then
      if type(p2) == 'table' then
        last_index = p2[1]
        p = p2[1]
      else
        last_index = p2
        p = p2
      end
    else
      break
    end
  end
  return last_index
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

util.get_left_non_space_char = function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  while col >= 0 do
    local char = string.sub(line, col, col)
    if char ~= ' ' then
      return char
    end
    col = col - 1;
  end
  return ''
end

util.is_lsp_trigger = function(char, type)
  local providers = {
    completion = 'completionProvider',
    signature = 'signatureHelpProvider',
  }

  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in pairs(clients) do
    local triggers = util.table_get(client, { 'server_capabilities', providers[type], 'triggerCharacters' }) or {}
    if vim.tbl_contains(triggers, char) then
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

  local win = vim.api.nvim_open_win(container.buffer, false, opts)
  vim.api.nvim_set_option_value('linebreak', true, { win = win })
  vim.api.nvim_set_option_value('breakindent', false, { win = win })
  container.window = win
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

util.debounce = function(callback, timeout)
  local timer = nil
  local f = function(...)
    local t = { ... }
    local handler = function()
      callback(unpack(t))
    end

    if timer ~= nil then
      timer:stop()
    end
    timer = vim.defer_fn(handler, timeout)
  end
  return f
end

util.throttle = function(callback, timeout)
  local timer = nil
  local f = function(...)
    local t = { ... }
    if timer ~= nil then
      return
    end

    timer = vim.defer_fn(function()
      callback(unpack(t))
      timer = nil
    end, timeout)
  end
  return f
end

util.contains = function(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

return util
