local M = {}

local util = require('completion.util')
local config = require('completion.config')

M.load_snippets = function()
  local patterns = {
    'snippets/%s/*.snippets',
    'snippets/%s.snippets',
  }

  local completion_items = {}
  for _, p in ipairs(patterns) do
    local pattern = string.format(p, vim.bo.filetype)
    local snippets = vim.fn.globpath(vim.o.runtimepath, pattern, false, 1)

    for _, snippet_path in pairs(snippets) do
      local items = M.prepare_snippet_completion(snippet_path)
      for _, item in pairs(items) do
        table.insert(completion_items, item)
      end
    end
  end
  return completion_items
end

M.read_file = function(filepath)
  local f = assert(io.open(filepath, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

M.prepare_snippet_completion = function(snippet_path)
  local content = M.read_file(snippet_path)
  local lines = vim.split(content, '\n')

  local list = {}
  local item_kind = 15 -- Snippets

  local i = 1
  while i <= #lines do
    local line = lines[i]
    if line == nil then
      break
    end

    if vim.startswith(line, 'snippet ') then
      local snippet_name = string.sub(line, 9, #line)

      local snippet = {}
      i = i + 1
      while i <= #lines do
        if not vim.startswith(lines[i], 'snippet ') then
          table.insert(snippet, lines[i])
        else
          break
        end
        i = i + 1
      end

      table.insert(list, {
        word = snippet_name,
        abbr = util.trim_long_text(snippet_name, config.completion.abbr_max_len),
        kind = vim.lsp.protocol.CompletionItemKind[item_kind] or 'Snippet',
        -- TODO
        menu = util.trim_long_text(snippet_name or '', config.completion.menu_max_len),
        info = table.concat(snippet, '\n'),
        icase = 1,
        dup = 1,
        empty = 1,
        user_data = {
          nvim = {
            lsp = {
              source = 'snippet',
            }
          }
        },
      })
    else
      i = i + 1
    end
  end

  return list
end

return M
