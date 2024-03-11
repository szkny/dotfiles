return {
	"Mofiqul/vscode.nvim",
	lazy = false,
	priority = 1000,
	init = function()
		vim.opt.background = "dark"
	end,
	config = function()
		local c = require("vscode.colors").get_colors()
		require("vscode").setup({
			style = "dark",
			transparent = true,
			italic_comments = true,
			disable_nvimtree_bg = true,
			color_overrides = {
				vscLineNumber = "#666666",
			},
			group_overrides = {
				Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
			},
		})
		require("vscode").load("dark")
	end,
}
