local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')

local lsp = {}

lsp.setup = function()
  vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- setting lsp
  lsp_status.register_progress()

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
      cmd = {clangd, '--background-index', '--header-insertion=never'};
      handlers = clangd_handler,
      filetypes= {'c', 'cpp', 'cuda'},
      init_options = {
        clangdFileStatus = true
      },
    }
  end

  -- javascript/typescript
  lspconfig.tsserver.setup{}

  lspconfig.eslint.setup{}

  -- css
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  lspconfig.cssls.setup{
    capabilities = capabilities,
    filetypes = {'css', 'scss', 'less', 'html', 'webmacro'}
  }

  -- html
  lspconfig.html.setup {
    capabilities = capabilities,
    filetypes = {'html', 'webmacro'}
  }

  -- python
  lspconfig.pylsp.setup{
    settings = {
      pylsp = {
        plugins = {
          preload = {
            modules = {'tensorflow', 'torch', 'torchvision', 'torchaudio', 'transformers', 'datasets'}
          },
          autopep8 = {
            enabled = false,
          },
          yapf = {
            enabled = true,
          },
          jedi_completion = {
            cache_for = {
              'pandas',
              'numpy',
              'tensorflow',
              'matplotlib',
              'torch',
              'torchvision',
              'torchaudio',
              'transformers',
              'datasets',
            }
          },
          pycodestyle = {
            -- convention = 'google',
            ignore = {'W391', 'E303', 'E501', 'E226'},
            indentSize = 2,
            maxLineLength = 120,
          }
        }
      }
    }
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
  local lua_lsp_path = vim.loop.os_homedir() .. '/.local/lsp/lua-language-server'
  local lua_lsp_binary = lua_lsp_path .. '/bin/lua-language-server'
  if file_exists(lua_lsp_binary) then
    lspconfig.lua_ls.setup{
      cmd = { lua_lsp_binary },
      settings = {
        Lua = {
          diagnostics = {
            globals = {'vim', 'use', 'use_rocks'}
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

  -- webmacro
  lspconfig.webmacrols.setup{}

  -- yaml
  lspconfig.yamlls.setup{}

  -- latex
  lspconfig.texlab.setup{}

  -- R
  lspconfig.r_language_server.setup{}

  -- lspkind plugin
  local lspkind = require('lspkind')
  lspkind.init()


  local npairs = require('nvim-autopairs')
  npairs.setup({
    -- map_cr = true,
  })

  -- completion
  local completion = require('completion')
  completion.setup({
    cr_mapping = npairs.autopairs_cr
  })


  -- sign
  vim.api.nvim_command('sign define DiagnosticSignError text=✖ texthl=DiagnosticSignError linehl= numhl=')
  vim.api.nvim_command('sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=')
  vim.api.nvim_command('sign define DiagnosticSignInfo text=ⓘ texthl=DiagnosticSignInfo linehl= numhl=')
  vim.api.nvim_command('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')
  -- vim.api.nvim_command('sign define LspDiagnosticsSignError text= texthl=Text linehl= numhl=')
  -- vim.api.nvim_command('sign define LspDiagnosticsSignWarning text=❗️ texthl=Text linehl= numhl=')

  -- commands
  -- vim.api.nvim_create_user_command('GotoDeclaration', vim.lsp.buf.declaration, {})
  -- vim.api.nvim_create_user_command('GotoImplementation', vim.lsp.buf.implementation, {})
  -- vim.api.nvim_create_user_command('GotoTypeDefinition', vim.lsp.buf.type_definition, {})
  -- vim.api.nvim_create_user_command('GotoReferences', vim.lsp.buf.references, {})
  -- vim.api.nvim_create_user_command('GotoDocumentSymbol', vim.lsp.buf.document_symbol, {})
  -- vim.api.nvim_create_user_command('GotoWorkspaceSymbol', vim.lsp.buf.workspace_symbol, {})
  -- vim.api.nvim_create_user_command('DisplayInfo', vim.lsp.buf.hover, {})
  -- vim.api.nvim_create_user_command('LspListDocumentSymbol', vim.lsp.buf.document_symbol, {})
  vim.api.nvim_create_user_command('LspFormat', function()
    vim.lsp.buf.format({})
  end, {})
  vim.api.nvim_create_user_command('LspClients', function()
    print(vim.inspect(vim.lsp.buf_get_clients()))
  end, {})
  -- vim.api.nvim_create_user_command('LspIncomingCalls', vim.lsp.buf.incoming_calls, {})
  -- vim.api.nvim_create_user_command('LspOutgoingCalls', vim.lsp.buf.outgoing_calls, {})
  -- vim.api.nvim_create_user_command('LspSignature', vim.lsp.buf.signature_help, {})


  -- lualine
  require('lualine').setup{
    options = {
      theme = 'onedark',
      section_separators = {'◗', '◖'},
      component_separators = {'►', '◄'}
    },
    sections = {
      lualine_c = {'filename', "require'lsp-status'.status()"},
      lualine_x = {'tabnine'},
      --[[ lualine_x = {"require'lsp-status'.status()", 'encoding', 'fileformat', 'filetype'}, ]]
    },
  }

  require('lspfuzzy').setup{}
end

return lsp
