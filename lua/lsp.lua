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

local function file_exists(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type or false
end

-- c++
local clangd_handler = lsp_status.extensions.clangd.setup()
local clangd = 'clangd'
if file_exists('/usr/bin/clangd-14') then
  clangd = 'clangd-14'
end

if file_exists('/usr/bin/' .. clangd) then
  lspconfig.clangd.setup{
    cmd = {clangd, "--background-index", "--header-insertion=never"};
    handlers = clangd_handler,
    init_options = {
      clangdFileStatus = true
    },
  }
end

-- javascript/typescript
lspconfig.tsserver.setup{}

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
}

-- html
lspconfig.html.setup {
  capabilities = capabilities,
}

-- python
lspconfig.jedi_language_server.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  },
}

-- vim
lspconfig.vimls.setup{}

-- bash
lspconfig.bashls.setup{}

-- angular
lspconfig.angularls.setup{}

-- rust
lspconfig.rust_analyzer.setup{}

-- lua
local sumneko_root_path = vim.loop.os_homedir() .. '/.local/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/lua-language-server'
if file_exists(sumneko_binary) then
  lspconfig.sumneko_lua.setup{
    cmd = { sumneko_binary },
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'}
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
          }
        }
      }
    }
  }
end

-- dart
local home = vim.loop.os_homedir()
local dart_sdk = home .. '/.local/flutter/bin/cache/dart-sdk/bin/'
local executable = dart_sdk .. 'dart'
if file_exists(executable) then
  lspconfig.dartls.setup{
    cmd = {dart_sdk .. 'dart', dart_sdk .. 'snapshots/analysis_server.dart.snapshot', '--lsp'},
    handlers = {
      ['textDocument/publishDiagnostics'] = on_publish_diagnostics;
    }
  }
end

-- webmacro
lspconfig.webmacrols.setup{}

-- java language server
local java_lsp_bin = home .. '/.local/lsp/java-language-server/dist/lang_server_linux.sh'
if file_exists(java_lsp_bin) then
  lspconfig.java_language_server.setup{
    cmd = {java_lsp_bin,  '--quiet'},
  }
end

-- yaml
lspconfig.yamlls.setup{}

-- latex
lspconfig.texlab.setup{}

-- R
lspconfig.r_language_server.setup{}


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
local completion = require('completion')
completion.setup()

local npairs = require('nvim-autopairs')
npairs.setup({
  map_cr = false,
})

-- sign
vim.api.nvim_command('sign define DiagnosticSignError text=✖ texthl=DiagnosticSignError linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignInfo text=ⓘ texthl=DiagnosticSignInfo linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')
-- vim.api.nvim_command('sign define LspDiagnosticsSignError text= texthl=Text linehl= numhl=')
-- vim.api.nvim_command('sign define LspDiagnosticsSignWarning text=❗️ texthl=Text linehl= numhl=')

-- commands
vim.api.nvim_create_user_command('GotoDeclaration', vim.lsp.buf.declaration, {})
vim.api.nvim_create_user_command('GotoImplementation', vim.lsp.buf.implementation, {})
vim.api.nvim_create_user_command('GotoTypeDefinition', vim.lsp.buf.type_definition, {})
vim.api.nvim_create_user_command('GotoReferences', vim.lsp.buf.references, {})
vim.api.nvim_create_user_command('GotoDocumentSymbol', vim.lsp.buf.document_symbol, {})
vim.api.nvim_create_user_command('GotoWorkspaceSymbol', vim.lsp.buf.workspace_symbol, {})
vim.api.nvim_create_user_command('DisplayInfo', vim.lsp.buf.hover, {})
vim.api.nvim_create_user_command('LspListDocumentSymbol', vim.lsp.buf.document_symbol, {})
vim.api.nvim_create_user_command('LspFormat', function()
  vim.lsp.buf.format({})
end, {})
vim.api.nvim_create_user_command('LspClients', function()
  print(vim.inspect(vim.lsp.buf_get_clients()))
end, {})
vim.api.nvim_create_user_command('LspIncomingCalls', vim.lsp.buf.incoming_calls, {})
vim.api.nvim_create_user_command('LspOutgoingCalls', vim.lsp.buf.outgoing_calls, {})
vim.api.nvim_create_user_command('LspSignature', vim.lsp.buf.signature_help, {})


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
