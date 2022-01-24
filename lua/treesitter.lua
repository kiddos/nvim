require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  indent = {
    enable = false,
  },
  highlight = {
    enable = true,
    disable = {'javascript', 'html', 'css', 'vim'},
    additional_vim_regex_highlighting = false,
  },
}

vim.o.foldenable = false
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.api.nvim_command('autocmd FileType bash,zsh setlocal foldmethod=marker')
vim.api.nvim_command('autocmd FileType bash,zsh setlocal foldmarker={,}')
vim.api.nvim_command('autocmd FileType vim setlocal foldmethod=marker')
vim.api.nvim_command('autocmd FileType vim setlocal foldmarker={{{,}}}')
