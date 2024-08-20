local M = {}

local config = {
  completion = {
    abbr_max_len = 60,
    menu_max_len = 20,
    buffer_max_lines = 20000,
    buffer_reindex_line_range = 500,
    buffer_lru_size = 6000,
    special_chars = { '{', ':', ';', '(', '[', ',', ')', ']', '+', '-', '*', '/', '%', '!', '&', '|' },
    delay = 200,
    edit_dist = 6,
    dist_difference = 2,
    insert_cost = 1,
    delete_cost = 3,
    substitude_cost = 1,
  },
  info = {
    max_width = 120,
    max_height = 30,
    delay = 500,
  },
  signature = {
    max_width = 120,
    max_height = 30,
    delay = 500,
  },
  cr_mapping = nil,
}

M.merge_option = function(opt)
  config = vim.tbl_extend('force', config, opt)
end

M.get_config = function()
  return config
end

return M
