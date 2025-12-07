return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavor = "macchiato",
			transparent_background = true,
			custom_highlights = {
				LineNr = { fg = "#999999" },
				Visual = { bg = "#7154ab", style = { "bold" } },
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { theme = "wombat" },
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		config = function()
			local barbar = require("barbar")
			barbar.setup({
				animation = false,
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<M-,>", "<Cmd>BufferPrevious<CR>", opts)
			vim.keymap.set("n", "<M-.>", "<Cmd>BufferNext<CR>", opts)
			vim.keymap.set("n", "<M-;>", "<Cmd>BufferClose<CR>", opts)
		end,
		version = "^1.0.0",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				background_colour = "#1a1a1a",
				stages = "slide",
				top_down = false,
				timeout = 2000,
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		event = "BufRead",
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				mode = "n",
				silent = true,
				noremap = true,
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				mode = "n",
				silent = true,
				noremap = true,
			},
			{
				"zr",
				function()
					require("ufo").openFoldsExceptKinds()
				end,
				mode = "n",
				silent = true,
				noremap = true,
			},
			{
				"zm",
				function()
					local winid = vim.api.nvim_get_current_win()
					local cursor = vim.api.nvim_win_get_cursor(winid)
					local lnum = cursor[1] -- 現在のカーソル行

					-- カーソル位置の foldlevel を取得
					local foldlevel = vim.fn.foldlevel(lnum)
					if foldlevel > 0 then
						-- その折りたたみを閉じる
						vim.cmd(lnum .. "foldclose")
					end
				end,
				mode = "n",
				silent = true,
				noremap = true,
			},
		},
		opts = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.fillchars = [[eob: ,fold: ,foldopen:+,foldsep: ,foldclose:-]]
		end,
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"tadaa/vimade",
		event = "BufRead",
		opts = {
			recipe = { "default", { animate = true } },
			fadelevel = 0.7,
		},
	},
}
