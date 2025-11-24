require("config.options")
require("config.keymaps")
require("config.lazy")

vim.cmd.colorscheme("catppuccin")
-- ビジュアルモードでペーストしても、元の内容を保持する
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })
