-- lua/lsp/servers/elp.lua
local M = {}

function M.setup(lspconfig, handlers)
	local util = require("lspconfig.util")

	lspconfig.elp.setup({
		capabilities = handlers.capabilities,

		-- ErlangプロジェクトのルートディレクトリをRebarやgitで検出
		root_dir = util.root_pattern(
			"rebar.config", -- Rebar3 プロジェクト
			"rebar3", -- rebar3 実行ファイル
			"erlang.mk", -- erlang.mk プロジェクト
			".git" -- フォールバック
		),

		filetypes = { "erlang" },

		-- lspconfigのデフォルト cmd は { "elp", "server" }
		cmd = { "elp", "server" },
	})
end

return M
