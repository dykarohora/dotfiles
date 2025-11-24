return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "<leader>xo", "<Cmd>Oil --float<CR>")
	end,
}
