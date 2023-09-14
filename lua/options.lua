local options = {}

options.apply = function()
  -- File type setting
  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = { '*.i', '*.swg' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'filetype', 'swig')
    end
  })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = { '*.BUILD' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'filetype', 'bzl')
    end
  })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = { '*.m' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'filetype', 'objc')
    end
  })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = { '*.mm' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'filetype', 'objcpp')
    end
  })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = { '*.h' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'filetype', 'cpp')
    end
  })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = { '*.pro' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'filetype', 'make')
    end
  })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, {
    pattern = { '*.wmm' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'filetype', 'webmacro')
    end
  })

  vim.opt.langmenu = 'en_US.UTF-8'

  -- Icon Setting
  -- vim.o.icon = true
  -- vim.o.iconstring = 'nvim'

  -- Rendering setting
  -- more performant
  vim.opt.lazyredraw = true
  vim.opt.redrawtime = 3000

  -- Editing setting
  -- confirm when ":q" or ":e"
  vim.opt.confirm = true

  -- line number
  vim.opt.number = true
  vim.opt.relativenumber = true

  -- show cursorline
  vim.opt.cursorline = true

  -- text wrapping
  -- if wrap=true
  --   text will wrap at `textwidth`
  vim.opt.wrap = false
  -- vim.opt.wrap = true
  -- vim.opt.textwidth = 120

  -- clipboard
  -- unnamed: * register
  -- unnamedplug: + register
  vim.opt.clipboard = 'unnamed,unnamedplus'

  -- > and < command shifting
  vim.opt.shiftround = true

  -- enable mouse in
  -- n: Normal mode
  -- v: Visual mode
  -- c: command-line mode
  vim.opt.mouse = 'nvc'

  -- don't make backup when writing file
  vim.opt.writebackup = false

  -- number of screen lines to use for the command-line window
  vim.opt.cmdwinheight = 6

  -- when this number of lines is change, a message will show
  vim.opt.report = 10

  -- splitting a window will put the new window right of the current one.
  vim.opt.splitright = true

  -- undo setting
  vim.opt.undolevels = 100
  vim.opt.undoreload = 0

  -- swap file
  -- save swap after this time passed
  -- vim.opt.updatetime = 60000
  -- save swap after this many character typed
  vim.opt.updatecount = 360

  -- WildMenu setting
  -- use last used when completion
  -- vim.opt.wildmode = 'lastused,full'
  -- ignore these files for wildmenu
  -- vim.opt.wildignore = '*.o,*.obj,*.out,*.exe'

  -- Searching setting
  -- ignore case when searching
  -- When 'ignorecase' and 'smartcase' are both on,
  -- if a pattern contains an uppercase letter, it is case sensitive
  -- otherwise, it is not.
  vim.opt.ignorecase = true

  -- Indentation setting
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.autoindent = true
  -- vim.opt.smartindent = true
  vim.opt.copyindent = true

  -- cpp
  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'c',
      'cpp',
      'objc',
      'objcpp',
      'cuda',
      'arduino'
    },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'cindent', true)
      vim.api.nvim_buf_set_option(0, 'cinoptions', 'w1,>1s,:1s,g1,m1,+2s,N-s')
      -- vim.api.nvim_buf_set_option(0, 'cinoptions', '>s,^0,:2,W4,m1,g1,)10,(0')
    end
  })

  -- python
  vim.api.nvim_set_var('python_recommended_style', 0)

  -- java
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'java' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'tabstop', 4)
      vim.api.nvim_buf_set_option(0, 'softtabstop', 4)
      vim.api.nvim_buf_set_option(0, 'shiftwidth', 4)
    end
  })

  -- make
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'make' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'tabstop', 4)
      vim.api.nvim_buf_set_option(0, 'softtabstop', 2)
      vim.api.nvim_buf_set_option(0, 'shiftwidth', 2)
    end
  })

  -- snippet
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'snippets' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'tabstop', 4)
      vim.api.nvim_buf_set_option(0, 'softtabstop', 4)
      vim.api.nvim_buf_set_option(0, 'shiftwidth', 4)
    end
  })

  -- dart
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dart' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'cindent', true)
      -- vim.api.nvim_buf_set_option(0, 'cinoptions', 'w1,>1s,:1s,g1,m1,+2s,N-s')
      vim.api.nvim_buf_set_option(0, 'cinoptions', '(1s,>1s,:1s,g1,m1,+2s')
    end
  })

  -- c#
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'csharp' },
    callback = function()
      vim.api.nvim_buf_set_option(0, 'tabstop', 4)
      vim.api.nvim_buf_set_option(0, 'softtabstop', 4)
      vim.api.nvim_buf_set_option(0, 'shiftwidth', 4)
    end
  })
end

return options
