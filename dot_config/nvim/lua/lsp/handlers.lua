-- lua/lsp/handlers.lua
local M = {}

-- ★ blink.cmp の LSP capabilities を使用
M.capabilities = require("blink.cmp").get_lsp_capabilities()

return M
