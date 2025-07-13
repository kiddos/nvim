local api = vim.api

local config = function()
  require('hlslens').setup()

  local opts = { noremap = true, silent = true }
  api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    opts)
  api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    opts)
  api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
  api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
  api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
  api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)

  api.nvim_set_keymap('n', '<Leader>h', '<Cmd>noh<CR>', opts)

  local augroup = api.nvim_create_augroup("NoHlSearchOnWrite", { clear = true })
  api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = augroup,
    callback = function()
      vim.defer_fn(function()
        api.nvim_command('nohlsearch')
      end, 10)
    end,
    desc = "Clear search highlights after writing a buffer",
  })
end

return {
  'kevinhwang91/nvim-hlslens',
  event = 'VimEnter',
  config = config,
}
