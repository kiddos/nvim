local configs = require('lspconfig/configs')
local util = require('lspconfig/util')
local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')

-- setting lsp
lsp_status.register_progress()

-- enable lsp diagnostic
local on_publish_diagnostics = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  }
);


-- c++
local clangd_handler = lsp_status.extensions.clangd.setup()
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
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
}

lspconfig.eslint.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  },
}

-- css
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup{
  capabilities = capabilities,
  on_attach = lsp_status.on_attach,
}

-- html
lspconfig.html.setup {
  capabilities = capabilities,
  on_attach = lsp_status.on_attach,
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
  on_attach = lsp_status.on_attach,
}

-- rust
lspconfig.rust_analyzer.setup{
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
}

-- lua
local sumneko_root_path = vim.loop.os_homedir() .. '/.local/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'
lspconfig.sumneko_lua.setup{
  cmd = { sumneko_binary },
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
}

-- dart
local home = vim.loop.os_homedir()
local dart_sdk = home .. '/.local/flutter/bin/cache/dart-sdk/bin/'
lspconfig.dartls.setup{
  cmd = {dart_sdk .. 'dart', dart_sdk .. 'snapshots/analysis_server.dart.snapshot', '--lsp'},
  on_attach = lsp_status.on_attach,
  handlers = {
    ['textDocument/publishDiagnostics'] = on_publish_diagnostics;
  }
}

-- webmacro
lspconfig.webmacrols.setup{}

-- java language server
local java_lsp_bin = home .. '/.local/lsp/java-language-server/dist/lang_server_linux.sh'
lspconfig.java_language_server.setup{
  cmd = {java_lsp_bin,  '--quiet'},
  on_attach = lsp_status.on_attach,
}

-- yaml
lspconfig.yamlls.setup{}

-- latex
lspconfig.texlab.setup{
  on_attach = lsp_status.on_attach,
}

-- R
lspconfig.r_language_server.setup{
  on_attach = lsp_status.on_attach,
}


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

vim.api.nvim_set_var('mapleader', ',')
vim.api.nvim_set_keymap('n', '<Leader>find', [[<Cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>code', [[<Cmd>lua require'lspsaga.codeaction'.code_action()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('v', '<Leader>code', [[<Cmd>lua require'lspsaga.codeaction'.rannge_code_action()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>doc', [[<Cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>sig', [[<Cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>rename', [[<Cmd>lua require'lspsaga.rename'.rename()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>def', [[<Cmd>lua require'lspsaga.provider'.preview_definition()<CR>]], {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>impl', [[<Cmd>lua require'lspsaga.implement'.lspsaga_implementation()<CR>]], {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<Leader>diag', [[<Cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>]], {noremap=true, silent=true})
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


local npairs = require('nvim-autopairs')
npairs.setup()
require('nvim-autopairs.completion.compe').setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = false, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = false,  -- auto select first item
})

-- sign
vim.api.nvim_command('sign define DiagnosticSignError text=✖ texthl=DiagnosticSignError linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignInfo text=ⓘ texthl=DiagnosticSignInfo linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')
-- vim.api.nvim_command('sign define LspDiagnosticsSignError text= texthl=Text linehl= numhl=')
-- vim.api.nvim_command('sign define LspDiagnosticsSignWarning text=❗️ texthl=Text linehl= numhl=')

-- commands
vim.api.nvim_command('command GotoDeclaration lua vim.lsp.buf.declaration()')
vim.api.nvim_command('command GotoImplementation lua vim.lsp.buf.implementation()')
vim.api.nvim_command('command GotoTypeDefinition lua vim.lsp.buf.type_definition()')
vim.api.nvim_command('command GotoReferences lua vim.lsp.buf.references()')
vim.api.nvim_command('command GotoDocumentSymbol lua vim.lsp.buf.document_symbol()')
vim.api.nvim_command('command GotoWorkspaceSymbol lua vim.lsp.buf.workspace_symbol()')
vim.api.nvim_command('command LspClients lua print(vim.inspect(vim.lsp.buf_get_clients()))')


-- lualine
require('lualine').setup{
  options = {
    theme = 'onedark',
    section_separators = {'◗', '◖'},
    component_separators = {'►', '◄'}
  },
  sections = {
    lualine_c = {'filename', "require'lsp-status'.status()"},
    --[[ lualine_x = {"require'lsp-status'.status()", 'encoding', 'fileformat', 'filetype'}, ]]
  },
}
