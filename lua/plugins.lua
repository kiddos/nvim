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

  -- prettier
  use { 'prettier/vim-prettier', run = 'yarn install' }
  -- tabline
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- tmux
  use 'edkolev/tmuxline.vim'
  use 'christoomey/vim-tmux-navigator'
  use 'benmills/vimux'

  -- opengl
  use 'tikhomirov/vim-glsl'
  use 'beyondmarc/hlsl.vim'
  -- protobuf
  use 'kiddos/vim-protobuf'
  -- clang-format
  use 'rhysd/vim-clang-format'

  -- python
  use 'tell-k/vim-autopep8'
  use 'Vimjas/vim-python-pep8-indent'

  use 'elzr/vim-json'
  use 'leafgarland/typescript-vim'
  use 'pangloss/vim-javascript'
  use 'MaxMEllon/vim-jsx-pretty'
  use 'peitalin/vim-jsx-typescript'

  -- go
  use 'fatih/vim-go'

  -- vhdl
  use 'kiddos/vim-vhdl'

  -- ruby
  use 'vim-ruby/vim-ruby'

  -- php
  use 'stanangeloff/php.vim'

  -- html
  use 'othree/html5.vim'

  -- markdown
  use 'tpope/vim-markdown'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }

  -- css
  use 'ap/vim-css-color'
  use 'hail2u/vim-css3-syntax'
  use 'groenewege/vim-less'
  use '1995eaton/vim-better-css-completion'
  use 'othree/csscomplete.vim'

  -- julia
  use 'JuliaEditorSupport/julia-vim'

  -- rust
  use 'rust-lang/rust.vim'

  -- dart
  use 'dart-lang/dart-vim-plugin'
end)
