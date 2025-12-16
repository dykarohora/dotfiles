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
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true, -- if you want to enable the plugin
			message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
		},
		keys = {
			{ "<leader>gb", "<cmd>GitBlameToggle<CR>", desc = "Toggle git-blame" },
		},
	},
}
