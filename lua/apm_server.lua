vim.api.nvim_exec(
[[
silent exec ':!python3 ~/.config/nvim/apm_server.py --debug=False &'
]], false)
