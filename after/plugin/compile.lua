local register_command = function(filetype, key, command)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetype,
    callback = function()
      local current = vim.api.nvim_get_current_buf()

      vim.api.nvim_buf_create_user_command(current, 'Compile', command, {
        force = true,
        desc = 'compile code',
      })

      local modes = { 'n', 'i' }
      for _, mode in pairs(modes) do
        vim.api.nvim_buf_set_keymap(current, mode, key, '', {
          silent = true,
          noremap = true,
          desc = 'compile code',
          callback = function()
            vim.api.nvim_command(command)
          end
        })
      end
    end,
  })
end

local key = '<C-F9>'

register_command({ 'c', 'cpp' }, key, '!clang++ % -Wall -Wextra -Wshadow -std=c++20 -fsanitize=address -O1 -g -o %:r')
register_command({ 'rust' }, key, '!rustc %')
register_command({ 'cuda' }, key, '!nvcc % -o %:r &')
register_command({ 'java' }, key, '!javac % &')
register_command({ 'kotlin' }, key, '!kotlinc % -include-runtime -d %:r.jar')
