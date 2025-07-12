local api = vim.api

local config = function()
  local rg_options = {
    '--column',
    '--line-number',
    '--with-filename',
    '--color=always',
    '--smart-case ',
    '--no-search-zip',
    '-g \'!{**/node_modules,**/.git}\'',
  }
  local rg_command = 'rg ' .. table.concat(rg_options, ' ') .. ' -- '
  api.nvim_create_user_command('Rg',
    'call fzf#vim#grep("' .. rg_command .. '".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)', {})
  api.nvim_set_keymap('n', '<C-P>', ':Files<CR>', { noremap = true, silent = true })

  local register_fzf_menu = function(fzf_command, menu)
    api.nvim_command('nnoremenu FZF.' .. menu:gsub(' ', '\\ ') .. ' :' .. fzf_command .. '<CR>')
  end

  register_fzf_menu('GFiles', 'Git files 🦜')
  register_fzf_menu('Buffers', 'Open buffers 🦥')
  register_fzf_menu('Lines', 'Find in loadded buffers 🦄🦄🦄')
  register_fzf_menu('Jumps', 'Jumps 🦗')
  register_fzf_menu('Windows', 'Windows ')
  register_fzf_menu('History', 'History 🐓')
  register_fzf_menu('Marks', 'Marks 🦋')
  register_fzf_menu('Commands', 'Commands 🦩')
  register_fzf_menu('Snippets', 'Snippets')
  register_fzf_menu('Commits', 'Git Commits')
  register_fzf_menu('Changes', 'Changelist across open buffers 🦅')
  register_fzf_menu('Ag', 'ag search 🦆')
  register_fzf_menu('Colors', 'Color scheme 🎨')
  register_fzf_menu('Rg', 'rg search 🧸')
  register_fzf_menu('Tags', 'Tags in the project 🦏')
  register_fzf_menu('Helptags', 'Help tags 🦎')
  register_fzf_menu('Filetypes', 'File types 🦘')

  api.nvim_set_keymap('n', '<M-n>', '', {
    expr = true,
    noremap = true,
    silent = true,
    callback = function()
      if vim.fn.pumvisible() == 0 then
        api.nvim_command('popup FZF')
      end
    end
  })
end

return {
  'junegunn/fzf.vim',
  cmd = { 'Rg', 'Ag', 'FZF', 'Files' },
  keys = { '<C-P>', '<M-n>' },
  dependencies = { 'junegunn/fzf' },
  build = ':call fzf#install()',
  config = config,
}
