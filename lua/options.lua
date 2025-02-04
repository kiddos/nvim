local options = {}

options.setup = function()
  vim.api.nvim_set_option_value('langmenu', 'en_US.UTF-8', {})

  -- Icon Setting
  -- vim.api.nvim_set_option_value('icon', true, {})
  -- vim.api.nvim_set_option_value('iconstring', 'nvim', {})

  -- Rendering setting
  -- more performant
  vim.api.nvim_set_option_value('lazyredraw', false, {})
  vim.api.nvim_set_option_value('redrawtime', 3000, {})

  -- Editing setting
  -- confirm when ":q" or ":e"
  vim.api.nvim_set_option_value('confirm', true, {})

  -- line number
  vim.api.nvim_set_option_value('number', true, {})
  vim.api.nvim_set_option_value('relativenumber', true, {})

  -- show cursorline
  vim.api.nvim_set_option_value('cursorline', true, {})

  -- text wrapping
  -- if wrap=true
  --   text will wrap at `textwidth`
  vim.api.nvim_set_option_value('wrap', false, {})
  -- vim.api.nvim_set_option_value('wrap', true, {})
  -- vim.api.nvim_set_option_value('textwidth', 120, {})

  -- clipboard
  -- unnamed: * register
  -- unnamedplug: + register
  vim.api.nvim_set_option_value('clipboard', 'unnamed,unnamedplus', {})

  -- > and < command shifting
  vim.api.nvim_set_option_value('shiftround', true, {})

  -- enable mouse in
  -- n: Normal mode
  -- v: Visual mode
  -- c: command-line mode
  vim.api.nvim_set_option_value('mouse', 'nvc', {})

  -- don't make backup when writing file
  vim.api.nvim_set_option_value('writebackup', false, {})

  -- number of screen lines to use for the command-line window
  vim.api.nvim_set_option_value('cmdwinheight', 6, {})

  -- when this number of lines is change, a message will show
  vim.opt.report = 10
  vim.api.nvim_set_option_value('report', 10, {})

  -- splitting a window will put the new window right of the current one.
  vim.api.nvim_set_option_value('splitright', true, {})

  -- undo setting
  vim.api.nvim_set_option_value('undolevels', 128, {})
  vim.api.nvim_set_option_value('undoreload', 0, {})

  -- swap file
  -- save swap after this time passed
  vim.api.nvim_set_option_value('updatetime', 60000, {})
  -- save swap after this many character typed
  vim.api.nvim_set_option_value('updatecount', 100, {})

  -- WildMenu setting
  -- use last used when completion
  -- vim.api.nvim_set_option_value('wildmode', 'lastused,full', {})
  -- ignore these files for wildmenu
  -- vim.api.nvim_set_option_value('wildignore', '*.o,*.obj,*.out,*.exe', {})

  -- Searching setting
  -- ignore case when searching
  -- When 'ignorecase' and 'smartcase' are both on,
  -- if a pattern contains an uppercase letter, it is case sensitive
  -- otherwise, it is not.
  vim.api.nvim_set_option_value('ignorecase', true, {})

  -- Indentation setting
  vim.api.nvim_set_option_value('tabstop', 2, {})
  vim.api.nvim_set_option_value('softtabstop', 2, {})
  vim.api.nvim_set_option_value('shiftwidth', 2, {})
  vim.api.nvim_set_option_value('expandtab', true, {})
  vim.api.nvim_set_option_value('autoindent', true, {})
  -- vim.api.nvim_set_option_value('smartindent', true, {})
  vim.api.nvim_set_option_value('copyindent', true, {})

  vim.api.nvim_set_option_value('cindent', true, {})
  vim.api.nvim_set_option_value('cinoptions', '(1s,>1s,:1s,g1,m1,+2s', {})

  -- maximum number of items to show in the popup menu
  vim.api.nvim_set_option_value('pumheight', 10, {})
  vim.api.nvim_set_option_value('complete', '', {})
  -- do not show XXX completion (YYY)
  vim.api.nvim_set_option_value('shortmess', vim.api.nvim_get_option_value('shortmess', {}) .. 'c', {})

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'rust', 'arduino', 'cuda' },
    callback = function()
      vim.api.nvim_set_option_value('cindent', true, {})
      vim.api.nvim_set_option_value('cinoptions', 'w1,>1s,:1s,g1,m1,+2s,N-s', {})
      -- vim.api.nvim_set_option_value('cinoptions', '(1s,>1s,:1s,g1,m1,+2s', {})
    end
  })

  -- python
  vim.api.nvim_set_var('python_recommended_style', 0)

  local set_indenting = function(filetypes, tabstop, softtabstop, shiftwidth, expandtab)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function()
        vim.api.nvim_set_option_value('tabstop', tabstop, { scope = 'local' })
        vim.api.nvim_set_option_value('softtabstop', softtabstop, { scope = 'local' })
        vim.api.nvim_set_option_value('shiftwidth', shiftwidth, { scope = 'local' })
        vim.api.nvim_set_option_value('expandtab', expandtab, { scope = 'local' })
      end
    })
  end

  set_indenting({ 'python' }, 4, 4, 4, true)
  set_indenting({ 'java' }, 4, 4, 4, true)
  set_indenting({ 'make' }, 4, 4, 4, false)
  set_indenting({ 'snippets' }, 4, 4, 4, false)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'jsp' },
    callback = function()
      vim.api.nvim_set_option_value('indentexpr', '', { scope = 'local' })
    end
  })
end

return options
