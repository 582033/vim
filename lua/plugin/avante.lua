local avante = require('avante')

-- 加载本地的 api.lua 文件
local api_path = vim.fn.expand("$HOME/.config/nvim/lua/avante/api.lua")
if vim.fn.filereadable(api_path) == 1 then
  package.loaded['avante.api'] = require('avante.api')
  local avante_api = require(api_path)
  package.loaded['avante.api'] = avante_api
end

avante.setup({
  provider = "gemini",
  -- auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
  },
  gemini = {
    -- @see https://ai.google.dev/gemini-api/docs/models/gemini
    model = "gemini-1.5-pro-exp-0827",
    -- model = "gemini-1.5-flash",
    temperature = 0,
    max_tokens = 4096,
  },
})

print("avante in plugin/avante.lua:")
print(vim.inspect(avante))
print("avante.windows in plugin/avante.lua:")
print(vim.inspect(avante.windows))