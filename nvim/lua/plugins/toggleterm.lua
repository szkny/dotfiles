return {
	"akinsho/toggleterm.nvim",
	cmd = {
		"ToggleTerm",
		"ToggleTermToggleAll",
	},
	keys = {
		{ "t", "<CMD>ToggleTerm<CR>", mode = "n" },
		{ "<leader>gg", "<CMD>LazyGit<CR>", mode = "n" },
	},
	event = "VeryLazy",
	version = "*",
	opts = {
		direction = "float",
		float_opts = {
			border = "curved",
		},
		highlights = {
			FloatBorder = {
				guifg = "#555555",
				guibg = "none",
			},
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
		})
		vim.api.nvim_create_user_command("LazyGit", function()
			lazygit:toggle()
		end, {})
	end,
}
