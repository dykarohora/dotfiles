return {
	"stevearc/overseer.nvim",
	version = "1.6.*",
	keys = {
		{ "<leader>or", "<CMD>OverseerRun<CR>" },
		{ "<leader>ot", "<CMD>OverseerToggle<CR>" },
		{ "<leader>rt" },
		{ "<leader>rc" },
	},
	config = function()
		require("overseer").setup({
			templates = {
				"builtin",
				"user.tsx",
				"user.cpp",
			},
			task_list = {
				direction = "bottom",
				min_height = 10,
				max_height = 10,
			},
			component_aliases = {
				default = {
					{ "display_duration", detail_level = 2 },
					"on_output_summarize",
					"on_exit_set_status",
					"on_complete_notify",
				},
			},
		})

		local function run_tsx_split()
			if vim.bo.filetype ~= "typescript" then
				vim.notify("Not a TypeScript file", vim.log.levels.WARN)
				return
			end

			vim.cmd("write")

			local overseer = require("overseer")

			overseer.run_template({
				name = "tsx",
			})
		end

		vim.keymap.set("n", "<leader>rt", run_tsx_split, { desc = "Run TS with split" })

		local function run_cpp_split()
			if vim.bo.filetype ~= "cpp" then
				vim.notify("Not a C++ file", vim.log.levels.WARN)
				return
			end

			vim.cmd("write")

			local overseer = require("overseer")

			overseer.run_template({
				name = "cpp", -- さっきのテンプレート名
			})
		end

		vim.keymap.set("n", "<leader>rc", run_cpp_split, { desc = "Run C++ with split" })
	end,
}
