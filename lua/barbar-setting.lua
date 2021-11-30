return {
  setup = function()
    vim.g.bufferline = {
      icon_custom_colors = true,
      maximum_padding = 2,
    }
    -- vim.api.nvim_set_keymap('n', '<A-,>', ':BufferPrevious<CR>', {silent=true, noremap=true})
    -- vim.api.nvim_set_keymap('n', '<A-.>', ':BufferNext<CR>', {silent=true, noremap=true})
    -- Re-order to previous/next
    vim.api.nvim_set_keymap('n', '<A-Left>', ':BufferMovePrevious<CR>', {silent=true, noremap=true})
    vim.api.nvim_set_keymap('n', '<A-Right>', ':BufferMoveNext<CR>', {silent=true, noremap=true})
    -- Goto buffer in position...
    for i = 1,9,1 do
      vim.api.nvim_set_keymap('n', string.format('<Leader>%d', i), string.format(':BufferGoto %d<CR>', i), {silent=true, noremap=true})
    end
    vim.api.nvim_set_keymap('n', '<Leader>0', ':BufferLast<CR>', {silent=true, noremap=true})
    -- Close buffer
    vim.api.nvim_set_keymap('n', '<Leader><Leader>c', ':BufferClose<CR>', {silent=true, noremap=true})
    vim.api.nvim_set_keymap('n', '<Leader><Leader><Space>', ':BufferCloseAllButCurrent<CR>', {silent=true, noremap=true})
    vim.api.nvim_set_keymap('n', '<Leader><Leader>s', ':BufferPick<CR>', {silent=true, noremap=true})
    -- Wipeout buffer
    -- :BufferWipeout<CR>
    -- Close commands
    -- :BufferCloseAllButCurrent<CR>
    -- :BufferCloseBuffersLeft<CR>
    -- :BufferCloseBuffersRight<CR>
    -- Magic buffer-picking mode
    -- nnoremap <silent> <C-s>    :BufferPick<CR>
    -- Sort automatically by...
    -- nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
    -- nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
  end
}
