local uv = vim.uv or vim.loop

local home = uv.os_homedir()
local snippet_dir = home .. '/.config/nvim/snippets'
local current_dir = uv.cwd()

return {
  cmd = {
    'basecode-lsp',
    '--snippet-folder=' .. snippet_dir,
    '--root-folder=' .. current_dir,
  },
}
