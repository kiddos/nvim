local treesitter_config = {}

treesitter_config.apply = function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'cuda',
      'cmake',
      'dart',
      'go',
      'lua',
      'proto',
      'rust',
      'python',
      'julia',
      'java',
      'javascript',
      'typescript',
      'json',
      'tsx',
      'html',
      'css',
      'sql',
      'yaml',
      'vim'
    },
    indent = {
      enable = true,
      disable = {'vim'}
    },
    -- ignore_install = { 'javascript', 'html', 'css', 'vim' },
    highlight = {
      enable = true,
      disable = {'webmacro'},
      additional_vim_regex_highlighting = false,
    },
  }

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'c',
      'cpp',
      'cuda',
      'dart',
      'go',
      'lua',
      'rust',
      'python',
      'julia',
      'java',
      'javascript',
      'typescript',
      'json',
      'tsx',
      'html',
      'css',
      'yaml',
      'vim'
    },
    callback = function()
      vim.opt_local.foldenable = false
      vim.opt_local.foldmethod = 'expr'
      vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
    end
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {'bash', 'zsh'},
    callback = function()
      vim.opt_local.foldmethod = 'marker'
      vim.opt_local.foldmarker = '{,}'
    end
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {'vim'},
    callback = function()
      vim.opt_local.foldmethod = 'marker'
      vim.opt_local.foldmarker = '{{{,}}}'
    end
  })
end

return treesitter_config
