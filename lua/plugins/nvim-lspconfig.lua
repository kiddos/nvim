local uv = vim.uv or vim.loop
local api = vim.api

local function config()
  vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '🐞',
        [vim.diagnostic.severity.WARN] = '🐝',
        [vim.diagnostic.severity.INFO] = '🐏',
        [vim.diagnostic.severity.HINT] = '🦉',
      },
    },
    update_in_insert = false,
    severity_sort = true,
  })

  -- basecode lsp
  if vim.fn.executable('basecode-lsp') then
    vim.lsp.enable('basecodels')
  end

  -- c++
  if vim.fn.executable('clangd') then
    local query_drivers = {
      '/usr/bin/clang++-*',
      '/usr/bin/clang-*',
      '/usr/bin/g++-*',
      '/usr/bin/gcc-*',
      '/usr/bin/arm-none-eabi-gcc*',
    }
    local xtensa_esp = uv.os_homedir() .. '/.espressif/tools/xtensa-esp32-elf'
    if vim.fn.isdirectory(xtensa_esp) then
      table.insert(query_drivers, xtensa_esp .. '/**/bin/xtensa-esp32-elf-*')
    end
    local cmd = {
      'clangd',
      '--background-index',
      '--query-driver=' .. table.concat(query_drivers, ','),
      '--header-insertion=never',
      '--log=error',
      '--offset-encoding=utf-16',
    }
    vim.lsp.config('clangd', {
      cmd = cmd,
    })
    vim.lsp.enable('clangd')
  end

  if vim.fn.executable('cmake-language-server') then
    vim.lsp.enable('cmake')
  end

  if vim.fn.executable('node') then
    -- javascript/typescript
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('eslint')

    -- css
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config('cssls', {
      capabilities = capabilities,
    })
    vim.lsp.config('html', {
      capabilities = capabilities,
    })
    vim.lsp.enable('html')
    vim.lsp.enable('cssls')

    -- bash
    if vim.fn.executable('bash-language-server') then
      vim.lsp.enable('bashls')
    end
  end

  local snyk_token = os.getenv('SNYK_TOKEN')
  if snyk_token and #snyk_token > 0 and vim.fn.executable('snyk-ls') then
    vim.lsp.config('snyk_ls', {
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
    })
    vim.lsp.enable('snyk_ls')
  end

  -- python
  if vim.fn.executable('pylsp') then
    vim.lsp.config('pylsp', {
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
              ignore = { 'E501' },
            },
          }
        }
      },
    })
    vim.lsp.enable('pylsp')
  end

  -- rust
  vim.lsp.enable('rust_analyzer')

  -- lua
  local lua_lsp_path = uv.os_homedir() .. '/.local/lsp/lua-language-server'
  local lua_lsp_binary = lua_lsp_path .. '/bin/lua-language-server'
  if vim.fn.executable(lua_lsp_binary) then
    vim.lsp.config('lua_ls', {
      cmd = { lua_lsp_binary },
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
    })
    vim.lsp.enable('lua_ls')
  end

  -- dart
  if vim.fn.executable('flutter') then
    local dart_path = uv.os_homedir() .. '/flutter/bin/dart'
    vim.lsp.config('dartls', {
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
    })
    vim.lsp.enable('dartls')
  end

  if vim.fn.executable('glsl_analyzer') then
    vim.lsp.enable('glsl_analyzer')
  end

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
          vim.notify('✅ Enable Inlay Hints')
        else
          vim.notify('🛑 Disable Inlay Hints', vim.log.levels.WARN)
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
  config = config,
}
