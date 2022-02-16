return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'nvim-lua/lsp-status.nvim',
      'onsails/lspkind-nvim',
      'tami5/lspsaga.nvim',
      'hrsh7th/nvim-compe', -- completion
      'kyazdani42/nvim-web-devicons',
      'folke/trouble.nvim',
      'windwp/nvim-autopairs', -- auto pairs
      'hoob3rt/lualine.nvim', -- status line
    },
  }
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  -- tabline
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
  }

  -- color scheme
  use {
    'kiddos/malokai.vim',
    config = function()
      vim.api.nvim_command('set background="dark"')
      vim.api.nvim_command('syntax enable')
      vim.api.nvim_command('syntax on')
      vim.api.nvim_command('colorscheme malokai')
    end
  }
  -- use {
  --   'kaicataldo/material.vim',
  --   branch = 'main',
  --   config = function()
  --     vim.api.nvim_command('set termguicolors')
  --     vim.api.nvim_command('let $NVIM_TUI_ENABLE_TRUE_COLOR = 1')
      
  --     vim.api.nvim_command('syntax enable')
  --     vim.api.nvim_command('syntax on')
  --     vim.api.nvim_command('let g:material_theme_style = "darker"')
  --     vim.api.nvim_command('colorscheme material')
  --   end
  -- }
  -- use {
  --   'tomasr/molokai',
  --   config = function()
  --     vim.api.nvim_command('set termguicolors')
  --     vim.api.nvim_command('syntax enable')
  --     vim.api.nvim_command('syntax on')
  --     vim.api.nvim_command('colorscheme molokai')
  --   end
  -- }

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
  use 'christoomey/vim-tmux-navigator'
  use 'benmills/vimux'

  -- utility
  use {
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'},
    requires = {'Xuyuanp/nerdtree-git-plugin'},
  }
  use 'scrooloose/nerdcommenter'
  use 'ryanoasis/vim-devicons'
  use {
    'arecarn/crunch.vim',
    requires = {'arecarn/selection.vim'},
    cmd = {'Crunch'}
  }
  use {
    'prettier/vim-prettier',
    run = 'yarn install',
    -- ft = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
    cmd = 'Prettier',
  }
  use {
    'kiddos/a.vim',
    cmd = {'A'}
  }
  use {
    'tpope/vim-eunuch',
    cmd = {'Delete', 'Unlink', 'Remove', 'Move', 'Rename', 'Chmod', 'Mkdir'}
  }
  use 'tpope/vim-surround'
  use 'mattn/emmet-vim'
  use 'dense-analysis/ale'
  use 'mhinz/vim-startify'
  use {
    'junegunn/fzf.vim',
    requires = {'junegunn/fzf'},
    run = ':call fzf#install()',
  }
  use {
    'edkolev/tmuxline.vim',
    requires = {'vim-airline/vim-airline', 'vim-airline/vim-airline-themes'}
  }
  use {
    'Shougo/neosnippet.vim',
    requires = {'kiddos/snippets.vim'}
  }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use 'github/copilot.vim'
  

  -- language specific
  -- opengl
  use {
    'tikhomirov/vim-glsl',
    ft = {'glsl'}
  }
  use {
    'beyondmarc/hlsl.vim',
    ft = {'glsl'}
  }
  -- protobuf
  use {
    'kiddos/vim-protobuf',
    ft = {'proto'}
  }
  -- clang-format
  use {
    'rhysd/vim-clang-format',
    ft = {'c', 'cpp', 'javascript'},
    cmd = {'ClangFormat'},
  }
  -- python
  use {
    'tell-k/vim-autopep8',
    ft = {'python'},
  }
  use {
    'Vimjas/vim-python-pep8-indent',
    ft = {'python'}
  }
  -- javascript
  use 'pangloss/vim-javascript'
  use {
    'MaxMEllon/vim-jsx-pretty',
    config = function()
      vim.api.nvim_set_var('vim_jsx_pretty_enable_jsx_highlight', false)
    end
  }
  use 'leafgarland/typescript-vim'
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
    ft = {'markdown'},
    cmd = 'MarkdownPreview',
  }
  -- css
  use 'ap/vim-css-color'
  use 'hail2u/vim-css3-syntax'
  use 'groenewege/vim-less'
  -- julia
  use 'JuliaEditorSupport/julia-vim'
  -- rust
  use 'rust-lang/rust.vim'
  -- dart
  use {
    'akinsho/flutter-tools.nvim',
    requires = 'plenary.nvim',
  }

  -- games
  use {
    'alec-gibson/nvim-tetris',
    cmd = {'Tetris'}
  }
end)
