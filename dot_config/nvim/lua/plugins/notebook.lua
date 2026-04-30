return {
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false,
		config = function()
			require("jupytext").setup({
				style = "hydrogen",
				output_extension = "auto",
				force_ft = "python",
			})
		end,
	},

	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			integrations = {},
			max_width = 100,
			max_height = 12,
			max_width_window_percentage = math.huge,
			max_height_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},

	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		lazy = false,
		build = ":UpdateRemotePlugins",
		dependencies = {
			"3rd/image.nvim",
		},

		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_auto_open_output = false
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_output_win_max_height = 20
		end,

		config = function()
			local group = vim.api.nvim_create_augroup("dsk_molten", { clear = true })

			local function is_cell_separator(line)
				return line:match("^# %%%%") ~= nil
			end

			local function find_cell_range()
				local buf = 0
				local cur = vim.api.nvim_win_get_cursor(0)[1]
				local last = vim.api.nvim_buf_line_count(buf)

				local start_line = 1
				local end_line = last

				for l = cur, 1, -1 do
					local text = vim.api.nvim_buf_get_lines(buf, l - 1, l, false)[1] or ""
					if is_cell_separator(text) then
						start_line = l
						break
					end
				end

				for l = start_line + 1, last do
					local text = vim.api.nvim_buf_get_lines(buf, l - 1, l, false)[1] or ""
					if is_cell_separator(text) then
						end_line = l - 1
						break
					end
				end

				return start_line, end_line
			end

			local function run_current_cell()
				local start_line, end_line = find_cell_range()

				vim.api.nvim_win_set_cursor(0, { start_line, 0 })
				vim.cmd("normal! V")
				vim.api.nvim_win_set_cursor(0, { end_line, 0 })
				vim.cmd("MoltenEvaluateVisual")
			end

			local function goto_next_cell()
				local cur = vim.api.nvim_win_get_cursor(0)[1]
				local last = vim.api.nvim_buf_line_count(0)

				for l = cur + 1, last do
					local text = vim.api.nvim_buf_get_lines(0, l - 1, l, false)[1] or ""
					if is_cell_separator(text) then
						vim.api.nvim_win_set_cursor(0, { l, 0 })
						return
					end
				end
			end

			local function goto_prev_cell()
				local cur = vim.api.nvim_win_get_cursor(0)[1]

				for l = cur - 1, 1, -1 do
					local text = vim.api.nvim_buf_get_lines(0, l - 1, l, false)[1] or ""
					if is_cell_separator(text) then
						vim.api.nvim_win_set_cursor(0, { l, 0 })
						return
					end
				end
			end

			local map = vim.keymap.set

			map("n", "<leader>mi", "<cmd>MoltenInit<CR>", { desc = "Molten Init Kernel", silent = true })
			map("n", "<leader>md", "<cmd>MoltenDeinit<CR>", { desc = "Molten Deinit Kernel", silent = true })

			map("n", "<leader>ml", "<cmd>MoltenEvaluateLine<CR>", { desc = "Molten Run Line", silent = true })
			map("n", "<leader>mr", "<cmd>MoltenReevaluateCell<CR>", { desc = "Molten Rerun Cell", silent = true })
			map("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten Run Visual", silent = true })

			map("n", "<leader>mc", run_current_cell, { desc = "Molten Run Current Cell", silent = true })

			map(
				"n",
				"<leader>mo",
				"<cmd>noautocmd MoltenEnterOutput<CR>",
				{ desc = "Molten Show Output", silent = true }
			)
			map("n", "<leader>mh", "<cmd>MoltenHideOutput<CR>", { desc = "Molten Hide Output", silent = true })

			map("n", "<leader>mx", "<cmd>MoltenExportOutput!<CR>", { desc = "Molten Export Output", silent = true })
			map("n", "<leader>mp", "<cmd>MoltenImagePopup<CR>", { desc = "Molten Image Popup", silent = true })

			map("n", "]m", goto_next_cell, { desc = "Next Notebook Cell", silent = true })
			map("n", "[m", goto_prev_cell, { desc = "Prev Notebook Cell", silent = true })

			vim.g.molten_auto_open_output = true
			vim.g.molten_output_win_max_height = 40

			vim.api.nvim_create_autocmd("BufReadPost", {
				group = group,
				pattern = "*.ipynb",
				callback = function()
					vim.schedule(function()
						pcall(vim.cmd, "MoltenImportOutput")
					end)
				end,
			})

			vim.api.nvim_create_autocmd("BufWritePost", {
				group = group,
				pattern = "*.ipynb",
				callback = function()
					pcall(vim.cmd, "MoltenExportOutput!")
				end,
			})
		end,
	},
}
