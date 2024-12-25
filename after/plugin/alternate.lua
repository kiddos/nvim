local uv = vim.uv or vim.loop

local ALTERNATE_EXTENSIONS = {
  c = { 'h' },
  cpp = { 'h', 'hpp' },
  cc = { 'h', 'hpp' },
  h = { 'cpp', 'cc', 'c' },
  hpp = { 'cpp', 'cc' },
  html = { 'css' },
  css = { 'html', 'js' },
  js = { 'css' },
  jsx = { 'css' },
  ts = { 'html' },
}

local file_exists = function(filename)
  local stat = uv.fs_stat(filename)
  return stat and stat.type or false
end

local alternate_file = function()
  local current_path = vim.fn.expand('%:p')
  local current_extension = string.lower(vim.fn.fnamemodify(current_path, ':e'))
  local alternate_extensions = ALTERNATE_EXTENSIONS[current_extension]

  if not alternate_extensions or vim.tbl_isempty(alternate_extensions) then
    return
  end

  local find_alternate_file = function()
    local filename = vim.fn.expand('%:p:r')
    for _, ext in pairs(alternate_extensions) do
      local alternate_file = filename .. '.' .. ext
      if file_exists(alternate_file) then
        return alternate_file
      end
    end
    return filename .. '.' .. alternate_extensions[1]
  end

  local alternate_file = find_alternate_file()
  vim.api.nvim_command(':e ' .. alternate_file)
end


vim.api.nvim_create_user_command('A', alternate_file, { desc = 'Alternate files' })
vim.api.nvim_set_var('mapleader', ',')
vim.api.nvim_set_keymap('n', '<Leader><Leader>a', '', {
  silent = true,
  noremap = true,
  callback = alternate_file,
  desc = 'Alternate file',
})
