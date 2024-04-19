local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local uv = vim.uv or vim.loop

local lsp = {}

lsp.setup_inlay_hint = function()
  local inlay_hints = false
  local set_inlay_hints_keys = function(mode)
    vim.api.nvim_set_keymap(mode, '<F5>', '', {
      silent = true,
      noremap = true,
      callback = function()
        inlay_hints = not inlay_hints
        vim.lsp.inlay_hint.enable(0, inlay_hints)
        if inlay_hints then
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

lsp.setup = function()
  vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local message_handler = function(err, result, ctx, config)
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

  -- setting lsp
  lsp_status.register_progress()

  local function file_exists(filename)
    local stat = uv.fs_stat(filename)
    return stat and stat.type or false
  end

  -- c++
  local clangd_handler = lsp_status.extensions.clangd.setup()
  local clangd = '/usr/bin/clangd'
  if file_exists(clangd) then
    local idf = os.getenv('IDF_PATH')
    local cmd = { clangd, '--background-index', '--header-insertion=never' }
    if idf and #idf > 0 then
      local query_driver = '--query-driver=' ..
          uv.os_homedir() .. '/.espressif/tools/xtensa-esp32-elf/*/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc'
      table.insert(cmd, query_driver)
    end
    lspconfig.clangd.setup {
      cmd = cmd,
      handlers = clangd_handler,
      filetypes = { 'c', 'cpp', 'cuda' },
      init_options = {
        clangdFileStatus = true
      },
    }
  end

  -- javascript/typescript
  lspconfig.tsserver.setup {}

  lspconfig.eslint.setup {}

  local snyk_token = os.getenv('SNYK_TOKEN')
  if snyk_token and #snyk_token > 0 then
    lspconfig.snyk_ls.setup {
      init_options = {
        integrationName = 'nvim',
        token = snyk_token,
        activateSnykCodeQuality = 'true',
        trustedFolders = {
          uv.os_homedir() .. '/.config',
          uv.os_homedir() .. '/.local',
          uv.os_homedir() .. '/projects',
          uv.os_homedir() .. '/programming',
        },
      }
    }
  end

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
    filetypes = { 'html', 'webmacro' }
  }

  -- python
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
            -- convention = 'google',
            ignore = { 'W391', 'E303', 'E501', 'E226', 'W504', 'E251', 'W503', 'E126' },
            indentSize = 2,
            maxLineLength = 120,
          }
        }
      }
    }
  }

  -- bash
  lspconfig.bashls.setup {}

  -- rust
  lspconfig.rust_analyzer.setup {}

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
  local glslls_path = uv.os_homedir() .. '/.local/lsp/glsl-language-server/build/glslls'
  if file_exists(glslls_path) then
    lspconfig.glslls.setup {
      cmd = { glslls_path, '--stdin' },
    }
  end

  -- lspkind plugin
  local lspkind = require('lspkind')
  lspkind.init()


  local npairs = require('nvim-autopairs')
  npairs.setup {
    -- map_cr = true,
  }

  -- completion
  local completion = require('completion')
  completion.setup {
    cr_mapping = npairs.autopairs_cr,
  }

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

  local status_icons = function()
    local current = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(current)
    if #diagnostics > 0 then
      local bug = ''
      for i = 1, #diagnostics, 1 do
        local severity = diagnostics[i].severity
        if severity == vim.diagnostic.severity.ERROR then
          bug = bug .. '🐁'
        elseif severity == vim.diagnostic.severity.WARN then
          bug = bug .. '🐀'
        elseif severity == vim.diagnostic.severity.INFO then
          bug = bug .. '🐺'
        elseif severity == vim.diagnostic.severity.HINT then
          bug = bug .. '🐹'
        end
      end
      return bug
    else
      if vim.fn.mode() == 'n' then
        return '🐕'
      elseif vim.fn.mode() == 'i' then
        return '🐧'
      elseif vim.fn.mode() == 's' then
        return '🐇'
      end
      return '🐘'
    end
  end

  require('lualine').setup {
    options = {
      theme = 'onedark',
      section_separators = { '◗', '◖' },
      component_separators = { '►', '◄' }
    },
    sections = {
      lualine_c = {
        'filename',
        status_icons,
        'require("lsp-status").status()',
      },
      lualine_x = {
        {
          'nvim_treesitter#statusline',
          type = 'vim_fun'
        },
        'encoding',
        'fileformat',
        'filetype'
      },
    },
  }

  lsp.setup_inlay_hint()
end

return lsp
