return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp", -- capabilities のため
		},
		config = function()
			require("lsp").setup()
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				code_action = {
					extend_gitsigns = true,
				},
				definition = {
					width = 0.9,
					height = 0.9,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", opts)
					vim.keymap.set("n", "<leader>j", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
					vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
					vim.keymap.set("n", "<leader>.", "<cmd>Lspsaga code_action<CR>", opts)
					vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
					vim.keymap.set("n", "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
					vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga outline<CR>", opts)
					vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
				end,
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		event = { "BufRead", "BufNewFile" },
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = true }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			local web_formatter = { "biome-check", stop_after_first = true }
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports" },
					bash = { "shfmt" },
					-- Web
					typescript = web_formatter,
					javascript = web_formatter,
					typescriptreact = web_formatter,
					javascriptreact = web_formatter,
					vue = web_formatter,
					svelte = web_formatter,
					json = web_formatter,
					jsonc = web_formatter,
					yaml = web_formatter,
					html = web_formatter,
					css = web_formatter,
					scss = web_formatter,
					less = web_formatter,
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
	{
		"WilliamHsieh/overlook.nvim",
		opts = {
			ui = {
				border = "rounded",
				z_index_base = 30,
				row_offset = 0,
				col_offset = 0,
				stack_row_offset = 0,
				stack_col_offset = 0,
				width_decrement = 2,
				height_decrement = 1,
				min_width = 10,
				min_height = 3,
				size_ratio = 0.65,
				keys = {
					close = "q",
				},
			},
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>pd",
				function()
					require("overlook.api").peek_definition()
				end,
				desc = "Overlook: Peek definition",
			},
			{
				"<leader>pp",
				function()
					require("overlook.api").peek_cursor()
				end,
				desc = "Overlook: Peek cursor",
			},
			{
				"<leader>pu",
				function()
					require("overlook.api").restore_popup()
				end,
				desc = "Overlook: Restore last popup",
			},
			{
				"<leader>pU",
				function()
					require("overlook.api").restore_all_popups()
				end,
				desc = "Overlook: Restore all popups",
			},
			{
				"<leader>pc",
				function()
					require("overlook.api").close_all()
				end,
				desc = "Overlook: Close all popups",
			},
			{
				"<leader>pf",
				function()
					require("overlook.api").switch_focus()
				end,
				desc = "Overlook: Switch focus",
			},
			{
				"<leader>ps",
				function()
					require("overlook.api").open_in_split()
				end,
				desc = "Overlook: Open popup in split",
			},
			{
				"<leader>pv",
				function()
					require("overlook.api").open_in_vsplit()
				end,
				desc = "Overlook: Open popup in vsplit",
			},
			{
				"<leader>pt",
				function()
					require("overlook.api").open_in_tab()
				end,
				desc = "Overlook: Open popup in tab",
			},
			{
				"<leader>po",
				function()
					require("overlook.api").open_in_original_window()
				end,
				desc = "Overlook: Open popup in current window",
			},
		},
		config = function(_, opts)
			require("overlook").setup(opts)

			local aug = vim.api.nvim_create_augroup("OverlookPopupTweak", { clear = true })

			local function apply_overlook_window_opts()
				if not vim.w.is_overlook_popup then
					return
				end

				-- 他の autocmd で signcolumn が書き換えられたあとに上書きしたいので schedule する
				vim.schedule(function()
					if not vim.api.nvim_win_is_valid(0) or not vim.w.is_overlook_popup then
						return
					end

					local wo = vim.wo
					local bo = vim.bo

					-- ★ 左側の揺れ対策の本丸
					wo.signcolumn = "no"
					wo.number = false
					wo.relativenumber = false
					wo.foldcolumn = "0"
					wo.statuscolumn = ""

					-- 表示でガチャつきそうなもの
					wo.list = false
					wo.breakindent = false
					wo.cursorline = false

					-- fold 無効化
					wo.foldenable = false
					wo.foldmethod = "manual"

					-- 念のためインデント自動調整系もオフ
					bo.autoindent = false
					bo.smartindent = false
					bo.cindent = false
				end)
			end

			-- ウィンドウに入ったとき
			vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
				group = aug,
				callback = apply_overlook_window_opts,
			})

			-- カーソル移動のたびに誰かが signcolumn を auto に戻してきても潰す
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = aug,
				callback = apply_overlook_window_opts,
			})
		end,
	},
}
