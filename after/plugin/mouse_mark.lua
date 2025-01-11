local mark_vars = {
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
  'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
}

local context = {
  index = 1
}

local can_remove = function(mark)
  for _, var in ipairs(mark_vars) do
    if var == mark then
      return true
    end
  end
  return false
end

local get_currentline_marks = function()
  local current_line = vim.fn.line('.')
  local current_buf = vim.api.nvim_get_current_buf()
  local marks = vim.fn.getmarklist(current_buf)
  local found = {}
  for _, mark in ipairs(marks) do
    local m = string.sub(mark.mark, 2)
    if mark.pos[2] == current_line and can_remove(m) then
      table.insert(found, m)
    end
  end
  return found
end

local set_mark = function()
  local m = mark_vars[context.index]
  context.index = context.index + 1
  if context.index > #mark_vars then
    context.index = 1
  end
  vim.cmd('mark ' .. m)
  local current_line = vim.fn.line('.')
  print("Mark set at line: " .. current_line)
end

vim.api.nvim_set_keymap('n', '<2-LeftMouse>', '', {
  noremap = true,
  silent = true,
  callback = function()
    local mouse_pos = vim.fn.getmousepos() -- Get the mouse position
    vim.api.nvim_win_set_cursor(0, { mouse_pos.line, mouse_pos.column - 1 })

    local marks = get_currentline_marks()
    if #marks > 0 then
      print('removing marks: ' .. vim.inspect(marks))
      for _, mark in ipairs(marks) do
        vim.cmd('delmark ' .. mark)
      end
    else
      set_mark()
    end
  end
})
