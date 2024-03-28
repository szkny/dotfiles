return {
	"utilyre/barbecue.nvim",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		create_autocmd = false,
		theme = {
			normal = { bg = "none" },
		},
	},
	config = function(_, opts)
		require("barbecue").setup(opts)
		vim.api.nvim_create_autocmd({
			"WinScrolled",
			"BufWinEnter",
			"CursorHold",
			"InsertLeave",
			"BufModifiedSet",
		}, {
			group = vim.api.nvim_create_augroup("barbecue.updater", {}),
			callback = function()
				require("barbecue.ui").update()
			end,
		})
	end,
}
