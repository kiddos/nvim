return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'onsails/lspkind-nvim'
  use 'tami5/lspsaga.nvim'
  use {
    'gfanto/fzf-lsp.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
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
  use 'akinsho/git-conflict.nvim'

  -- tmux
  use 'christoomey/vim-tmux-navigator'
  use 'benmills/vimux'
  use {
    'edkolev/tmuxline.vim',
    requires = {'vim-airline/vim-airline', 'vim-airline/vim-airline-themes'}
  }

  -- utility
  use 'windwp/nvim-autopairs' -- auto pairs
  use 'hoob3rt/lualine.nvim' -- status line
  use 'kyazdani42/nvim-web-devicons' -- icons
  use 'gelguy/wilder.nvim' -- wild menu
  use 'chentoast/marks.nvim' -- use marks
  use 'gennaro-tedesco/nvim-peekup' -- peek register
  -- file browser
  use {
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'},
    requires = {'Xuyuanp/nerdtree-git-plugin', 'ryanoasis/vim-devicons'},
  }
  use 'scrooloose/nerdcommenter' -- comments
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }
  -- commands
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
  use 'mhinz/vim-startify'
  use {
    'junegunn/fzf.vim',
    requires = {'junegunn/fzf'},
    run = ':call fzf#install()',
  }
  use {
    'Shougo/neosnippet.vim',
    requires = {'kiddos/snippets.vim'}
  }


  -- language specific
  -- protobuf
  use {
    'kiddos/vim-protobuf',
    ft = {'proto'}
  }
  -- clang-format
  use {
    'rhysd/vim-clang-format',
    ft = {'c', 'cpp'},
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
  use 'leafOfTree/vim-vue-plugin'
  -- go
  use 'fatih/vim-go'
  -- vhdl
  use 'kiddos/vim-vhdl'
  -- markdown
  use 'tpope/vim-markdown'
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = {'markdown'},
    cmd = 'MarkdownPreview',
  }
  -- json
  use {
    'gennaro-tedesco/nvim-jqx',
    cmd = {'JqxList', 'JqxQuery'},
  }
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
