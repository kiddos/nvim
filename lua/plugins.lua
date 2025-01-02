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
  vim.api.nvim_set_var('mapleader', ',')

  install_lazy()

  local plugins = {
    -- lsp
    { import = 'plugins.lsp-config' },
    { import = 'plugins.lsp' },
    { 'folke/trouble.nvim', opts = {}, cmd = 'Trouble' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.colorscheme' },
    { 'NvChad/nvim-colorizer.lua', ft = { 'css', 'javascript' } },
    { import = 'plugins.barbar' },
    { import = 'plugins.nvim-tree' },
    { import = 'plugins.notify' },
    { import = 'plugins.hlslens' },
    { import = 'plugins.dashboard' },
    { import = 'plugins.git' },
    { import = 'plugins.tmux' },
    { import = 'plugins.fzf' },

    -- utility
    { 'windwp/nvim-autopairs' },
    { 'kevinhwang91/nvim-bqf', ft = 'qf' },
    { import = 'plugins.comment' },
    { import = 'plugins.marks' },
    {
      'prettier/vim-prettier',
      build = 'yarn install --frozen-lock-file --production',
      tag = '1.0.0',
      ft = { 'javascript', 'typescript' },
      cmd = 'Prettier',
    },
    { 'kylechui/nvim-surround', event = 'VimEnter', tag = 'v2.1.10', opts = {} },
    {
      'mattn/emmet-vim',
      ft = { 'html', 'javascript', 'jsp' },
      config = function()
        vim.api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')
      end,
    },
    { import = 'plugins.snippy' },
    { 'farmergreg/vim-lastplace', lazy = false },
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
    { 'tikhomirov/vim-glsl', ft = 'glsl' },
    { 'slint-ui/vim-slint', ft = 'slint' },

    -- AI
    { 'kiddos/gemini.nvim', opts = {} }
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
