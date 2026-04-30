local M = {}

function M.setup(lspconfig, handlers)
	lspconfig.gopls.setup({
		capabilities = handlers.capabilities,
		settings = {
			gopls = {
				-- gofumpt フォーマッタ使用
				gofumpt = true,
				-- 静的解析
				analyses = {
					unusedparams = true,
					shadow = true,
				},
				staticcheck = true,
				-- インレイヒント
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	})
end

return M
