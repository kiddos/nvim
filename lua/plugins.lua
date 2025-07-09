local M = {}

local function install_lazy()
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
  vim.api.nvim_set_var('mapleader', ',')

  install_lazy()

  local plugins = {
    -- lsp
    { import = 'plugins.lsp' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.colorscheme' },
    { 'NvChad/nvim-colorizer.lua', ft = { 'css', 'javascript' } },
    { import = 'plugins.lualine' },
    { import = 'plugins.barbar' },
    { import = 'plugins.git' },
    { 'windwp/nvim-autopairs', opts = {} },
    { 'kiddos/pawtocomplete.nvim', build = { 'make' }, opts = {} },

    -- utility
    { 'kevinhwang91/nvim-bqf', ft = 'qf' },
    { import = 'plugins.util' },
    {
      'kiddos/google-translate.nvim',
      build = { 'pip install -r requirements.txt', ':UpdateRemotePlugins' },
      cmd = { 'TranslateCN', 'TranslateTW', 'TranslateEN' },
      config = function()
        require('google-translate').setup()
      end,
    },

    -- language specific
    { 'tikhomirov/vim-glsl', ft = 'glsl' },
    { 'slint-ui/vim-slint',  ft = 'slint' },

    -- AI
    {
      'kiddos/gemini.nvim',
      event = 'InsertEnter',
      opts = {
        completion = {
          can_complete = function()
            return not require('pawtocomplete.completion_menu').is_opened()
          end
        }
      }
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
