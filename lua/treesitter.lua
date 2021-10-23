require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  indent = {
    enable = false
  },
  highlight = {
    enable = true,
    disable = {'javascript', 'html', 'css', 'vim'},
    additional_vim_regex_highlighting = false
  },
}
