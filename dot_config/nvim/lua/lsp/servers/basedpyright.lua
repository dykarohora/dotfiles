local M = {}

function M.setup(lspconfig, handlers)
	lspconfig.basedpyright.setup({
		capabilities = handlers.capabilities,
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "standard",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "openFilesOnly",
				},
			},
		},
	})
end

return M
