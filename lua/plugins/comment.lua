local config = function()
  require('Comment').setup({
    mappings = {
      basic = false,
      extra = false,
    }
  })

  local ft = require('Comment.ft')
  ft.webmacro = '## %s'

  vim.api.nvim_set_keymap('n', '<leader>cc', '<Plug>(comment_toggle_linewise_current)', {})
  vim.api.nvim_set_keymap('n', '<leader>cu', '<Plug>(comment_toggle_linewise_current)', {})
  vim.api.nvim_set_keymap('v', '<leader>cc', '<Plug>(comment_toggle_linewise_visual)', {})
  vim.api.nvim_set_keymap('v', '<leader>cu', '<Plug>(comment_toggle_linewise_visual)', {})
  vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', {})
  vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', {})
end

return {
  'numToStr/Comment.nvim',
  event = 'VimEnter',
  config = config,
}
