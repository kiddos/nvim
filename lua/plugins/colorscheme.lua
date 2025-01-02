return {
  'kiddos/malokai.vim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('malokai')
    vim.api.nvim_set_option_value('termguicolors', true, {})
  end
}
