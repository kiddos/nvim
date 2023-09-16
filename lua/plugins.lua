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
  use 'wbthomason/packer.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'onsails/lspkind-nvim'
  use {
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('plugin-settings/lspsaga-settings').setup()
    end
  }
  use {
    'gfanto/fzf-lsp.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }
  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},  -- to enable preview (optional)
    },
    config = require('plugin-settings/lspfuzzy').setup,
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.1',
    run = ':TSUpdate',
  }

  -- tabline
  use {
    'romgrk/barbar.nvim',
    tag = 'v1.7.0',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = require('plugin-settings/bufferline').setup,
  }

  -- color scheme
  use {
    'kiddos/malokai.vim',
    config = function()
      vim.cmd.colorscheme('malokai')
    end
  }

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
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- tmux
  use 'christoomey/vim-tmux-navigator'
  use 'benmills/vimux'
  use {
    'edkolev/tmuxline.vim',
    requires = {'vim-airline/vim-airline', 'vim-airline/vim-airline-themes'}
  }

  -- utility
  use 'windwp/nvim-autopairs' -- auto pairs
  -- status line
  use 'hoob3rt/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons' -- icons
  use 'gelguy/wilder.nvim' -- wild menu
  -- file browser
  use {
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'},
    requires = {'Xuyuanp/nerdtree-git-plugin', 'ryanoasis/vim-devicons'},
  }
  use 'scrooloose/nerdcommenter' -- comments
  use {
    'prettier/vim-prettier',
    run = 'yarn install',
    -- ft = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
    cmd = 'Prettier',
  }
  use {
    'kylechui/nvim-surround',
    tag = 'v2.1.1',
  }
  use 'mattn/emmet-vim'
  use 'mhinz/vim-startify'
  use {
    'junegunn/fzf.vim',
    requires = {'junegunn/fzf'},
    run = ':call fzf#install()',
  }
  use 'dcampos/nvim-snippy'
  use 'farmergreg/vim-lastplace'
  use {
    'kiddos/translate.nvim',
    rocks = {
      'lua-cjson',
      'luasec',
    }
  }


  -- language specific
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = {'markdown'},
    cmd = 'MarkdownPreview',
  }
  -- dart
  -- use {
  --   'akinsho/flutter-tools.nvim',
  --   tag = 'v1.3.0',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'stevearc/dressing.nvim',
  --   },
  -- }

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
