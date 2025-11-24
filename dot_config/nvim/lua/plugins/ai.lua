return {
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for git operations
		},
		config = function()
			require("claude-code").setup({
				window = {
					position = "vertical",
				},
				command = "~/.claude/local/claude",
			})
			vim.keymap.set("n", "<leader>cc", "<Cmd>ClaudeCode<CR>")
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = false,
				},
				filetypes = {
					markdown = true,
					help = true,
				},
			})
		end,
	},
}
