local saga = require('lspsaga')

saga.init_lsp_saga {
  finder_action_keys = {
    open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  use_saga_diagnostic_sign = false
}

vim.api.nvim_set_keymap('n', '<Leader>find', [[<Cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>code', [[<Cmd>lua ('lspsaga.codeaction').code_action()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>doc', [[<Cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>sig', [[<Cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>rename', [[<Cmd>lua require'lspsaga.rename'.rename()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>def', [[<Cmd>lua require'lspsaga.diagnostic'.preview_definition()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>diag', [[<Cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '[e', [[<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', ']e', [[<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]], {noremap=true, silent=true})
