local api = vim.api

local config = function()
  require("nvim-tree").setup()
  local tree_api = require('nvim-tree.api').tree
  local modes = { 'n', 'i', 's', 'v' }
  for _, mode in pairs(modes) do
    vim.api.nvim_set_keymap(mode, '<F1>', '', {
      noremap = true,
      silent = true,
      callback = function()
        tree_api.toggle()
      end
    })
  end

  local groups = {
    NvimTreeFolderIcon = { link = 'Directory' },
    NvimTreeFolderName = { link = 'Normal' },
    NvimTreeEmptyFolderName = { link = 'Comment' },
    NvimTreeOpenedFolderName = { link = 'Normal' },
    NvimTreeSymlinkFolderName = { link = 'Normal' },
  }

  for group, value in pairs(groups) do
    api.nvim_set_hl(0, group, value)
  end
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = { '<F1>' },
  config = config,
}
