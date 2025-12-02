return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",  -- capabilities のため
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

					vim.keymap.set("n", "<leader>j", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
					vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
					vim.keymap.set("n", "<leader>.", "<cmd>Lspsaga code_action<CR>", opts)

					vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
					vim.keymap.set("n", "<leader>rr", "<cmd>Lspsaga rename<CR>", opts)
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
}
