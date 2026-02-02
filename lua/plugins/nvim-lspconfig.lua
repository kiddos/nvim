local uv = vim.uv or vim.loop
local api = vim.api
local lsp = vim.lsp

local function setup_clangd()
  if not vim.fn.executable('clangd') then
    return
  end

  local query_drivers = {
    '/usr/bin/clang++-*',
    '/usr/bin/clang-*',
    '/usr/bin/g++-*',
    '/usr/bin/gcc-*',
  }

  local executable = 'clangd'
  local espressif_root = uv.os_homedir() .. '/.espressif'
  local xtensa_esp = espressif_root .. '/tools/xtensa-esp-elf'
  local riscv32_esp = espressif_root .. '/tools/riscv32-esp-elf'
  if vim.fn.executable('idf.py') == 1 and vim.fn.isdirectory(xtensa_esp) == 1 then
    local patterns = {
      xtensa_esp .. '/**/bin/xtensa-esp*-elf-gcc',
      xtensa_esp .. '/**/bin/xtensa-esp*-elf-g++',
      xtensa_esp .. '/**/bin/xtensa-esp*-elf-cc',
      xtensa_esp .. '/**/bin/xtensa-esp*-elf-c++',
      riscv32_esp .. '/**/bin/riscv32-esp*-elf-gcc',
      riscv32_esp .. '/**/bin/riscv32-esp*-elf-g++',
    }
    local esp_query_drivers = {}
    for _, pattern in pairs(patterns) do
      local drivers = vim.fn.glob(pattern, false, true)
      for _, file in ipairs(drivers) do
        table.insert(esp_query_drivers, file)
      end
    end
    if #esp_query_drivers > 0 then
      query_drivers = esp_query_drivers
    end

    local executable_pattern = espressif_root .. '/tools/esp-clang/*/esp-clang/bin/clangd'
    local esp_clangd = vim.fn.glob(executable_pattern, false, true)
    if #esp_clangd > 0 then
      executable = esp_clangd[1]
    end
  end

  local cmd = {
    executable,
    '--background-index',
    '--query-driver=' .. table.concat(query_drivers, ','),
    '--header-insertion=never',
    '--log=error',
    '--offset-encoding=utf-16',
  }
  lsp.config('clangd', {
    cmd = cmd,
  })
  lsp.enable('clangd')
end

local function setup_weblsp()
  if vim.fn.executable('node') == 0 then
    return
  end

  -- javascript/typescript
  lsp.enable('ts_ls')
  lsp.enable('eslint')

  -- css
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lsp.config('cssls', {
    capabilities = capabilities,
  })
  lsp.config('html', {
    capabilities = capabilities,
  })
  lsp.enable('html')
  lsp.enable('cssls')
end

local function setup_snyk_lsp()
  local snyk_token = os.getenv('SNYK_TOKEN')
  if snyk_token and #snyk_token > 0 and vim.fn.executable('snyk-ls') == 1 then
    lsp.config('snyk_ls', {
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
    lsp.enable('snyk_ls')
  end
end

local function setup_python_lsp()
  lsp.config('pylsp', {
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
  lsp.enable('pylsp')
end

local function setup_lua_lsp()
  if vim.fn.executable('lua-language-server') == 0 then
    return
  end
  lsp.config('lua_ls', {
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
  lsp.enable('lua_ls')
end

local function setup_dartls()
  lsp.config('dartls', {
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
  lsp.enable('dartls')
end

local function config()
  lsp.set_log_level("info")

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

  lsp.enable('basecodels')
  setup_clangd()
  lsp.enable('neocmake')
  lsp.enable('bashls')
  setup_weblsp()
  setup_snyk_lsp()
  setup_python_lsp()
  lsp.enable('rust_analyzer')
  setup_lua_lsp()
  setup_dartls()
  lsp.enable('glsl_analyzer')
  lsp.enable('lemminx')

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
