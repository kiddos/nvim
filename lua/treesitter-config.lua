local treesitter_config = {}

treesitter_config.apply = function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c',
      'cpp',
      'cuda',
      -- 'dart',
      'go',
      'lua',
      'rust',
      'python',
      'java',
      'kotlin',
      'r',
      'ruby',
      'verilog',
      'vim',

      'proto',
      'glsl',

      'bash',
      'diff',
      'cmake',
      'make',
      'ninja',

      'gitattributes',
      'gitcommit',
      'gitignore',

      'javascript',
      'typescript',
      'json',
      'tsx',
      'vue',

      'html',
      'markdown',
      'markdown_inline',
      'css',

      'sql',

      'yaml',
      'ini',
    },
    indent = {
      enable = true,
      disable = function(lang, buf)
        if lang == 'dart' then
          return true
        end

        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
        return false
      end,
    },
    ignore_install = {},
    -- ignore_install = { 'dart' },
    -- ignore_install = { 'javascript', 'html', 'css', 'vim' },
    highlight = {
      enable = true,
      disable = { 'webmacro' },
      additional_vim_regex_highlighting = false,
    },
  }

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'c',
      'cpp',
      'cuda',
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
    pattern = { 'bash', 'zsh' },
    callback = function()
      vim.opt_local.foldmethod = 'marker'
      vim.opt_local.foldmarker = '{,}'
    end
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'vim' },
    callback = function()
      vim.opt_local.foldmethod = 'marker'
      vim.opt_local.foldmarker = '{{{,}}}'
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader><Leader>t', '', {
    expr = true,
    noremap = true,
    callback = function()
      local captures = vim.treesitter.get_captures_at_cursor(0)
      for _, cap in pairs(captures) do
        print(cap)
      end
    end
  })
end

return treesitter_config
