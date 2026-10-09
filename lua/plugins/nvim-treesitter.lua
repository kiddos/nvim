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

  local extend = function(t1, t2)
    for _, item in pairs(t2) do
      table.insert(t1, item)
    end
  end

  local to_install = {}
  extend(to_install, required)
  extend(to_install, cpp_language)
  extend(to_install, jvm_language)
  extend(to_install, common_language)
  extend(to_install, shell)
  extend(to_install, web)
  extend(to_install, data)
  extend(to_install, markdown)
  extend(to_install, git)
  extend(to_install, other)
  extend(to_install, low_level)

  local treesitter = require('nvim-treesitter')
  treesitter.install(to_install)
  treesitter.setup {}

  api.nvim_create_autocmd('FileType', {
    pattern = to_install,
    callback = function()
      vim.treesitter.start()
    end
  })

  local enable_fold = {}

  extend(enable_fold, required)
  extend(enable_fold, cpp_language)
  extend(enable_fold, jvm_language)
  extend(enable_fold, common_language)
  extend(enable_fold, shell)
  extend(enable_fold, web)

  api.nvim_create_autocmd('FileType', {
    pattern = enable_fold,
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
  branch = 'main',
  build = ':TSUpdate',
  config = config,
}
