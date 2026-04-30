return {
	name = "go",
	builder = function()
		local file = vim.fn.expand("%:p")
		if vim.bo.filetype ~= "go" then
			vim.notify("Not a Go file", vim.log.levels.WARN)
			return nil
		end

		return {
			cmd = { "go" },
			args = { "run", file },
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
		filetype = { "go" },
	},
}
