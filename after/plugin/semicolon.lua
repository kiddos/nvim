vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'cpp',
    'cuda',
    'arduino',
    'java',
    'jsp',
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'css',
    'dart',
    'rust',

    'matlab',
    'php',
    'objc',
    'objcpp',
  },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', ';', '$a;', { noremap = true });
  end,
})
