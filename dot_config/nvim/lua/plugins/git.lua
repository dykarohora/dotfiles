-- nvim v0.8.0
return {
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"isakbm/gitgraph.nvim",
		opts = {
			git_cmd = "git",
			symbols = {
				merge_commit = "",
				commit = "",
				merge_commit_end = "",
				commit_end = "",

				-- Advanced symbols
				GVER = "│",
				GHOR = "─",
				GCLD = "╮",
				GCRD = "╭",
				GCLU = "╯",
				GCRU = "╰",
				GLRU = "┴",
				GLRD = "┬",
				GLUD = "┤",
				GRUD = "├",
				GFORKU = "┼",
				GFORKD = "┼",
				GRUDCD = "├",
				GRUDCU = "┡",
				GLUDCD = "┪",
				GLUDCU = "┩",
				GLRDCL = "┬",
				GLRDCR = "┬",
				GLRUCL = "┴",
				GLRUCR = "┴",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function(from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gl",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},
}
