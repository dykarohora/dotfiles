-- lua/lsp/init.lua
local M = {}

function M.setup()
	local lspconfig = require("lspconfig")
	local handlers = require("lsp.handlers")

	local servers = {
		"vtsls",
		"lua_ls",
		"rust_analyzer",
		"terraform_ls",
	}

	for _, name in ipairs(servers) do
		local ok, server = pcall(require, "lsp.servers." .. name)
		if ok then
			server.setup(lspconfig, handlers)
		else
			vim.notify("LSP config not found for: " .. name, vim.log.levels.WARN)
		end
	end
end

return M
