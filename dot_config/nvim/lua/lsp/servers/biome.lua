local M = {}

function M.setup(lspconfig, handlers)
	lspconfig.biome.setup({
		capabilities = handlers.capabilities,
	})
end

return M
