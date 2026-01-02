return {
	name = "tsx",
	builder = function()
		local file = vim.fn.expand("%:p")
		if vim.bo.filetype ~= "typescript" then
			vim.notify("Not a Typescript file", vim.log.levels.WARN)
			return nil
		end

		return {
			cmd = { "npx" },
			args = { "--no-install", "tsx", file },
			components = {
				"default",
				{
					"open_output",
					direction = "vertical",
					focus = true,
				},
			},
		}
	end,
	condition = {
		filetype = { "typescript" },
	},
}
