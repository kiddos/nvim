local severity = vim.diagnostic.severity
local api = vim.api

local config = function()
  require('barbar').setup {
    animation = false,
    auto_hide = false,
    icons = {
      filetype = {
        enabled = true,
        custom_colors = true,
      },
      button = '✕',
      diagnostics = {
        [severity.ERROR] = { enabled = true, icon = 'Ⓧ' },
        [severity.HINT] = { enabled = true, icon = '💡' },
        [severity.INFO] = { enabled = true, icon = 'ⓘ ' },
        [severity.WARN] = { enabled = true, icon = '⚠️' },
      }
    },
    maximum_padding = 1,
  }
  local opts = { silent = true, noremap = true }
  -- Re-order to previous/next
  api.nvim_set_keymap('n', '<A-Left>', ':BufferMovePrevious<CR>', opts)
  api.nvim_set_keymap('n', '<A-Right>', ':BufferMoveNext<CR>', opts)

  for i = 1, 9, 1 do
    local key = string.format('<Leader>%d', i)
    local command = string.format(':BufferGoto %d<CR>', i)
    api.nvim_set_keymap('n', key, command, opts)
  end

  api.nvim_set_keymap('n', '<Leader>0', ':BufferLast<CR>', opts)
  -- Close buffer
  api.nvim_set_keymap('n', '<Leader><Leader>c', ':BufferClose<CR>', opts)
end

return {
  'romgrk/barbar.nvim',
  dependencies = {
    { 'lewis6991/gitsigns.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = config
}
