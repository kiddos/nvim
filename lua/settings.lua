-- Language setting
--
vim.o.langmenu = 'en_US.UTF-8'


-- File type setting
vim.api.nvim_create_autocmd({'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter'}, {
  pattern = {'*.i', '*.swg'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'filetype', 'swig')
  end
})

vim.api.nvim_create_autocmd({'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter'}, {
  pattern = {'*.BUILD'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'filetype', 'bzl')
  end
})

vim.api.nvim_create_autocmd({'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter'}, {
  pattern = {'*.m'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'filetype', 'objc')
  end
})

vim.api.nvim_create_autocmd({'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter'}, {
  pattern = {'*.mm'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'filetype', 'objcpp')
  end
})

vim.api.nvim_create_autocmd({'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter'}, {
  pattern = {'*.h'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'filetype', 'cpp')
  end
})

vim.api.nvim_create_autocmd({'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter'}, {
  pattern = {'*.pro'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'filetype', 'make')
  end
})

vim.api.nvim_create_autocmd({'VimEnter', 'BufRead', 'BufNewFile', 'BufEnter'}, {
  pattern = {'*.wmm'},
  callback = function()
    vim.api.nvim_buf_set_option(0, 'filetype', 'webmacro')
  end
})


-- Icon Setting
--
-- vim.o.icon = true
-- vim.o.iconstring = 'nvim'


-- Rendering setting
--
-- more performant
vim.o.lazyredraw = true
vim.o.redrawtime = 10000


-- Editing setting
--
-- confirm when ":q" or ":e"
vim.o.confirm = true

-- line number
-- vim.o.number = true
vim.o.number = true
vim.o.relativenumber = true

-- show cursorline
vim.o.cursorline = true

-- text wrapping
-- if wrap=true
--   text will wrap at `textwidth`
vim.o.wrap = false
-- vim.o.wrap = true
-- vim.o.textwidth = 120

-- clipboard
-- unnamed: * register
-- unnamedplug: + register
vim.o.clipboard = 'unnamed,unnamedplus'

-- > and < command shifting
vim.o.shiftround = true

-- maximum number of items to show in the popup menu
vim.o.pumheight = 30

-- keyword completion
vim.o.complete = '.,w,b,u,U,t,k'
vim.o.completeopt = 'menuone,noselect'

-- do not show XXX completion (YYY)
vim.o.shortmess = vim.api.nvim_get_option('shortmess') .. 'c'

-- enable mouse in
-- n: Normal mode
-- v: Visual mode
-- c: command-line mode
vim.o.mouse = 'nvc'

-- don't make backup when writing file
vim.o.writebackup = false

-- number of screen lines to use for the command-line window
vim.o.cmdwinheight = 6

-- when this number of lines is change, a message will show
vim.o.report = 6

-- splitting a window will put the new window right of the current one.
vim.o.splitright = true

-- undo setting
vim.o.undolevels = 300
vim.o.undoreload = 0

-- swap file
-- save swap after this time passed
vim.o.updatetime = 60000
-- save swap after this many character typed
vim.o.updatecount = 360


-- WildMenu setting
--
-- use last used when completion
vim.o.wildmode = 'lastused,full'
-- ignore these files for wildmenu
vim.o.wildignore = '*.o,*.obj,*.out,*.exe'


-- Searching setting
--
-- ignore case when searching
-- When 'ignorecase' and 'smartcase' are both on,
-- if a pattern contains an uppercase letter, it is case sensitive
-- otherwise, it is not.
vim.o.ignorecase = true
-- vim.o.smartcase = true


-- Indentation setting
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
-- vim.o.smartindent = true
vim.o.copyindent = true

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
  pattern = {'java'},
  callback = function() 
    vim.api.nvim_buf_set_option(0, 'tabstop', 4)
    vim.api.nvim_buf_set_option(0, 'softtabstop', 4)
    vim.api.nvim_buf_set_option(0, 'shiftwidth', 4)
  end
})

-- make
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'make'},
  callback = function() 
    vim.api.nvim_buf_set_option(0, 'tabstop', 4)
    vim.api.nvim_buf_set_option(0, 'softtabstop', 2)
    vim.api.nvim_buf_set_option(0, 'shiftwidth', 2)
  end
})

-- snippet
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'snippets'},
  callback = function() 
    vim.api.nvim_buf_set_option(0, 'tabstop', 4)
    vim.api.nvim_buf_set_option(0, 'softtabstop', 4)
    vim.api.nvim_buf_set_option(0, 'shiftwidth', 4)
  end
})

-- dart
-- vim.api.nvim_command('augroup dart_indent')
-- vim.api.nvim_command('autocmd Filetype dart setlocal cindent')
-- vim.api.nvim_command('autocmd Filetype dart setlocal cinoptions=(1s,>1s,:1s,g1,m1,+2s')
-- vim.api.nvim_command('augroup END')

-- c#
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'csharp'},
  callback = function() 
    vim.api.nvim_buf_set_option(0, 'tabstop', 4)
    vim.api.nvim_buf_set_option(0, 'softtabstop', 4)
    vim.api.nvim_buf_set_option(0, 'shiftwidth', 4)
  end
})
