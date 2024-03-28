return {
	"gorbit99/codewindow.nvim",
	dependencies = {
		"petertriho/nvim-scrollbar",
	},
	event = "VeryLazy",
	keys = {
		{
			"<C-k>",
			"<CMD>ScrollbarToggle<CR><CMD>lua require('codewindow').toggle_minimap()<CR>",
			mode = { "n", "v", "i" },
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
		-- screen_bounds = "lines",
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
		local cursorLineHl = vim.api.nvim_get_hl(0, { name = "CursorLine" })
		local DgsErrorHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignError" })
		local DgsWarnHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignWarn" })
		vim.api.nvim_set_hl(0, "CodewindowBorder", { fg = "#2f2f2f", bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowBackground", { bg = "none" })
		vim.api.nvim_set_hl(0, "CodewindowBoundsBackground", { bg = cursorLineHl.bg })
		vim.api.nvim_set_hl(0, "CodewindowError", { fg = DgsErrorHl.fg, bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "CodewindowWarn", { fg = DgsWarnHl.fg, bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "CodewindowAddition", { fg = "#00aa77", bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "CodewindowDeletion", { fg = "#bb0000", bg = "none", bold = true })
		codewindow.open_minimap()
	end,
}
