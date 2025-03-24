return {
  'mattn/emmet-vim',
  ft = { 'html', 'javascript', 'jsp' },
  config = function()
    vim.api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')
    vim.api.nvim_set_var('user_emmet_settings', {
      jsp = {
        indentation = '  ',
      }
    })
  end,
}
