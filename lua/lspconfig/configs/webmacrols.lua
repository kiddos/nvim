local util = require('lspconfig/util')
local uv = vim.uv or vim.loop

return {
  default_config = {
    cmd = { "webmacro-language-server", "--stdio" },
    filetypes = { "webmacro" },
    root_dir = function(fname)
      return util.root_pattern('build.xml', '.git', 'ivy.xml')(fname) or uv.os_homedir()
    end
  }
}
