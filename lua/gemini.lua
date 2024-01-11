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
  local gemini = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    local system_prompt = 'Explain the following code\nprovide the answer in Markdown\n'
    if filetype == 'dart' then
      system_prompt = 'The following is a flutter widget.\nWrite unit test for this widget\n'
    end
    M.show_response(system_prompt)
  end

  vim.api.nvim_create_user_command('Gemini', gemini, {
    force = true,
    desc = 'Google Gemini',
  })
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

M.show_response = function(system_prompt)
  local api_key = os.getenv('GEMINI_API_KEY')
  local current = vim.api.nvim_get_current_buf()
  local _, bufnr = M.open_window()
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { 'Generating...' })
  vim.api.nvim_set_option_value('filetype', 'markdown', { buf = bufnr })

  local prompt = M.prepare_code_prompt(system_prompt, current)
  vim.defer_fn(function()
    local text = M.gemini_api(api_key, prompt)
    if text then
      local lines = vim.split(text, '\n')
      vim.api.nvim_buf_set_lines(bufnr, 0, #lines, false, lines)
    end
  end, 0)
end

M.open_window = function()
  local padding = { 10, 3 }
  local width = vim.api.nvim_win_get_width(0) - padding[1] * 2
  local height = vim.api.nvim_win_get_height(0) - padding[2] * 2
  local popup = require("plenary.popup")
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

  local win_id = popup.create({}, {
    title = "Gemini",
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
  })
  local bufnr = vim.api.nvim_win_get_buf(win_id)
  vim.api.nvim_set_option_value('ft', 'markdown', { buf = bufnr })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-q>", "<cmd>lua CloseMenu()<CR>", { silent = false })

  function CloseMenu()
    vim.api.nvim_win_close(win_id, true)
  end

  return win_id, bufnr
end

return M
