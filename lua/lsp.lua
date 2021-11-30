local configs = require('lspconfig/configs')
local util = require('lspconfig/util')
local lspconfig = require('lspconfig');
local lsp_status = require('lsp-status')

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
lspconfig.vimls.setup{}

-- bash
lspconfig.bashls.setup{}

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
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics;
  }
}

-- webmacro
lspconfig.webmacrols.setup{}
