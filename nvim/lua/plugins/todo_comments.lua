return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
	},
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)
		-- vim.api.nvim_create_user_command("Todos", function()
		-- 	local rg_cmd_grep = "rg --line-number --ignore-case --color=always -- TODO|HACK|PERF|NOTE|FIX"
		-- 	require("fzf-lua").fzf_exec(rg_cmd_grep, {
		-- 		prompt = "TODO> ",
		-- 		previewer = "builtin",
		-- 		actions = require("fzf-lua").defaults.actions.files,
		-- 	})
		-- end, {})
	end,
}
