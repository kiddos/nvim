local M = {}

local install_lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  local runtimepath = vim.api.nvim_get_option_value('runtimepath', {})
  vim.api.nvim_set_option_value('runtimepath', runtimepath .. ',' .. lazypath, {})
end

M.setup = function()
  install_lazy()

  local plugins = {
    -- lsp
    'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim',
    'onsails/lspkind-nvim',
    'kosayoda/nvim-lightbulb',
    {
      'nvimdev/lspsaga.nvim',
      config = require('lspsaga-config').setup
    },
    {
      'folke/trouble.nvim',
      cmd = 'Trouble',
    },

    -- treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = require('treesitter-config').setup,
    },
    {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle',
    },


    -- colorscheme
    {
      'kiddos/malokai.vim',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd.colorscheme('malokai')
        vim.api.nvim_set_option_value('termguicolors', true, {})
      end
    },
    -- coloring
    {
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end,
    },

    -- tabline
    {
      'romgrk/barbar.nvim',
      tag = 'v1.7.0',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      config = require('bufferline-config').setup,
    },
    -- status line
    'hoob3rt/lualine.nvim',
    {
      'gelguy/wilder.nvim',
      build = ':UpdateRemotePlugins',
      config = function()
        local wilder = require('wilder')
        wilder.setup({ modes = { ':', '/', '?' } })

        wilder.set_option('renderer', wilder.popupmenu_renderer({
          highlighter = wilder.basic_highlighter(),
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        }))
      end,
    },
    -- file browser
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      keys = { '<F1>' },
      config = function()
        require("nvim-tree").setup()
        local tree_api = require('nvim-tree.api').tree
        local modes = { 'n', 'i' }
        for _, mode in pairs(modes) do
          vim.api.nvim_set_keymap(mode, '<F1>', '', {
            noremap = true,
            silent = true,
            callback = function()
              tree_api.toggle()
            end
          })
        end
      end,
    },
    -- notification
    {
      'rcarriga/nvim-notify',
      config = function()
        local notify = require('notify')
        notify.setup({
          max_width = 60,
          timeout = 1000,
        })
        vim.notify = notify
      end,
    },

    -- git
    {
      'airblade/vim-gitgutter',
      cmd = { 'GitGutterToggle' },
      keys = { '<F2>' },
      config = function()
        vim.api.nvim_set_var('gitgutter_enabled', false)
        vim.api.nvim_set_keymap('n', '<F2>', ':GitGutterToggle<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('i', '<F2>', '<Esc>:GitGutterToggle<CR>', { noremap = true, silent = true })
      end
    },
    {
      'f-person/git-blame.nvim',
      cmd = { 'GitBlameToggle' },
      keys = { '<F3>' },
      config = function()
        vim.api.nvim_set_var('gitblame_enabled', false)
        vim.api.nvim_set_keymap('n', '<F3>', ':GitBlameToggle<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('i', '<F3>', '<Esc>:GitBlameToggle<CR>', { noremap = true, silent = true })
      end,
    },
    {
      'linrongbin16/gitlinker.nvim',
      cmd = 'GitLink',
      config = function()
        require('gitlinker').setup()
      end,
    },

    -- tmux
    'christoomey/vim-tmux-navigator',
    'benmills/vimux',

    -- fzf
    {
      'junegunn/fzf.vim',
      dependencies = { 'junegunn/fzf' },
      build = ':call fzf#install()',
      config = function()
        local rg_options = {
          '--column',
          '--line-number',
          '--with-filename',
          '--color=always',
          '--smart-case ',
          '--no-search-zip',
          '-g \'!{**/node_modules,**/.git}\'',
        }
        local rg_command = 'rg ' .. table.concat(rg_options, ' ') .. ' -- '
        vim.api.nvim_create_user_command('Rg',
          'call fzf#vim#grep("' .. rg_command .. '".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)', {})
        vim.api.nvim_set_keymap('n', '<C-P>', ':Files<CR>', { noremap = true, silent = true })

        local register_fzf_menu = function(fzf_command, menu)
          vim.api.nvim_command('nnoremenu FZF.' .. menu:gsub(' ', '\\ ') .. ' :' .. fzf_command .. '<CR>')
        end

        register_fzf_menu('GFiles', 'Git files 🦜')
        register_fzf_menu('Buffers', 'Open buffers 🦥')
        register_fzf_menu('Colors', 'Color scheme 🎨')
        register_fzf_menu('Ag', 'ag search 🦆')
        register_fzf_menu('Rg', 'rg search 🧸')
        register_fzf_menu('Lines', 'Find in loadded buffers 🦄🦄🦄')
        register_fzf_menu('Tags', 'Tags in the project 🦏')
        register_fzf_menu('Changes', 'Changelist across open buffers 🦅')
        register_fzf_menu('Marks', 'Marks 🦋')
        register_fzf_menu('Jumps', 'Jumps 🦗')
        register_fzf_menu('Windows', 'Windows ')
        register_fzf_menu('History', 'History 🐓')
        register_fzf_menu('Snippets', 'Snippets')
        register_fzf_menu('Commits', 'Git Commits')
        register_fzf_menu('Commands', 'Commands 🦩')
        register_fzf_menu('Helptags', 'Help tags 🦎')
        register_fzf_menu('Filetypes', 'File types 🦘')

        vim.api.nvim_set_keymap('n', '<M-n>', '', {
          expr = true,
          noremap = true,
          silent = true,
          callback = function()
            if vim.fn.pumvisible() == 0 then
              vim.api.nvim_command('popup FZF')
            end
          end
        })
      end,
    },

    -- helper function
    'nvim-lua/plenary.nvim',

    -- utility
    'windwp/nvim-autopairs',
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup({
          mappings = {
            basic = false,
            extra = false,
          }
        })

        local ft = require('Comment.ft')
        ft.webmacro = '## %s'

        vim.api.nvim_set_keymap('n', '<leader>cc', '<Plug>(comment_toggle_linewise_current)', {})
        vim.api.nvim_set_keymap('n', '<leader>cu', '<Plug>(comment_toggle_linewise_current)', {})
        vim.api.nvim_set_keymap('v', '<leader>cc', '<Plug>(comment_toggle_linewise_visual)', {})
        vim.api.nvim_set_keymap('v', '<leader>cu', '<Plug>(comment_toggle_linewise_visual)', {})
        vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', {})
        vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', {})
      end
    },
    {
      'prettier/vim-prettier',
      build = 'yarn install --frozen-lock-file --production',
      tag = '1.0.0',
      ft = { 'javascript', 'typescript' },
      cmd = 'Prettier',
    },
    {
      'kylechui/nvim-surround',
      tag = 'v2.1.4',
      config = function()
        require('nvim-surround').setup({})
      end,
    },
    {
      'mattn/emmet-vim',
      ft = { 'html', 'javascript' },
      config = function()
        vim.api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')
      end,
    },
    {
      'dcampos/nvim-snippy',
      config = function()
        require('snippy').setup({
          mappings = {
            is = {
              ['<Tab>'] = 'expand_or_advance',
              -- ['<S-Tab>'] = 'previous',
            },
          },
        })
      end,
    },
    'farmergreg/vim-lastplace',
    {
      'kiddos/translate.nvim',
      rocks = {
        'lua-cjson',
        'luasec',
      },
      config = function()
        require('translate').setup()
      end,
    },


    -- language specific
    {
      'iamcco/markdown-preview.nvim',
      build = 'cd app && yarn install',
      ft = { 'markdown' },
      cmd = 'MarkdownPreview',
    },
    'tikhomirov/vim-glsl',
  }

  local options = {
    ui = {
      border = 'rounded',
    }
  }

  local lazy = require('lazy')
  lazy.setup(plugins, options)
end

return M
