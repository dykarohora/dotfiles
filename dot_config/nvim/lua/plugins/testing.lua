-- lua/plugins/neotest.lua
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			-- vitest adapter
			"marilari88/neotest-vitest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vitest")({
						-- node_modules を潜らない（巨大化防止）
						filter_dir = function(name, rel_path, root)
							return name ~= "node_modules"
						end,

						-- 必要なら「このファイルだけテスト扱い」みたいなルールも足せる
						-- is_test_file = function(file_path) ... end,
					}),
				},
			})
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run()
				end,
				desc = "Test: nearest",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Test: file",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.loop.cwd())
				end,
				desc = "Test: all (cwd)",
			},

			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Test: summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Test: output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Test: output panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Test: stop",
			},
		},
	},
}
