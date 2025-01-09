return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  config = function()
    require('marks').setup {
      default_mappings = false,
    }
    vim.api.nvim_set_keymap('n', '<Leader><Leader>m', ':MarksListAll<CR>', { silent = true })
  end
}
