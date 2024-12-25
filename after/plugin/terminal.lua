vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

local term_context = {
  buf = -1,
  win = -1,
}

local create_terminal = function(input_buf)
  local buf = 0
  if vim.api.nvim_buf_is_valid(input_buf) then
    buf = input_buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_width = vim.api.nvim_win_get_width(0)
  local win_height = vim.api.nvim_win_get_height(0)
  local width = 50
  local height = 16
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = win_width - width - 2,
    row = win_height - height - 2,
    style = 'minimal',
    border = 'rounded',
  }
  local win = vim.api.nvim_open_win(buf, true, opts)

  vim.api.nvim_create_autocmd('WinClosed', {
    callback = function(args)
      local win_id = tonumber(args.match)
      if win_id == term_context.win then
        term_context.win = -1
      end
    end,
    once = true,
  })

  return { win, buf }
end

local toggle_term = function()
  if not vim.api.nvim_win_is_valid(term_context.win) then
    local term = create_terminal(term_context.buf)
    term_context.win = term[1]
    term_context.buf = term[2]
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = term_context.buf })
    if buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    vim.cmd('startinsert')
  else
    vim.api.nvim_win_hide(term_context.win)
  end
end

vim.api.nvim_create_user_command('ToggleTerm', toggle_term, {})
vim.api.nvim_set_keymap('n', '<F6>', ':ToggleTerm<CR>', {
  silent = true,
  noremap = true
})
