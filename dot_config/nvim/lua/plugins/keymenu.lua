return {
	"emmanueltouzery/key-menu.nvim",
	config = function()
		vim.o.timeoutlen = 250

		local keymenu = require("key-menu")
		keymenu.set("n", "<leader>")
		keymenu.set("n", "<leader>c", { desc = "Claude Code" })
		keymenu.set("n", "<leader>f", { desc = "File" })
		keymenu.set("n", "<leader>g", { desc = "Git" })
		keymenu.set("n", "<leader>l", { desc = "LSP" })
		keymenu.set("n", "<leader>o", { desc = "Overseer" })
		keymenu.set("n", "<leader>p", { desc = "Overlook" })
		keymenu.set("n", "<leader>s", { desc = "Search" })
		keymenu.set("n", "<leader>u", { desc = "No Neck Pain" })
		keymenu.set("n", "<leader>x", { desc = "Explorer" })
		keymenu.set("n", "<leader>t", { desc = "Neotest" })
		keymenu.set("n", "<leader>T", { desc = "Trouble" })
	end,
}
