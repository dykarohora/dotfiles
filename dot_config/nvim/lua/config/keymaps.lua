vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Write" })
vim.keymap.set("n", "<leader>qq", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>wa", ":w<CR>", { desc = "Write all" })
vim.keymap.set("n", "<leader>qa", ":q<CR>", { desc = "Quit all" })
-- searchのハイライトをリセットする
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })
