vim.api.nvim_create_user_command('ShowHighlight', "echo synIDattr(synID(line('.'), col('.'), 1), 'name')", {})
