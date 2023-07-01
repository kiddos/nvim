local util = require('lspconfig/util')

return {
  default_config = {
    cmd = {"webmacro-language-server", "--stdio"},
    filetypes = {"webmacro"},
    root_dir = function(fname)
      return util.root_pattern('build.xml', '.git', 'ivy.xml')(fname) or vim.uv.os_homedir()
    end
  }
}
