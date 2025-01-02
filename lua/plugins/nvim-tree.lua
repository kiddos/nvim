return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = { '<F1>' },
  config = function()
    require("nvim-tree").setup()
    local tree_api = require('nvim-tree.api').tree
    local modes = { 'n', 'i' }
    for _, mode in pairs(modes) do
      vim.api.nvim_set_keymap(mode, '<F1>', '', {
        noremap = true,
        silent = true,
        callback = function()
          tree_api.toggle()
        end
      })
    end
  end,
}
