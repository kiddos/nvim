local api = vim.api

return {
  'mattn/emmet-vim',
  ft = { 'html', 'javascript', 'jsp' },
  config = function()
    api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')
    api.nvim_set_var('user_emmet_settings', {
      jsp = {
        indentation = '  ',
      }
    })
  end,
}
