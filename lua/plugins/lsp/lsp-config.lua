local uv = vim.uv or vim.loop
local api = vim.api

local function file_exists(filename)
  if not filename then
    return false
  end
  local stat = uv.fs_stat(filename)
  return stat and stat.type or false
end

local function is_node_installed()
  vim.fn.system("node -v")
  return vim.v.shell_error == 0
end

local function is_pylsp_installed()
  vim.fn.system("pylsp -V")
  return vim.v.shell_error == 0
end

local function config()
  vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local lspconfig = require('lspconfig')

  local function message_handler(err, result, ctx, conf)
    if not err then
      local message_type = result.type
      local message = result.message
      local log_level = vim.log.levels.INFO
      if message_type == 1 then
        log_level = vim.log.levels.ERROR
      elseif message_type == 2 then
        log_level = vim.log.levels.WARN
      elseif message_type == 3 then
        log_level = vim.log.levels.INFO
      elseif message_type == 4 then
        log_level = vim.log.levels.INFO
      elseif message_type == 5 then
        log_level = vim.log.levels.TRACE
      end
      vim.notify_once(message, log_level, {
        title = 'LSP',
        timeout = 1000,
      })
    end
  end

  lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
      handlers = {
        ['window/showMessage'] = message_handler,
        -- ['window/logMessage'] = message_handler,
      }
    }
  )

  local lsp_status = require('lsp-status')
  lsp_status.register_progress()

  -- basecode lsp
  lspconfig.basecodels.setup {}

  -- c++
  local clangd_handler = lsp_status.extensions.clangd.setup()
  local clangd = '/usr/bin/clangd'
  if file_exists(clangd) then
    local cmd = {
      clangd,
      '--background-index',
      '--query-driver=/usr/bin/**/clang-*,/usr/bin/*g++,/usr/bin/*gcc',
      '--header-insertion=never',
      '--log=error',
      '--offset-encoding=utf-16',
    }
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

    lspconfig.clangd.setup {
      cmd = cmd,
      handlers = clangd_handler,
      filetypes = { 'c', 'cpp', 'cuda' },
      init_options = {
        clangdFileStatus = true
      },
      on_attach = lsp_status.on_attach,
      capabilities = capabilities,
    }
  end

  local has_node = is_node_installed()
  if has_node then
    -- javascript/typescript
    lspconfig.ts_ls.setup {}
    lspconfig.eslint.setup {}

    -- css
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.cssls.setup {
      capabilities = capabilities,
      filetypes = { 'css', 'sass', 'scss', 'less', 'html', 'webmacro' }
    }
    lspconfig.cssmodules_ls.setup {}

    -- html
    lspconfig.html.setup {
      capabilities = capabilities,
      filetypes = { 'html', 'webmacro', 'jsp' }
    }

    -- bash
    lspconfig.bashls.setup {}
  end

  local snyk_token = os.getenv('SNYK_TOKEN')
  if snyk_token and #snyk_token > 0 then
    lspconfig.snyk_ls.setup {
      init_options = {
        integrationName = 'nvim',
        token = snyk_token,
        activateSnykCodeQuality = 'true',
        trustedFolders = {
          uv.os_homedir() .. '/.cache',
          uv.os_homedir() .. '/.config',
          uv.os_homedir() .. '/.local',
          uv.os_homedir() .. '/projects',
          uv.os_homedir() .. '/programming',
        },
      }
    }
  end

  -- python
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)
  if is_pylsp_installed() then
    lspconfig.pylsp.setup {
      handlers = lsp_status.extensions.pyls_ms.setup(),
      settings = {
        pylsp = {
          plugins = {
            preload = {
              modules = { 'tensorflow', 'torch', 'torchvision', 'torchaudio', 'transformers', 'datasets', 'diffusers' }
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
              convention = 'google',
              maxLineLength = 120,
            }
          }
        }
      },
      on_attach = lsp_status.on_attach,
      capabilities = capabilities
    }
  end

  -- rust
  capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)
  lspconfig.rust_analyzer.setup {
    on_attach = lsp_status.on_attach,
    capabilities = capabilities
  }

  -- lua
  local lua_lsp_path = uv.os_homedir() .. '/.local/lsp/lua-language-server'
  local lua_lsp_binary = lua_lsp_path .. '/bin/lua-language-server'
  if file_exists(lua_lsp_binary) then
    lspconfig.lua_ls.setup {
      cmd = { lua_lsp_binary },
      on_init = function(client)
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        return true
      end,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'use', 'use_rocks' }
          },
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      }
    }
  end

  -- dart
  local dart_path = uv.os_homedir() .. '/flutter/bin/dart'
  if file_exists(dart_path) then
    lspconfig.dartls.setup {
      cmd = { dart_path, 'language-server', '--protocol=lsp' },
      init_options = {
        closingLabels = false,
        flutterOutline = false,
        onlyAnalyzeProjectsWithOpenFiles = true,
        outline = false,
        suggestFromUnimportedLibraries = true
      },
      settings = {
        completeFunctionCalls = true,
        showTodos = true,
        enableSnippets = false,
      }
    }
  end

  -- webmacro
  lspconfig.webmacrols.setup {}

  -- R
  lspconfig.r_language_server.setup {}

  -- glsl
  -- local glslls_path = uv.os_homedir() .. '/.local/lsp/glsl-language-server/build/glslls'
  -- if file_exists(glslls_path) then
  --   lspconfig.glslls.setup {
  --     cmd = { glslls_path, '--stdin' },
  --   }
  -- end

  -- sign
  vim.fn.sign_define('DiagnosticSignError', {
    text = '🐞',
    texthl = 'DiagnosticSignError',
    numhl = 'DiagnosticError'
  })
  vim.fn.sign_define('DiagnosticSignWarn', {
    text = '💩',
    texthl = 'DiagnosticSignWarn',
    numhl = 'DiagnosticWarn',
  })
  vim.fn.sign_define('DiagnosticSignInfo', {
    text = '🤖',
    texthl = 'DiagnosticSignInfo',
    numhl = 'DiagnosticInfo',
  })
  vim.fn.sign_define('DiagnosticSignHint', {
    text = '🐾',
    texthl = 'DiagnosticSignHint',
    numhl = 'DiagnosticHint',
  })

  -- commands
  api.nvim_set_keymap('n', '<C-A-l>', '', {
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
  api.nvim_create_user_command('LspClients', function()
    print(vim.inspect(vim.lsp.get_clients()))
  end, {})

  local function set_inlay_hints_keys(mode)
    api.nvim_set_keymap(mode, '<F5>', '', {
      silent = true,
      noremap = true,
      callback = function()
        local enable = not vim.lsp.inlay_hint.is_enabled()
        vim.lsp.inlay_hint.enable(enable)
        if enable then
          vim.notify('Enable Inlay Hints')
        else
          vim.notify('Disable Inlay Hints', vim.log.levels.WARN)
        end
      end,
    })
  end

  set_inlay_hints_keys('n')
  set_inlay_hints_keys('i')
end

return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    { 'nvim-lua/lsp-status.nvim' },
    { 'hoob3rt/lualine.nvim' },
    { 'onsails/lspkind-nvim' },
  },
  config = config,
}
