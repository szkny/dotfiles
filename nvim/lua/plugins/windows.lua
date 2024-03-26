return {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
		"anuvyklack/animation.nvim",
	},
	keys = {
		{ "<C-w>z", "<CMD>WindowsMaximize<CR>", mode = "n" },
		{ "<C-w>_", "<CMD>WindowsMaximizeVertically<CR>", mode = "n" },
		{ "<C-w>|", "<CMD>WindowsMaximizeHorizontally<CR>", mode = "n" },
		{ "<C-w>=", "<CMD>WindowsEqualize<CR>", mode = "n" },
	},
	opts = {
		autowidth = {
			enable = true,
			winwidth = 5,
			filetype = {
				help = 2,
			},
		},
		ignore = {
			buftype = { "quickfix" },
			filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
		},
		animation = {
			enable = true,
			duration = 200,
			fps = 60,
			easing = "in_out_sine",
		},
	},
	config = function(_, opts)
		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false
		require("windows").setup(opts)
	end,
}
