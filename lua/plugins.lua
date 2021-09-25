return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- new features
  -- lsp
  use 'neovim/nvim-lspconfig'
  -- completion
  use {
    'hrsh7th/nvim-compe',
    config = function()
      local compe = require('compe')
      compe.setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'always',
        throttle_time = 60,
        source_timeout = 300,
        resolve_timeout = 600,
        incomplete_delay = 600,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        source = {
          path = true,
          buffer = {
            ignored_filetypes = {'json', 'text', ''}
          },
          calc = false,
          nvim_lsp = true,
          nvim_lua = true,
          vsnip = false,
          ultisnips = false,
          luasnip = false,
        },
      }

      vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {expr=true, noremap=true, silent=true})
      vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm("<CR>")', {expr=true, noremap=true})
    end
  }
  -- status line
  use {
    'hoob3rt/lualine.nvim',
    config = function()
      require('lualine').setup{
        options = {
          theme = 'onedark',
          section_separators = {'◗', '◖'},
          component_separators = {'►', '◄'}
        },
      }
    end
  }
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        indent = {
          enable = false
        },
        highlight = {
          enable = true,
          disable = {'javascript', 'html', 'css', 'vim'},
          additional_vim_regex_highlighting = false
        },
      }
    end
  }
  -- tabline
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      vim.g.bufferline = {
        icon_custom_colors = true,
        maximum_padding = 2,
      }
      -- vim.api.nvim_set_keymap('n', '<A-,>', ':BufferPrevious<CR>', {silent=true, noremap=true})
      -- vim.api.nvim_set_keymap('n', '<A-.>', ':BufferNext<CR>', {silent=true, noremap=true})
      -- Re-order to previous/next
      vim.api.nvim_set_keymap('n', '<A-Left>', ':BufferMovePrevious<CR>', {silent=true, noremap=true})
      vim.api.nvim_set_keymap('n', '<A-Right>', ':BufferMoveNext<CR>', {silent=true, noremap=true})
      -- Goto buffer in position...
      for i = 1,9,1 do
        vim.api.nvim_set_keymap('n', string.format('<Leader>%d', i), string.format(':BufferGoto %d<CR>', i), {silent=true, noremap=true})
      end
      vim.api.nvim_set_keymap('n', '<Leader>0', ':BufferLast<CR>', {silent=true, noremap=true})
      -- Close buffer
      vim.api.nvim_set_keymap('n', '<A-C>', ':BufferClose<CR>', {silent=true, noremap=true})
      -- Wipeout buffer
      -- :BufferWipeout<CR>
      -- Close commands
      -- :BufferCloseAllButCurrent<CR>
      -- :BufferCloseBuffersLeft<CR>
      -- :BufferCloseBuffersRight<CR>
      -- Magic buffer-picking mode
      -- nnoremap <silent> <C-s>    :BufferPick<CR>
      -- Sort automatically by...
      -- nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
      -- nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
    end
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
  vim.g.gitgutter_enabled = 0
  vim.api.nvim_set_keymap('n', '<F2>', ':GitGutterToggle<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F2>', '<Esc>:GitGutterToggle<CR>', {noremap=true, silent=true})
  use {
    'f-person/git-blame.nvim',
    cmd = {'GitBlameToggle'}
  }
  vim.g.gitblame_enabled = 0
  vim.api.nvim_set_keymap('n', '<F3>', ':GitBlameToggle<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F3>', '<Esc>:GitBlameToggle<CR>', {noremap=true, silent=true})
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
  use {
    'edkolev/tmuxline.vim',
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
  use 'christoomey/vim-tmux-navigator'
  use 'benmills/vimux'


  -- utility
  use {
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'},
    requires = {'Xuyuanp/nerdtree-git-plugin'},
  }
  vim.api.nvim_set_keymap('n', '<F1>', ':NERDTreeToggle .<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F1>', '<Esc>:NERDTreeToggle .<CR>', {noremap=true, silent=true})
  use {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCompactSexyComs = 1
      vim.g.NERDDefaultAlign = 'left'
      vim.g.NERDCustomDelimiters = {
        c = {left='//'},
        arduino = {left='//'},
        vim = {left='"'},
        conf = {left='#'},
        prototxt = {left='#'}
      }
    end
  }
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
  vim.api.nvim_set_keymap('n', '<Leader><Leader>a', ':A<CR>', {silent=true})
  use {
    'tpope/vim-eunuch',
    cmd = {'Delete', 'Unlink', 'Move', 'Rename', 'Chmod', 'Mkdir'}
  }
  use 'tpope/vim-surround'
  use {
    'mattn/emmet-vim',
    config = function()
      vim.g.user_emmet_togglecomment_key = '<C-y>#'
    end
  }
  use {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_linters = {
        python = {'flake8'},
        javascript = {'eslint'},
        javascriptreact = {'eslint'}
      }
      vim.g.ale_python_flake8_options = '--ignore=E111,E121,E123,E126,E226,E24,E704,W503,W504'
      vim.g.ale_linters_ignore = {
        java = {'javac', 'checkstyle', 'eclipselsp', 'pmd'},
        javascript = {'flow'}
      }
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }
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
    config = function()
      vim.api.nvim_command('set rtp+=~/.fzf')
      vim.api.nvim_set_keymap('n', '<C-P>', ':Files<CR>', {noremap=true, silent=true})
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
  use {
    'elzr/vim-json',
    ft = {'json'}
  }
  use {
    'leafgarland/typescript-vim',
    ft = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact'}
  }
  use {
    'pangloss/vim-javascript',
    ft = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'}
  }
  use {
    'MaxMEllon/vim-jsx-pretty',
    -- ft = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
    config = function()
      vim.g.vim_jsx_pretty_enable_jsx_highlight = 0
    end
  }
  use {
    'peitalin/vim-jsx-typescript',
    ft = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
  }
  -- go
  use {
    'fatih/vim-go',
    ft = {'go'}
  }
  -- vhdl
  use {
    'kiddos/vim-vhdl',
    ft = {'vhdl'}
  }
  -- ruby
  use {
    'vim-ruby/vim-ruby',
    ft = {'ruby'}
  }
  -- php
  use {
    'stanangeloff/php.vim',
    ft = {'php'}
  }
  -- html
  use {
    'othree/html5.vim',
    ft = {'html'}
  }
  -- markdown
  use {
    'tpope/vim-markdown',
    ft = {'markdown'}
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = {'markdown'},
    cmd = 'MarkdownPreview'
  }
  -- css
  use {
    'ap/vim-css-color',
    ft = {'javascript', 'typescript', 'css', 'sass', 'scss', 'less'}
  }
  use {
    'hail2u/vim-css3-syntax',
    ft = {'javascript', 'typescript', 'css', 'sass', 'scss', 'less'}
  }
  use {
    'groenewege/vim-less',
    ft = {'javascript', 'typescript', 'css', 'sass', 'scss', 'less'}
  }
  use {
    '1995eaton/vim-better-css-completion',
    ft = {'javascript', 'typescript', 'css', 'sass', 'scss', 'less'}
  }
  use {
    'othree/csscomplete.vim',
    ft = {'javascript', 'typescript', 'css', 'sass', 'scss', 'less'}
  }
  -- julia
  use {
    'JuliaEditorSupport/julia-vim',
    -- ft = {'julia'}
    -- https://github.com/JuliaEditorSupport/julia-vim/issues/35
  }
  -- rust
  use {
    'rust-lang/rust.vim',
    ft = {'rust'},
  }
  -- dart
  use {
    'dart-lang/dart-vim-plugin',
    ft = {'dart'}
  }

  -- games
  use {
    'ThePrimeagen/vim-be-good',
    cmd = {'VimBeGood'}
  }
  use {
    'alec-gibson/nvim-tetris',
    cmd = {'Tetris'}
  }
end)
