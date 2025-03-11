local function status_icons()
  local current = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(current)
  if #diagnostics > 0 then
    local bug = ''
    for i = 1, #diagnostics, 1 do
      local severity = diagnostics[i].severity
      if severity == vim.diagnostic.severity.ERROR then
        bug = bug .. '🐁'
      elseif severity == vim.diagnostic.severity.WARN then
        bug = bug .. '🐀'
      elseif severity == vim.diagnostic.severity.INFO then
        bug = bug .. '🐺'
      elseif severity == vim.diagnostic.severity.HINT then
        bug = bug .. '🐹'
      end
    end
    return bug
  else
    if vim.fn.mode() == 'n' then
      return '🐕'
    elseif vim.fn.mode() == 'i' then
      return '🐧'
    elseif vim.fn.mode() == 's' then
      return '🐇'
    end
    return '🐘'
  end
end

local function lsp_statusline()
  local status_line = require('lsp-status').status()
  local max_len = 30
  if #status_line >= max_len then
    return string.sub(status_line, 1, max_len) .. ' ...'
  end
  return status_line
end

local function treesitter_statusline()
  return require("nvim-treesitter").statusline({
    indicator_size = 50,
    type_patterns = { "class", "function", "method" },
    separator = " -> ",
  })
end

local function config()
  require('lualine').setup {
    options = {
      theme = 'onedark',
      section_separators = { '◗', '◖' },
      component_separators = { '►', '◄' }
    },
    sections = {
      lualine_c = {
        'filename',
        status_icons,
        lsp_statusline,
      },
      lualine_x = {
        treesitter_statusline,
        'encoding',
        'fileformat',
        'filetype'
      },
    },
  }
end

return {
  'hoob3rt/lualine.nvim',
  lazy = false,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter' } ,
    { 'nvim-lua/lsp-status.nvim' },
  },
  config = config,
}
