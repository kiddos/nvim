local treesitter_config = {}

local uv = vim.uv or vim.loop;

treesitter_config.apply = function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c',
      'cpp',
      'cmake',
      'cuda',
      'dart',

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
      'vimdoc',

      'proto',
      'glsl',

      'bash',
      'diff',
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
    },
    indent = {
      enable = true,
      disable = function(lang, buf)
        if lang == 'dart' then
          return true
        end

        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
        return false
      end,
    },
    ignore_install = {},
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
      vim.api.nvim_set_option_value('foldcolumn', 'auto', { scope = 'local' })
      vim.api.nvim_set_option_value('foldlevel', 100, { scope = 'local' })
      vim.api.nvim_set_option_value('foldlevelstart', -1, { scope = 'local' })
      vim.api.nvim_set_option_value('foldmethod', 'expr', { scope = 'local' })
      vim.api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', { scope = 'local' })
    end
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'bash', 'zsh' },
    callback = function()
      vim.api.nvim_set_option_value('foldmethod', 'marker', { scope = 'local' })
      vim.api.nvim_set_option_value('foldmarker',  '{,}', { scope = 'local' })
    end
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'vim' },
    callback = function()
      vim.api.nvim_set_option_value('foldmethod', 'marker', { scope = 'local' })
      vim.api.nvim_set_option_value('foldmarker',  '{{{,}}}', { scope = 'local' })
    end
  })
end

return treesitter_config
