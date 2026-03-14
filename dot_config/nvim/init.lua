vim.g.python3_host_prog = "~/.local/share/mise/installs/python/3.12.13/bin/python"

require("config.options")
require("config.keymaps")
require("config.lazy")

vim.cmd.colorscheme("catppuccin")
-- ビジュアルモードでペーストしても、元の内容を保持する
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })
