return {
	name = "cpp",
	builder = function()
		local file = vim.fn.expand("%:p")
		local filename = vim.fn.expand("%:t:r") -- 拡張子抜きファイル名
		local dir = vim.fn.expand("%:p:h")
		local output = dir .. "/" .. filename

		if vim.bo.filetype ~= "cpp" then
			vim.notify("Not a C++ file", vim.log.levels.WARN)
			return nil
		end

		-- ここで好きなコンパイラ/オプションに変えてOK
		local compile_cmd = string.format("g++ -std=c++20 -O2 -Wall -Wextra -o %s %s", output, file)
		local run_cmd = string.format("%s", output)

		return {
			cmd = { "sh", "-c" },
			args = { compile_cmd .. " && " .. run_cmd },
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
		filetype = { "cpp" },
	},
}
