local lsp_status = require('lsp-status')

require('lualine').setup{
  options = {
    theme = 'onedark',
    section_separators = {'◗', '◖'},
    component_separators = {'►', '◄'}
  },
  sections = {
    lualine_c = {'filename', "require'lsp-status'.status()"},
    --[[ lualine_x = {"require'lsp-status'.status()", 'encoding', 'fileformat', 'filetype'}, ]]
  },
}
