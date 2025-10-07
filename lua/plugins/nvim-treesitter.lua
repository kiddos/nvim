local uv = vim.uv or vim.loop;
local api = vim.api

local function config()
  local required = { 'c', 'lua', 'vim', 'vimdoc', 'query' }
  local cpp_language = { 'cpp', 'cmake', 'cuda', 'make', 'ninja' }
  local jvm_language = { 'java', 'kotlin' }
  local common_language = { 'dart', 'go', 'rust', 'python', 'r' }
  local shell = { 'bash', 'fish' }
  local web = { 'html', 'css', 'javascript', 'typescript', 'tsx' }
  local data = { 'yaml', 'json', 'xml', 'toml' }
  local markdown = { 'markdown', 'markdown_inline' }
  local git = { 'gitignore', 'gitcommit' }
  local other = { 'proto', 'glsl', 'qmljs' }
  local low_level = { 'asm', 'llvm' }

  local installed = {}
  local add_install = function(list)
    for _, item in pairs(list) do
      table.insert(installed, item)
    end
  end

  add_install(required)
  add_install(cpp_language)
  add_install(jvm_language)
  add_install(common_language)
  add_install(shell)
  add_install(web)
  add_install(data)
  add_install(markdown)
  add_install(git)
  add_install(other)
  add_install(low_level)

  require('nvim-treesitter.configs').setup {
    ensure_installed = installed,
    indent = {
      enable = true,
      disable = function(lang, buf)
        if lang == 'dart' then
          return true
        end

        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(uv.fs_stat, api.nvim_buf_get_name(buf))
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

  api.nvim_create_autocmd('FileType', {
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
      api.nvim_set_option_value('foldcolumn', 'auto', { scope = 'local' })
      api.nvim_set_option_value('foldlevel', 100, { scope = 'local' })
      api.nvim_set_option_value('foldlevelstart', -1, { scope = 'local' })
      api.nvim_set_option_value('foldmethod', 'expr', { scope = 'local' })
      api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', { scope = 'local' })
      api.nvim_set_option_value('foldtext', 'vim.treesitter.foldtext()', { scope = 'local' })
    end
  })

  api.nvim_create_autocmd('FileType', {
    pattern = { 'bash', 'zsh' },
    callback = function()
      api.nvim_set_option_value('foldmethod', 'marker', { scope = 'local' })
      api.nvim_set_option_value('foldmarker', '{,}', { scope = 'local' })
    end
  })

  api.nvim_create_autocmd('FileType', {
    pattern = { 'vim' },
    callback = function()
      api.nvim_set_option_value('foldmethod', 'marker', { scope = 'local' })
      api.nvim_set_option_value('foldmarker', '{{{,}}}', { scope = 'local' })
    end
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = config,
}
