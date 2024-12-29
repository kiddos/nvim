local set_filetype = function(pattern, filetype)
  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = pattern,
    callback = function()
      vim.api.nvim_set_option_value('filetype', filetype, {
        buf = vim.api.nvim_get_current_buf(),
      })
    end
  })
end

set_filetype({ '*.i', '*.swg' }, 'swig')
set_filetype({ '*.BUILD' }, 'bzl')
set_filetype({ '*.m' }, 'objc')
set_filetype({ '*.mm' }, 'objcpp')
set_filetype({ '*.h' }, 'cpp')
set_filetype({ '*.pro' }, 'make')
set_filetype({ '*.wmm' }, 'webmacro')
set_filetype({ '*.snippets' }, 'snippets')
