local api = vim.api

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
  api.nvim_set_option_value('runtimepath', runtimepath .. ',' .. lazypath, {})
end

M.setup = function()
  api.nvim_set_var('mapleader', ',')

  install_lazy()

  local plugins = {
    { import = 'plugins' },
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
