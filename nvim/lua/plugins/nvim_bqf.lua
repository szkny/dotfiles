return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	opts = {
		auto_enable = true,
		auto_resize_height = true,
		preview = {
			win_height = 15,
			win_vheight = 15,
			winblend = 0,
			border = "rounded",
			show_title = true,
			delay_syntax = 0,
			show_scroll_bar = true,
			buf_label = false,
			wrap = false,
		},
	},
	config = function(_, opts)
		local FloatBorderFg = vim.api.nvim_get_hl(0, { name = "FloatBorder" }).fg
		vim.api.nvim_set_hl(0, "BqfPreviewFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "BqfPreviewBorder", { fg = FloatBorderFg, bg = "none" })
		vim.api.nvim_set_hl(0, "BqfPreviewTitle", { fg = FloatBorderFg, bg = "none" })
		require("bqf").setup(opts)
	end,
}
