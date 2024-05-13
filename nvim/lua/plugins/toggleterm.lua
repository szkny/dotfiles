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
	config = function()
		local FloatBorderHl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
		require("toggleterm").setup({
			direction = "float",
			float_opts = {
				border = "curved",
			},
			highlights = {
				FloatBorder = {
					guifg = FloatBorderHl.fg,
					guibg = "none",
				},
			},
			on_open = function()
				vim.cmd([[startinsert]])
			end,
		})
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
		})
		vim.api.nvim_create_user_command("LazyGit", function()
			lazygit:toggle()
		end, {})
		vim.api.nvim_create_user_command("Viu", function(opts)
			local file = opts.fargs[1]
			if file then
				Terminal:new({
					cmd = "viu -t " .. file .. "; read -q",
					hidden = true,
					direction = "float",
				}):open()
			end
		end, { nargs = 1 })
	end,
}
