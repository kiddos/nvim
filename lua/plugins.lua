local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

local M = packer.startup(function()
  use_rocks 'lua-cjson'

  use 'wbthomason/packer.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'onsails/lspkind-nvim'
  use 'glepnir/lspsaga.nvim'
  use {
    'gfanto/fzf-lsp.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},  -- to enable preview (optional)
    },
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use {'nvim-treesitter/playground'}

  -- tabline
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
  }

  -- color scheme
  use {
    'kiddos/malokai.vim',
    config = function()
      vim.opt.background = 'dark'
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
  -- file browser
  use {
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'},
    requires = {'Xuyuanp/nerdtree-git-plugin', 'ryanoasis/vim-devicons'},
  }
  use 'scrooloose/nerdcommenter' -- comments
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
  use 'tpope/vim-surround'
  use 'mattn/emmet-vim'
  use 'mhinz/vim-startify'
  use {
    'junegunn/fzf.vim',
    requires = {'junegunn/fzf'},
    run = ':call fzf#install()',
  }
  use 'dcampos/nvim-snippy'
  use 'farmergreg/vim-lastplace'


  -- language specific
  -- vue
  use 'leafOfTree/vim-vue-plugin'
  -- vhdl
  use 'kiddos/vim-vhdl'
  -- markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = {'markdown'},
    cmd = 'MarkdownPreview',
  }
  -- rust
  use 'rust-lang/rust.vim'
  -- dart
  use {
    'akinsho/flutter-tools.nvim',
    requires = 'plenary.nvim',
  }

  if packer_bootstrap then
    packer.sync()
  end
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- require'packer.luarocks'.install_commands()

return M
