return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  -- lsp
  use 'neovim/nvim-lspconfig'
  -- completion
  use 'hrsh7th/nvim-compe'
  -- status line
  use 'hoob3rt/lualine.nvim'
  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- markdonw preview
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }
  -- prettier
  use { 'prettier/vim-prettier', run = 'yarn install' }
  -- tabline
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
end)
