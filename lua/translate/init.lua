local M = {}

local https = require('ssl.https')

M.call_translate_api = function(text, target_lang, api_key)
  local target_language = target_lang or "en"
  local json = require('cjson')

  -- URL for the Google Translate API
  local url = "https://translation.googleapis.com/language/translate/v2?key=" .. api_key
  -- encode url
  text = text:gsub("([^%w ])", function(c)
      return string.format("%%%02X", string.byte(c))
  end)
  local data = "q="..text.."&target="..target_language .. '&format=text'
  local body = https.request(url, data)
  local decoded = json.decode(body)
  if decoded.error ~= nil then
    return nil
  end
  local result = decoded.data.translations[1].translatedText
  return result:gsub("\r\n", "\n")
end

M.translate = function(target_lang)
  local current_buf = vim.api.nvim_get_current_buf()
  local start_cursor = vim.fn.getpos("'<")
  local end_cursor = vim.fn.getpos("'>")
  local start_row = start_cursor[2]-1
  local start_col = start_cursor[3]
  local end_row = end_cursor[2]
  local end_col = end_cursor[3]

  local lines = vim.api.nvim_buf_get_lines(current_buf, start_row, end_row, false)
  if #lines == 0 then
    return false
  end

  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  lines[1] = string.sub(lines[1], start_col, #lines[1])
  local selected_text = table.concat(lines, '\n')

  local api_key = os.getenv('GOOGLE_TRANSLATE_API_KEY')
  if api_key == nil then
    print('GOOGLE_TRANSLATE_API_KEY not found')
    return
  end

  local result = M.call_translate_api(selected_text, target_lang, api_key)
  if result == nil then
    print('error occur when calling Google translate API')
    return
  end
  local result_lines = vim.split(result, '\n')

  if #result_lines == 0 then
    return false
  end

  lines = vim.api.nvim_buf_get_lines(current_buf, start_row, end_row, false)

  if #lines == 1 then
    local prefix = string.sub(lines[1], 1, start_col-1)
    local suffix = end_col+1 <= #lines[1]+1 and string.sub(lines[1], end_col+1, #lines[1]+1) or ''
    lines[1] = prefix .. result .. suffix
  else
    for i = 1,#lines do
      local target_text = result_lines[i]:gsub('\n', '')

      if i == 1 then
        lines[i] = string.sub(lines[i], 1, start_col-1) .. target_text
      elseif i == #lines then
        lines[i] = target_text .. string.sub(lines[i], math.min(end_col+1, #lines[i]+1), #lines[i]+1)
      else
        lines[i] = target_text
      end
    end
  end

  vim.api.nvim_buf_set_lines(current_buf, start_row, end_row, false, lines)
  vim.api.nvim_command('redraw')
  return true
end

M.setup = function()
  local opts = {
    range = true
  }

  vim.api.nvim_create_user_command('TranslateTW', function() M.translate('zh-TW') end, opts)
  vim.api.nvim_create_user_command('TranslateCN', function() M.translate('zh-CN') end, opts)
  vim.api.nvim_create_user_command('TranslateEN', function() M.translate('en') end, opts)
end

return M
