return {
	"gorbit99/codewindow.nvim",
	-- event = "VeryLazy",
	keys = {
		{
			"<C-k>",
			"<CMD>lua require('codewindow').toggle_minimap()<CR>",
			mode = "n",
			silent = true,
		},
	},
	opts = {
		active_in_terminals = false,
		auto_enable = false,
		exclude_filetypes = { "help" },
		max_minimap_height = nil,
		max_lines = nil,
		minimap_width = 10,
		width_multiplier = 5, -- How many characters one dot represents
		use_treesitter = true,
		use_lsp = true,
		use_git = true,
		z_index = 1,
		show_cursor = true,
		screen_bounds = "background",
		-- window_border = "rounded",
		window_border = "none",
		-- relative = "editor",
		relative = "win",
		events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" },
	},
	config = function(_, opts)
		local codewindow = require("codewindow")
		codewindow.setup(opts)
		vim.api.nvim_set_hl(0, "CodewindowBorder", { fg = "#2f2f2f", bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowBackground", { bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowBoundsBackground", { bg = "#2f2f2f" })
		vim.api.nvim_set_hl(0, "CodewindowWarn", { fg = "#edd000", bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowError", { fg = "#ee3333", bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowUnderline", { fg = "#0000ff", bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowAddition", { fg = "#00aa77", bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowDeletion", { fg = "#bb0000", bg = "none" })
	end,
}
