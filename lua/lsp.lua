local configs = require('lspconfig/configs')
local util = require('lspconfig/util')
local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')

-- setting lsp
lsp_status.register_progress()

local on_publish_diagnostics = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
    severity_sort = false,
  }
);

-- c++
local clangd_handler = lsp_status.extensions.clangd.setup()
clangd_handler['textDocument/publishDiagnostics'] = on_publish_diagnostics
lspconfig.clangd.setup{
  cmd = {"clangd-10", "--background-index", "--header-insertion=never"};
  handlers = clangd_handler,
  init_options = {
    clangdFileStatus = true
  },
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
};

-- javascript/typescript
lspconfig.tsserver.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  },
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
}

-- css
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup{
  capabilities = capabilities,
  on_attach = lsp_status.on_attach,
  cmd = {"vscode-css-language-server", "--stdio"};
}

-- html
lspconfig.html.setup {
  capabilities = capabilities,
  on_attach = lsp_status.on_attach,
  cmd = {"vscode-html-language-server", "--stdio"};
}

-- python
lspconfig.jedi_language_server.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  },
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
}

-- vim
lspconfig.vimls.setup{
  on_attach = lsp_status.on_attach,
}

-- bash
lspconfig.bashls.setup{
  on_attach = lsp_status.on_attach,
}

-- angular
lspconfig.angularls.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  }
}

-- rust
lspconfig.rust_analyzer.setup{
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
}

-- lua
local sumneko_root_path = vim.loop.os_homedir() .. "/.local/lsp/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
lspconfig.sumneko_lua.setup{
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  },
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
}

-- dart
local home = vim.loop.os_homedir()
local dart_sdk = home .. "/.local/flutter/bin/cache/dart-sdk/bin/"
lspconfig.dartls.setup{
  cmd = {dart_sdk .. "dart", dart_sdk .. "snapshots/analysis_server.dart.snapshot", "--lsp"},
  on_attach = lsp_status.on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics;
  }
}

-- webmacro
lspconfig.webmacrols.setup{}

-- lspkind plugin
local lspkind = require('lspkind')
lspkind.init()

-- lsp saga
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
  code_action_prompt = { enable = false,
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

-- completion
local compe = require('compe')
compe.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'always',
  throttle_time = 60,
  source_timeout = 300,
  resolve_timeout = 600,
  incomplete_delay = 600,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  source = {
    path = true,
    buffer = {
      ignored_filetypes = {'json', 'text', ''}
    },
    calc = false,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = false,
    ultisnips = false,
    luasnip = false,
  },
}

vim.api.nvim_command('augroup completion')
vim.api.nvim_command("autocmd FileType dart let g:compe={}")
vim.api.nvim_command("autocmd FileType dart let g:compe.preselect = 'enable'")
vim.api.nvim_command('augroup END')

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {expr=true, noremap=true, silent=true})
vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm("<CR>")', {expr=true, noremap=true})

-- trouble
local trouble = require('trouble')
trouble.setup{}
vim.api.nvim_set_keymap('n', '<F4>', ':TroubleToggle<CR>', {noremap=true, silent=true})
