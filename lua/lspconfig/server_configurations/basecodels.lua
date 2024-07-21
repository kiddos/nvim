return {
  default_config = {
    cmd = { "basecode-lsp", '--snippet-folder=/home/kiddos/.config/nvim/snippets' },
    filetypes = {},
    root_dir = function()
      return '/'
    end
  }
}
