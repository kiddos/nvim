local saga = require('lspsaga')

saga.init_lsp_saga {
  finder_action_keys = {
    open = 'o',
    vsplit = 's',
    split = 'i',
    quit = 'q', -- quit can be a table
    scroll_down = '<C-f>',
    scroll_up = '<C-b>'
  },
  code_action_prompt = {
    enable = false,
    sign = false,
    sign_priority = 20,
    virtual_text = false,
  },
  use_saga_diagnostic_sign = false
}

vim.api.nvim_set_keymap('n', '<Leader>find', [[<Cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>code', [[<Cmd>lua require'lspsaga.codeaction'.code_action()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('v', '<Leader>code', [[<Cmd>lua require'lspsaga.codeaction'.rannge_code_action()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>doc', [[<Cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>sig', [[<Cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>rename', [[<Cmd>lua require'lspsaga.rename'.rename()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>def', [[<Cmd>lua require'lspsaga.provider'.preview_definition()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>impl', [[<Cmd>lua require'lspsaga.implement'.lspsaga_implementation()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>diag', [[<Cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('n', '[e', [[<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('n', ']e', [[<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]], {noremap=true, silent=true})
