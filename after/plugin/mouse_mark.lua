local api = vim.api

local namespace = api.nvim_create_namespace("right_click_mark")

local command_opts = {}

api.nvim_create_user_command('RightClickSetMark', function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local bufnr = vim.api.nvim_get_current_buf()
  local line = pos[1]
  vim.defer_fn(function()
    api.nvim_buf_set_extmark(bufnr, namespace, line - 1, 0, {
      sign_text = "▶",
      sign_hl_group = "WarningMsg",
    })
  end, 0)
end, {})

api.nvim_create_user_command('RightClickCancelAllMarks', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.defer_fn(function()
    api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
  end, 0)
end, command_opts)

local function register_mark_menu(command, menu)
  api.nvim_command('nnoremenu Mark.' .. menu:gsub(' ', '\\ ') .. ' :' .. command .. '<CR>')
end

register_mark_menu('RightClickSetMark', 'Set Mark 🦘')
register_mark_menu('RightClickCancelAllMarks', 'Clear Marks 🧸')

local function show_menu()
  local mouse = vim.fn.getmousepos()
  local row = mouse.line
  local col = mouse.column
  api.nvim_win_set_cursor(0, { row, col })

  if vim.fn.pumvisible() == 0 then
    api.nvim_command('popup Mark')
  end
end

api.nvim_set_keymap('n', '<RightMouse>', '', {
  noremap = true,
  silent = true,
  callback = show_menu
})
