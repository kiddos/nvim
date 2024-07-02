local filetypes = {}

filetypes.setup = function()
  -- snippets filetype
  vim.api.nvim_create_autocmd('BufRead', {
    pattern = { '*.snippets' },
    callback = function()
      vim.api.nvim_set_option_value('filetype', 'snippets', {
        buf = vim.api.nvim_get_current_buf(),
      })
    end
  })
end

return filetypes
