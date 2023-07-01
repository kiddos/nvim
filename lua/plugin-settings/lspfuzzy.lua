local M = {}

M.setup = function()
  require('lspfuzzy').setup{
    save_last = true,
  }

  vim.api.nvim_set_keymap('n', '<Leader><Leader>d', ':LspDiagnosticsAll<CR>', {noremap=true, silent=true})
end

return M
