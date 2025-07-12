local api = vim.api

local config = function()
  require('Comment').setup({
    mappings = {
      basic = false,
      extra = false,
    }
  })

  local ft = require('Comment.ft')
  ft.webmacro = '## %s'
  ft.jsp = '<%-- %s --%>'

  api.nvim_set_keymap('n', '<leader>cc', '<Plug>(comment_toggle_linewise_current)', {})
  api.nvim_set_keymap('n', '<leader>cu', '<Plug>(comment_toggle_linewise_current)', {})
  api.nvim_set_keymap('v', '<leader>cc', '<Plug>(comment_toggle_linewise_visual)', {})
  api.nvim_set_keymap('v', '<leader>cu', '<Plug>(comment_toggle_linewise_visual)', {})
end

return {
  'numToStr/Comment.nvim',
  event = { 'ModeChanged' },
  keys = { '<leader>cc', '<leader>cu' },
  config = config,
}
