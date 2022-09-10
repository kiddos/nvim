require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'cuda',
    'cmake',
    'dart',
    'go',
    'lua',
    'rust',
    'python',
    'julia',
    'java',
    'javascript',
    'typescript',
    'json',
    'tsx',
    'html',
    'css',
    'sql',
    'yaml',
    'vim'
  },
  indent = {
    enable = true,
    disable = {'vim'}
  },
  -- ignore_install = { 'javascript', 'html', 'css', 'vim' },
  highlight = {
    enable = true,
    disable = {'webmacro'},
    additional_vim_regex_highlighting = false,
  },
}

vim.o.foldenable = false
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'bash', 'zsh', 'vim'},
  command = 'setlocal foldmethod=marker',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'bash', 'zsh'},
  command = 'setlocal foldmarker={,}',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'vim'},
  command = 'setlocal foldmarker={{{,}}}',
})
