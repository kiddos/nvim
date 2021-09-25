return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- new features
  -- lsp
  use 'neovim/nvim-lspconfig'
  -- completion
  use 'hrsh7th/nvim-compe'
  -- status line
  use 'hoob3rt/lualine.nvim'
  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- tabline
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }


  -- color scheme
  use 'kiddos/malokai.vim'
  use {
    'kaicataldo/material.vim',
    branch = 'main'
  }
  use 'tomasr/molokai'


  -- git
  use {
    'tpope/vim-fugitive',
    cmd = {'Git', 'Gread', 'Gwrite', 'GDelete', 'Ggrep', 'GMove', 'GBrowse', 'Gcommit'}
  }
  use {
    'airblade/vim-gitgutter',
    cmd = {'GitGutterToggle'}
  }
  use {
    'f-person/git-blame.nvim',
    cmd = {'GitBlameToggle'}
  }
  use {
    'sindrets/diffview.nvim',
    cmd = {'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh', 'DiffviewFileHistory'}
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }


  -- tmux
  use 'edkolev/tmuxline.vim'
  use 'christoomey/vim-tmux-navigator'
  use 'benmills/vimux'


  -- utility
  use {
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'}
  }
  use 'scrooloose/nerdcommenter'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'ryanoasis/vim-devicons'
  use {
    'arecarn/crunch.vim',
    requires = {'arecarn/selection.vim'}
  }
  use { 'prettier/vim-prettier', run = 'yarn install' }
  use 'kiddos/a.vim'
  use {
    'tpope/vim-eunuch',
    cmd = {'Delete', 'Unlink', 'Move', 'Rename', 'Chmod', 'Mkdir'}
  }
  use 'tpope/vim-surround'
  use 'mattn/emmet-vim'


  -- language specific
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
  -- javascript
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
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview'
  }
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

  -- games
  use 'ThePrimeagen/vim-be-good'
end)
