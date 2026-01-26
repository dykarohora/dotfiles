-- lua/lsp/servers/terraform_ls.lua
local M = {}

function M.setup(lspconfig, handlers)
	local util = require("lspconfig.util")

	lspconfig.terraformls.setup({
		capabilities = handlers.capabilities,

		-- terraform-ls は root 判定が弱いので明示する
		root_dir = util.root_pattern(
			".terraform", -- terraform init 後
			".git", -- git repo
			"terraform.tf", -- 明示的な root marker
			"main.tf" -- 単一ファイル開発時の保険
		),

		-- filetype を明示（HCLだけだと attach しないことがある）
		filetypes = { "terraform", "tf", "hcl" },

		-- PATH 問題対策（任意だがおすすめ）
		cmd = { "terraform-ls", "serve" },

		settings = {
			terraformls = {
				experimentalFeatures = {
					validateOnSave = true,
					prefillRequiredFields = true,
				},
			},
		},

		-- attach 確認用（デバッグ中だけ）
		on_attach = function()
			vim.notify("terraform-ls attached", vim.log.levels.INFO)
		end,
	})
end

return M
