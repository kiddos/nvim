local M = {}

M.start_apm_server = function()
  vim.api.nvim_command('silent !python3 ~/.config/nvim/scripts/apm_server.py --debug=False &')
end

M.start_codellama_code_server = function()
  vim.api.nvim_command('silent !python3 ~/.config/nvim/scripts/ml_server.py --model ~/models/ggml/codellama/codellama-7b.Q2_K.gguf --port 60001 --prompt_type=code 1> /dev/null &')
end

M.start_codellama_instruct_server = function()
  vim.api.nvim_command('silent !python3 ~/.config/nvim/scripts/ml_server.py --model ~/models/ggml/codellama/codellama-7b-instruct.Q2_K.gguf --port 60002 --prompt_type=instruct 1> /dev/null &')
end

return M
