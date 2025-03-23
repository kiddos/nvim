local uv = vim.uv or vim.loop

local home = uv.os_homedir()
local snippet_dir = home .. '/.config/nvim/snippets'
local current_dir = uv.cwd()

local max_filesize = 10 * 1024 * 1024

return {
  default_config = {
    cmd = {
      'basecode-lsp',
      '--snippet-folder=' .. snippet_dir,
      '--root-folder=' .. current_dir,
    },
    filetypes = {},
    on_init = function(client)
      local file = vim.api.nvim_buf_get_name(0)
      local file_size = vim.fn.getfsize(file)
      if file_size > max_filesize then
        print("Skipping LSP for large file: " .. file)
        client.stop()
        return false
      end
      return true
    end,
    root_dir = function()
      return '/'
    end
  }
}
