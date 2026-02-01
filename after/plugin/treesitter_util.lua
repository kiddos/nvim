local function show_current_treesitter_node()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- Neovim's cursor positions are 0-indexed for rows and columns,
  -- but treesitter's get_node expects 0-indexed row and 0-indexed byte offset for column
  -- For display, it's often 1-indexed. Let's stick to 0-indexed for internal logic.

  local node = vim.treesitter.get_node({ bufnr = bufnr, row = row, col = col })

  if not node then
    print("No Tree-sitter node found at cursor.")
    return
  end

  print("--- Current Tree-sitter Node ---")
  print("Type: " .. node:type())
  local start_row, start_col, end_row, end_col = node:range()
  print(string.format("Range: [%d:%d] - [%d:%d]", start_row + 1, start_col + 1, end_row + 1, end_col + 1))
  if pcall(node.current_text, node) then -- Check if current_text exists (Neovim 0.10+)
    print("Text: " .. vim.inspect(node:current_text()))
  end

  print("\n--- Ancestors (Parent Chain) ---")
  local current_ancestor = node:parent()
  local level = 0
  while current_ancestor do
    level = level + 1
    local a_start_row, a_start_col, a_end_row, a_end_col = current_ancestor:range()
    print(string.format("%sLevel %d: Type: %s, Range: [%d:%d] - [%d:%d]",
      string.rep("  ", level), level, current_ancestor:type(),
      a_start_row + 1, a_start_col + 1, a_end_row + 1, a_end_col + 1))
    if pcall(current_ancestor.current_text, current_ancestor) then
      print(string.format("%s  Text: %s", string.rep("  ", level), vim.inspect(current_ancestor:current_text())))
    end
    current_ancestor = current_ancestor:parent()
  end

  -- print("\n--- Children (Direct Descendants) ---")
  -- local children = node:children()
  -- if #children > 0 then
  --   for i, child in ipairs(children) do
  --     local c_start_row, c_start_col, c_end_row, c_end_col = child:range()
  --     print(string.format("  Child %d: Type: %s, Range: [%d:%d] - [%d:%d]",
  --                         i, child:type(), c_start_row + 1, c_start_col + 1, c_end_row + 1, c_end_col + 1))
  --     if pcall(child.current_text, child) then
  --       print(string.format("    Text: %s", vim.inspect(child:current_text())))
  --     end
  --   end
  -- else
  --   print("  No direct children.")
  -- end
end

vim.api.nvim_create_user_command(
  'TSNodeInfo',
  function()
    show_current_treesitter_node()
  end,
  {
    desc = 'Show current Tree-sitter node information',
  }
)
