local configs = require('lspconfig/configs')
local util = require('lspconfig/util')
local lspconfig = require('lspconfig');
configs.webmacrols = {
  default_config = {
    cmd = {"webmacro-language-server", "--stdio"},
    filetypes = {"webmacro"},
    root_dir = function(fname)
      return util.root_pattern('build.xml', '.git', 'ivy.xml')(fname) or vim.loop.os_homedir()
    end
  }
}

local on_publish_diagnostics = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false
  }
);

-- c++
lspconfig.clangd.setup{
  cmd = {"clangd-10", "--background-index", "--header-insertion=never"};
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  }
};

-- javascript/typescript
lspconfig.tsserver.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  }
}

-- css
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup{
  capabilities = capabilities,
  cmd = {"vscode-css-language-server", "--stdio"};
}

-- html
lspconfig.html.setup {
  capabilities = capabilities,
  cmd = {"vscode-html-language-server", "--stdio"};
}

-- python
lspconfig.jedi_language_server.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  }
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
lspconfig.rust_analyzer.setup{}

-- lua
local sumneko_root_path = vim.loop.os_homedir() .. "/.local/lsp/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
lspconfig.sumneko_lua.setup{
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  handlers = {
    ["textDocument/publishDiagnostics"] = on_publish_diagnostics,
  }
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
