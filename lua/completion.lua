local compe = require('compe')
compe.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'always',
  throttle_time = 60,
  source_timeout = 300,
  resolve_timeout = 600,
  incomplete_delay = 600,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  source = {
    path = true,
    buffer = {
      ignored_filetypes = {'json', 'text', ''}
    },
    calc = false,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = false,
    ultisnips = false,
    luasnip = false,
  },
}

vim.api.nvim_command('augroup completion')
vim.api.nvim_command("autocmd FileType dart let g:compe={}")
vim.api.nvim_command("autocmd FileType dart let g:compe.preselect = 'enable'")
vim.api.nvim_command('augroup END')

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {expr=true, noremap=true, silent=true})
vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm("<CR>")', {expr=true, noremap=true})
