local M = {}

function M.setup(lspconfig, handlers)
	lspconfig.lua_ls.setup({
		capabilities = handlers.capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	})
end

return M
