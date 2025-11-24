return {
	"emmanueltouzery/key-menu.nvim",
	config = function()
		vim.o.timeoutlen = 250
		require("key-menu").set("n", "<leader>")
	end,
}
