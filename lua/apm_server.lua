vim.api.nvim_exec(
[[
function StartAPMServer()
  silent exec ':!python3 ~/.config/nvim/apm_server.py --debug=False &'
endfunction
call StartAPMServer()
]], false)
