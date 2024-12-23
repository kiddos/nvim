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
    {
      'neovim/nvim-lspconfig',
      lazy = false,
    },
    {
      'nvim-lua/lsp-status.nvim',
      lazy = false,
    },
    {
      'onsails/lspkind-nvim',
      lazy = false,
    },
    {
      'kosayoda/nvim-lightbulb',
      lazy = false,
    },
    {
      'nvimdev/lspsaga.nvim',
      lazy = false,
      config = require('lspsaga-config').setup
    },
    {
      'folke/trouble.nvim',
      opts = {},
      cmd = 'Trouble',
    },
    -- treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      build = ':TSUpdate',
      config = require('treesitter-config').setup,
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
      ft = { 'css', 'javascript' },
      config = function()
        require('colorizer').setup()
      end,
    },

    -- tabline
    {
      'romgrk/barbar.nvim',
      event = 'VimEnter',
      tag = 'v1.9.1',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      config = require('bufferline-config').setup,
    },
    -- status line
    {
      'hoob3rt/lualine.nvim',
      event = 'VimEnter',
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
      lazy = false,
      config = function()
        local notify = require('notify')
        notify.setup({
          max_width = 60,
          timeout = 2000,
        })
        vim.notify = function(msg, level, opts)
          notify(msg, level, opts)
          print(msg)
        end
      end,
    },
    {
      'kevinhwang91/nvim-hlslens',
      event = 'VimEnter',
      config = function()
        require('hlslens').setup()
        local kopts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', 'n',
          [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
        vim.api.nvim_set_keymap('n', 'N',
          [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
        vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

        vim.api.nvim_set_keymap('n', '<Leader>h', '<Cmd>noh<CR>', kopts)
      end,
    },
    {
      'nvimdev/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('dashboard').setup {
          -- config
        }
      end,
      dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    -- git
    {
      'airblade/vim-gitgutter',
      cmd = { 'GitGutterToggle' },
      keys = { '<F2>' },
      config = function()
        vim.api.nvim_set_var('gitgutter_enabled', false)
        local enabled = false
        local callback = function()
          if enabled then
            enabled = false
            vim.notify('Disable GitGutter 🥺', vim.log.levels.WARN)
            vim.api.nvim_command('GitGutterDisable')
          else
            enabled = true
            vim.notify('Enable GitGutter 🦈')
            vim.api.nvim_command('GitGutterEnable')
          end
        end
        vim.api.nvim_set_keymap('n', '<F2>', '', { noremap = true, silent = true, callback = callback })
        vim.api.nvim_set_keymap('i', '<F2>', '', { noremap = true, silent = true, callback = callback })
      end
    },
    {
      'f-person/git-blame.nvim',
      cmd = { 'GitBlameToggle' },
      keys = { '<F3>' },
      config = function()
        vim.api.nvim_set_var('gitblame_enabled', false)
        local enabled = false
        local callback = function()
          if enabled then
            enabled = false
            vim.notify('Disable GitBlame 🥺', vim.log.levels.WARN)
            vim.api.nvim_command('GitBlameDisable')
          else
            enabled = true
            vim.notify('Enable GitBlame 🤨')
            vim.api.nvim_command('GitBlameEnable')
          end
        end
        vim.api.nvim_set_keymap('n', '<F3>', '', { noremap = true, silent = true, callback = callback })
        vim.api.nvim_set_keymap('i', '<F3>', '', { noremap = true, silent = true, callback = callback })
      end,
    },

    -- tmux
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },

    -- fzf
    {
      'junegunn/fzf.vim',
      cmd = { 'Rg', 'Ag', 'FZF' },
      keys = { '<C-P>' },
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

    -- utility
    { 'windwp/nvim-autopairs' },
    {
      'numToStr/Comment.nvim',
      event = 'VimEnter',
      config = function()
        require('Comment').setup({
          mappings = {
            basic = false,
            extra = false,
          }
        })

        local ft = require('Comment.ft')
        ft.webmacro = '## %s'

        vim.api.nvim_set_var('mapleader', ',')
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
      event = 'VimEnter',
      tag = 'v2.1.10',
      config = function()
        require('nvim-surround').setup({})
      end,
    },
    {
      'mattn/emmet-vim',
      ft = { 'html', 'javascript', 'jsp' },
      config = function()
        vim.api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')
      end,
    },
    {
      'dcampos/nvim-snippy',
      event = 'InsertEnter',
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
    {
      'farmergreg/vim-lastplace',
      lazy = false,
    },
    {
      'kiddos/google-translate.nvim',
      build = { 'pip install -r requirements.txt', ':UpdateRemotePlugins' },
      cmd = { 'TranslateCN', 'TranslateTW', 'TranslateEN' },
      config = function()
        require('google-translate').setup()
      end,
    },


    -- language specific
    {
      'iamcco/markdown-preview.nvim',
      build = 'cd app && ./install.sh',
      ft = { 'markdown' },
      cmd = 'MarkdownPreview',
    },
    {
      'tikhomirov/vim-glsl',
      ft = 'glsl',
    },
    {
      'slint-ui/vim-slint',
      ft = 'slint',
    },

    -- AI
    {
      'kiddos/gemini.nvim',
      branch = 'curl',
      config = function()
        require('gemini').setup()
      end
    }
  }

  local options = {
    ui = {
      border = 'rounded',
    },
    dev = {
      path = '~/projects/tools',
      patterns = { 'kiddos' },
      fallback = true,
    },
  }

  local lazy = require('lazy')
  lazy.setup(plugins, options)
end

return M
