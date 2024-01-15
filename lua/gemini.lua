local uv = vim.uv or vim.loop

local M = {}

local safetySettings = {
  {
    category = 'HARM_CATEGORY_HARASSMENT',
    threshold = 'BLOCK_MEDIUM_AND_ABOVE',
  },
  {
    category = 'HARM_CATEGORY_HATE_SPEECH',
    threshold = 'BLOCK_MEDIUM_AND_ABOVE',
  },
  {
    category = 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
    threshold = 'BLOCK_MEDIUM_AND_ABOVE',
  },
  {
    category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
    threshold = 'BLOCK_MEDIUM_AND_ABOVE',
  }
}

M.setup = function()
  local register_menu = function(name, command_name, menu, system_prompt)
    local gemini = function()
      M.show_response(name, system_prompt)
    end

    vim.api.nvim_create_user_command(command_name, gemini, {
      force = true,
      desc = 'Google Gemini',
    })

    vim.api.nvim_command('nnoremenu Gemini.' .. menu:gsub(' ', '\\ ') .. ' :' .. command_name .. '<CR>')
  end

  local prompts = {
    {
      name = 'Unit Test Generation',
      command_name = 'GeminiUnitTest',
      menu = 'Unit Test 🚀',
      prompt = 'Write unit tests for the following code\n',
    },
    {
      name = 'Code Review',
      command_name = 'GeminiCodeReview',
      menu = 'Code Review 📜',
      prompt = 'Do a thorough code review for the following code.\nProvide detail explaination and sincere comments.\n',
    },
    {
      name = 'Code Explain',
      command_name = 'GeminiCodeExplain',
      menu = 'Code Explain 👻',
      prompt = 'Explain the following code\nprovide the answer in Markdown\n',
    },
  }

  for _, item in pairs(prompts) do
    register_menu(item.name, item.command_name, item.menu, item.prompt)
  end

  local register_keymap = function(mode, keymap)
    vim.api.nvim_set_keymap(mode, keymap, '', {
      expr = true,
      noremap = true,
      silent = true,
      callback = function()
        if vim.fn.pumvisible() == 0 then
          vim.api.nvim_command('popup Gemini')
        end
      end
    })
  end

  register_keymap('i', '<C-o>')
  register_keymap('n', '<C-o>')
end

M.gemini_api = function(api_key, text)
  if not api_key or #api_key == 0 then
    return
  end

  local https = require('ssl.https')
  local ltn12 = require('ltn12')
  local json = require('cjson')
  local url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=' .. api_key
  local body = {
    contents = {
      {
        parts = {
          {
            text = text,
          }
        }
      }
    },
    generationConfig = {
      temperature = 0.9,
      topK = 1,
      topP = 1,
      maxOutputTokens = 2048,
    },
    safetySettings = safetySettings,
  }

  local json_text = json.encode(body)
  local respbody = {}
  https.request {
    url = url,
    method = 'POST',
    source = ltn12.source.string(json_text),
    headers = {
      ['Content-Type'] = 'application/json',
      ['Content-Length'] = tostring(#json_text),
      ['Accept'] = '*/*',
    },
    sink = ltn12.sink.table(respbody)
  }
  local response_json = json.decode(respbody[1])
  return response_json.candidates[1].content.parts[1].text
end

M.prepare_code_prompt = function(prompt, bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local code = vim.fn.join(lines, '\n')
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
  local code_markdown = '```' .. filetype .. '\n' .. code .. '\n```'
  return prompt .. '\n\n' .. code_markdown
end

M.show_generating = function(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'Generating...' })
  vim.api.nvim_command('redraw')
  --local texts = { '', '.', '..', '...' }
  --local index = 1
  --local timer = uv.new_timer()
  --timer:start(0, 300, function()
    --local display = 'Generating' .. texts[index]
    --index = index + 1
    --if index > #texts then
      --index = 1
    --end

    --vim.defer_fn(function()
      --vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { display })
      --vim.api.nvim_command('redraw')
    --end, 10)
  --end)
  --return timer
end

M.async_call = function(callback)
  local async
  async = uv.new_async(function()
    callback()
    async:close()
  end)
  async:send()
end

M.show_response = function(name, system_prompt)
  local api_key = os.getenv('GEMINI_API_KEY')
  local current = vim.api.nvim_get_current_buf()
  local _, bufnr = M.open_window(name)
  M.show_generating(bufnr)
  vim.api.nvim_set_option_value('filetype', 'markdown', { buf = bufnr })

  local prompt = M.prepare_code_prompt(system_prompt, current)
  M.async_call(function()
    local text = M.gemini_api(api_key, prompt)
    if text then
      vim.defer_fn(function()
        local lines = vim.split(text, '\n')
        vim.api.nvim_buf_set_lines(bufnr, 0, #lines, false, lines)
      end, 0)
    end
  end)
end

M.open_window = function(title)
  local padding = { 10, 3 }
  local width = vim.api.nvim_win_get_width(0) - padding[1] * 2
  local height = vim.api.nvim_win_get_height(0) - padding[2] * 2
  local popup = require("plenary.popup")
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

  local win_id = popup.create({}, {
    title = 'Gemini - ' .. title,
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
  })
  local bufnr = vim.api.nvim_win_get_buf(win_id)
  vim.api.nvim_set_option_value('ft', 'markdown', { buf = bufnr })
  vim.api.nvim_set_option_value('wrap', true, {  win = win_id })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-q>", "<cmd>lua CloseMenu()<CR>", { silent = false })

  function CloseMenu()
    vim.api.nvim_win_close(win_id, true)
  end

  return win_id, bufnr
end

return M
