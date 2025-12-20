local M = {}

function M.setup(lspconfig, handlers)
	lspconfig.rust_analyzer.setup({
		capabilities = handlers.capabilities,
		settings = {
			["rust-analyzer"] = {
				-- Clippy有効化
				check = {
					command = "clippy",
				},
				-- cargo自動リロード
				cargo = {
					autoreload = true,
				},
				-- 高度な型ヒント
				inlayHints = {
					bindingModeHints = {
						enable = true,
					},
					chainingHints = {
						enable = true,
					},
					closingBraceHints = {
						minLines = 25,
					},
					closureReturnTypeHints = {
						enable = "always",
					},
					lifetimeElisionHints = {
						enable = "always",
						useParameterNames = true,
					},
					parameterHints = {
						enable = true,
					},
					typeHints = {
						enable = true,
						hideClosureInitialization = false,
						hideNamedConstructor = false,
					},
				},
			},
		},
	})
end

return M
