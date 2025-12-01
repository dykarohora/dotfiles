local M = {}

function M.setup(lspconfig, handlers)
	lspconfig.vtsls.setup({
		capabilities = handlers.capabilities, -- blink.cmp
		settings = {
			vtsls = {
				autoUseWorkspaceTsdk = true,
			},
			typescript = {
				format = { enable = false }, -- biome に寄せる前提
			},
			javascript = {
				format = { enable = false },
			},
		},
	})
end

return M
