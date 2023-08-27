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
    local stat = vim.uv.fs_stat(filename)
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
            modules = {'tensorflow', 'torch', 'torchvision', 'torchaudio', 'transformers', 'datasets', 'diffusers'}
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
              'diffusers',
            }
          },
          pycodestyle = {
            -- convention = 'google',
            ignore = {'W391', 'E303', 'E501', 'E226', 'W504', 'E251', 'W503', 'E126'},
            indentSize = 2,
            maxLineLength = 120,
          }
        }
      }
    }
  }

  -- bash
  lspconfig.bashls.setup{}

  -- rust
  lspconfig.rust_analyzer.setup{}

  -- lua
  local lua_lsp_path = vim.uv.os_homedir() .. '/.local/lsp/lua-language-server'
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

  -- dart
  local dart_path = vim.uv.os_homedir() .. '/flutter/bin/dart'
  if file_exists(dart_path) then
    lspconfig.dartls.setup{
      cmd = { dart_path, 'language-server', '--protocol=lsp' },
    }
  end

  -- webmacro
  lspconfig.webmacrols.setup{}

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
  vim.fn.sign_define('DiagnosticSignError', {
    text = '✖ ',
    texthl = 'DiagnosticSignError',
    numhl = 'DiagnosticError'
  })
  vim.fn.sign_define('DiagnosticSignWarn', {
    text = '⚠ ',
    texthl = 'DiagnosticSignWarn',
    numhl = 'DiagnosticWarn',
  })
  vim.fn.sign_define('DiagnosticSignInfo', {
    text = 'ⓘ ',
    texthl = 'DiagnosticSignInfo',
    numhl = 'DiagnosticInfo',
  })
  vim.fn.sign_define('DiagnosticSignHint', {
    text = '🗒',
    texthl = 'DiagnosticSignHint',
    numhl = 'DiagnosticHint',
  })

  -- commands
  vim.api.nvim_create_user_command('GotoDeclaration', vim.lsp.buf.declaration, {})
  vim.api.nvim_create_user_command('GotoImplementation', vim.lsp.buf.implementation, {})
  vim.api.nvim_set_keymap('n', '<C-A-b>', '', {
    silent = true,
    noremap = true,
    callback = vim.lsp.buf.implementation,
    desc = 'Goto implementation',
  })
  vim.api.nvim_create_user_command('GotoTypeDefinition', vim.lsp.buf.type_definition, {})
  vim.api.nvim_set_keymap('n', '<C-S-b>', '', {
    silent = true,
    noremap = true,
    callback = vim.lsp.buf.type_definition,
    desc = 'Goto type definition',
  })
  vim.api.nvim_create_user_command('GotoReferences', vim.lsp.buf.references, {})
  vim.api.nvim_set_keymap('n', '<S-A-7>', '', {
    silent = true,
    noremap = true,
    callback = vim.lsp.buf.references,
    desc = 'Goto type definition',
  })

  -- vim.api.nvim_create_user_command('GotoDocumentSymbol', vim.lsp.buf.document_symbol, {})
  -- vim.api.nvim_create_user_command('GotoWorkspaceSymbol', vim.lsp.buf.workspace_symbol, {})
  -- vim.api.nvim_create_user_command('DisplayInfo', vim.lsp.buf.hover, {})
  -- vim.api.nvim_create_user_command('LspSignature', vim.lsp.buf.signature_help, {})

  vim.api.nvim_create_user_command('LspFormat', function()
    vim.lsp.buf.format({
      formatting_options = {
        async = true,
      },
    })
  end, {})
  vim.api.nvim_set_keymap('n', '<C-A-l>', '', {
    silent = true,
    noremap = true,
    callback = function()
      vim.lsp.buf.format({
        async = true,
        timeout_ms = 10000,
      })
    end,
    desc = 'LSP format',
  })

  -- debuggin lsp clients
  vim.api.nvim_create_user_command('LspClients', function()
    print(vim.inspect(vim.lsp.get_clients()))
  end, {})


  require('lualine').setup{
    options = {
      theme = 'onedark',
      section_separators = {'◗', '◖'},
      component_separators = {'►', '◄'}
    },
    sections = {
      lualine_c = {'filename', "require'lsp-status'.status()"},
      lualine_x = {"require'lsp-status'.status()", 'encoding', 'fileformat', 'filetype'},
    },
  }
end

return lsp
