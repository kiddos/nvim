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

register_command({ 'c', 'cpp' }, '<C-F9>', '!clang++ % -Wall -Wextra -std=c++20 -fsanitize=address -O1 -g -o %:r')
register_command({ 'rust' }, '<C-F9>', '!rustc %')
register_command({ 'cuda' }, '<C-F9>', '!nvcc % -o %:r &')
register_command({ 'java' }, '<C-F9>', '!javac % &')
register_command({ 'kotlin' }, '<C-F9>', '!kotlinc % -include-runtime -d %:r.jar')
