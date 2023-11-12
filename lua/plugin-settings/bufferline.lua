local M = {}

M.setup = function()
  local bufferline = require('bufferline')
  bufferline.setup({
    animation = false,
    auto_hide = false,
    icons = {
      filetype = {
        enabled = true,
        custom_colors = true,
      },
      pinned = {
        button = '📌',
      },
      button = '✕',
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'Ⓧ' },
        [vim.diagnostic.severity.HINT] = { enabled = true, icon = '💡' },
        [vim.diagnostic.severity.INFO] = { enabled = true, icon = 'ⓘ ' },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = '⚠️' },
      }
    },
    maximum_padding = 1,
  })

  vim.api.nvim_set_var('mapleader', ',')
  -- Re-order to previous/next
  vim.api.nvim_set_keymap('n', '<A-Left>', ':BufferMovePrevious<CR>', { silent = true, noremap = true })
  vim.api.nvim_set_keymap('n', '<A-Right>', ':BufferMoveNext<CR>', { silent = true, noremap = true })

  for i = 1, 9, 1 do
    vim.api.nvim_set_keymap('n', string.format('<Leader>%d', i), string.format(':BufferGoto %d<CR>', i),
      { silent = true, noremap = true })
  end

  -- Goto buffer in position...
  vim.api.nvim_set_keymap('n', '<Leader>0', ':BufferLast<CR>', { silent = true, noremap = true })
  -- Close buffer
  vim.api.nvim_set_keymap('n', '<Leader><Leader>c', ':BufferClose<CR>', { silent = true, noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader><Leader><Space>', ':BufferCloseAllButCurrent<CR>', { silent = true, noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader><Leader>s', ':BufferPick<CR>', { silent = true, noremap = true })

  -- Wipeout buffer
  -- :BufferWipeout<CR>
  -- Close commands
  -- :BufferCloseAllButCurrent<CR>
  -- :BufferCloseBuffersLeft<CR>
  -- :BufferCloseBuffersRight<CR>
  -- Magic buffer-picking mode nnoremap <silent> <C-s>    :BufferPick<CR>
  -- Sort automatically by...
  -- nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
  -- nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
end

return M
