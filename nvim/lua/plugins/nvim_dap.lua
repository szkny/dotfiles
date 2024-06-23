return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	config = function()
		local dap = require("dap")
		dap.adapters.python = function(cb, config)
			local python_cmd = "python"
			if vim.fn.executable("poetry") == 1 then
				python_cmd = "poetry run python"
			end
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = python_cmd,
					-- args = { "-m", "debugpy.adapter" },
					args = { "-m", "debugpy" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					if vim.fn.executable("poetry") == 1 then
						return vim.fn.system("poetry run which python")
					end
					return vim.fn.system("which python")
				end,
			},
		}
	end,
}
