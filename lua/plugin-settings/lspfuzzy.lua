local M = {}

M.setup = function()
  local lspfuzzy = require('lspfuzzy')
  lspfuzzy.setup({
    save_last = true,
  })
  vim.api.nvim_set_keymap('n', '<Leader><Leader>d', '', {
    noremap = true,
    silent = false,
    callback = lspfuzzy.diagnostics_all
  })
end

return M
