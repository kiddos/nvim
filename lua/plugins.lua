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
  use {
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_list_order = {
        {'    Recently used files in current directory:'}, 'dir',
        {'    Recently used files:'}, 'files',
        {'    Bookmarks:'}, 'bookmarks',
        {'    Sessions:'}, 'sessions',
      }
      vim.g.startify_files_number = 3
      vim.g.startify_bookmarks = {
        {vimrc = '~/.vim/vimrc'},
        {nvimrc = '~/.config/nvim/init.vim'}
      }
      -- vim.g.startify_custom_header = vim.api.nvim_eval("map(split(system('fortune | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n'), '"   ". v:val') + ['']")
      vim.g.startify_custom_header = vim.api.nvim_eval("split(system('fortune | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n')")
      vim.g.startify_change_to_dir = 1
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_enable_special = 0
    end
  }
  use {
    'junegunn/fzf.vim',
    requires = {'junegunn/fzf'},
    run = ':call fzf#install()',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-P>', ':Files<CR>', {noremap=true, silent=true})
    end
  }
  use {
    'vim-airline/vim-airline-themes',
    after = {'vim-airline'},
    config = function()
      vim.g.airline_theme = 'onedark'
    end
  }
  use {
    'vim-airline/vim-airline',
    config = function()
      vim.g.airline_disable_statusline = 1
      vim.g.airline_detect_modified = 1
      vim.g.airline_detect_paste = 1
      vim.g.airline_detect_crypt = 1
      vim.g.airline_detect_iminsert = 1
      vim.g.airline_inactive_collapse = 1
      vim.g.airline_powerline_fonts = 1

      vim.g.airline_symbols = {
        crypt = '🔒',
        linenr = '🔭',
        maxlinenr = '🔬',
        -- branch = '🛠 ',
        branch = '🔀',
        paste = '📑',
        readonly = '⛔️',
        spell = 'Ꞩ',
        whitespace = '🕳 ',
        notexists = '🛑',
      }

      -- vim.g.airline_left_sep = '⌨️ '
      -- vim.g.airline_right_sep = '💻'
      -- vim.g.airline_right_alt_sep = '💠'
      -- vim.g.airline_left_alt_sep = '🛸'

      -- airline-branch
      -- vim.g['airline#extensions#branch#enabled'] = 1

      -- airline-ale
      -- vim.g['airline#extensions#ale#enabled'] = 1
      -- vim.g['airline#extensions#ale#error_symbol'] = '🚫'
      -- vim.g['airline#extensions#ale#warning_symbol'] = '⚠️ '

      -- airline-tabline
      -- vim.g['airline#extensions#tabline#enabled'] = 1
      -- vim.g['airline#extensions#tabline#show_splits'] = 0
      -- vim.g['airline#extensions#tabline#show_tab_count'] = 0
      -- vim.g['airline#extensions#tabline#show_buffers'] = 0
      -- vim.g['airline#extensions#tabline#show_tab_nr'] = 0
      -- vim.g['airline#extensions#tabline#overflow_marker ='] '…'
      -- vim.g['airline#extensions#tabline#current_first'] = 0
      -- vim.g['airline#extensions#tabline#tabs_label'] = ''
      -- vim.g['airline#extensions#tabline#fnamemod'] = ':t'
      -- vim.g['airline#extensions#tabline#fnamecollapse'] = 0
      -- vim.g['airline#extensions#tabline#show_close_button'] = 0
      -- vim.g['airline#extensions#tabline#exclude_preview'] = 0
      -- vim.g['airline#extensions#tabline#buffer_nr_show'] = 0
      -- vim.g['airline#extensions#tabline#show_tab_type'] = 0
      -- vim.api.nvim_set_keymap('n', '<Leader>1', '<Plug>AirlineSelectTab1', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>2', '<Plug>AirlineSelectTab2', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>3', '<Plug>AirlineSelectTab3', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>4', '<Plug>AirlineSelectTab4', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>5', '<Plug>AirlineSelectTab5', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>6', '<Plug>AirlineSelectTab6', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>7', '<Plug>AirlineSelectTab7', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>8', '<Plug>AirlineSelectTab8', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>9', '<Plug>AirlineSelectTab9', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>-', '<Plug>AirlineSelectPrevTab', {silent=true})
      -- vim.api.nvim_set_keymap('n', '<Leader>+', '<Plug>AirlineSelectNextTab', {silent=true})

      -- airline-nvimlsp
      vim.g['airline#extensions#nvimlsp#enabled'] = 1
      vim.g['airline#extensions#nvimlsp#error_symbol'] = '🚫'
      vim.g['airline#extensions#nvimlsp#warning_symbol'] = '⚠️ '
    end
  }
  use {
    'edkolev/tmuxline.vim',
    after = 'vim-airline',
    config = function()
      vim.g.tmuxline_preset = {
        a = '#S',
        b = '#W',
        c = '',
        win = '#I #W',
        cwin = '#I #W',
        y = 'APM: #(python3 ~/.config/nvim/apm_client.py) #(uptime  | cut -d " " -f 1,2)',
        z = '#(whoami)@#H',
        options = { ['status-justify'] = 'left'
        }
      }
      vim.g.tmuxline_separators = {
        left = '◗',
        left_alt = '◗',
        right = '◖',
        right_alt = '◖',
        space = ' '
      }
    end
  }
  use 'kiddos/snippets.vim'
  use {
    'Shougo/neosnippet.vim',
    config = function()
      vim.g['neosnippet#enable_snipmate_compatibility'] = 1
      vim.g['neosnippet#enable_completed_snippet'] = 1
      
      vim.api.nvim_set_keymap('i', '<Tab>', 'neosnippet#expandable_or_jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"', {expr=true, silent=true})
      vim.api.nvim_set_keymap('s', '<Tab>', 'neosnippet#expandable_or_jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"', {expr=true, silent=true})
    end
  }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
    end
  }


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
    config = function()
      vim.g['clang_format#code_style'] = 'google'
      vim.g['clang_format#filetype_style_options'] = {
        cpp = {
          ['Standard'] = 'C++11',
          ['ColumnLimit'] = 80,
        },
        javascript = {
          ['ColumnLimit'] = 80,
        },
      }
    end
  }
  -- python
  use {
    'tell-k/vim-autopep8',
    ft = {'python'},
    config = function()
      vim.g.autopep8_indent_size = 2
      vim.g.autopep8_disable_show_diff = 0
      vim.g.autopep8_max_line_length = 80
      -- vim.g.autopep8_ignore="W291,W391,E111,E113,E114,E121,E125,E127,E128,E221,E225,E226,E231,E302,E303,W391,E501,E701,F401"
    end
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
