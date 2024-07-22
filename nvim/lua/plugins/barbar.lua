return {
	"szkny/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- event = "VeryLazy",
	event = "VimEnter",
	opts = {
		animation = true,
		auto_hide = false,
		exclude_ft = {
			"qf",
		},
		tabpages = true,
		clickable = true,
		icons = {
			buffer_index = false,
			buffer_number = false,
			button = "",
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
				[vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
				[vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
				[vim.diagnostic.severity.HINT] = { enabled = true, icon = " " },
				-- [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
				-- [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
				-- [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
				-- [vim.diagnostic.severity.HINT] = { enabled = true, icon = " " },
			},
			gitsigns = {
				added = { enabled = false, icon = "+" },
				changed = { enabled = false, icon = "~" },
				deleted = { enabled = false, icon = "-" },
			},
			filetype = {
				custom_colors = false,
				enabled = true,
			},
			separator = { left = "│", right = "" },
			separator_at_end = false,
			modified = { button = "●" },
			pinned = { button = "", filename = true },
			preset = "default",
			current = {
				buffer_index = false,
				filetype = { custom_colors = false },
			},
			inactive = {
				button = "×",
				separator = { left = "│", right = "" },
				filetype = { custom_colors = false },
			},
			visible = {
				filetype = { custom_colors = false },
			},
		},
		highlight_alternate = false,
		highlight_inactive_file_icons = false,
		highlight_visible = true,
		insert_at_end = false,
		insert_at_start = false,
		maximum_padding = 1,
		minimum_padding = 1,
		maximum_length = 12,
		minimum_length = 12,
		sidebar_filetypes = {
			NvimTree = {
				text = function()
					local current_directory = vim.fn.getcwd()
					local base_name = current_directory:match(".+/([^/]+)$")
					local base_name_upper = string.upper(base_name)
					return "" .. base_name_upper
					-- return " " .. base_name
				end,
				align = "left",
			},
			["neo-tree"] = {
				text = "Explorer",
				align = "center",
			},
		},
		no_name_title = "[No Name]",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	config = function(_, opts)
		require("barbar").setup(opts)

		local kopts = { noremap = true, silent = true }
		vim.keymap.set("n", "<Leader>q", ":try | exe 'BufferDelete' | catch | endtry<CR>", kopts)
		vim.keymap.set("n", "<Right>", ":BufferNext<CR>", kopts)
		vim.keymap.set("n", "<Left>", ":BufferPrevious<CR>", kopts)
		vim.keymap.set("n", "<M-l>", ":BufferNext<CR>", kopts)
		vim.keymap.set("n", "<M-h>", ":BufferPrevious<CR>", kopts)
		vim.keymap.set("n", "<Leader><Right>", ":BufferMoveNext<CR>", kopts)
		vim.keymap.set("n", "<Leader><Left>", ":BufferMovePrevious<CR>", kopts)

		local NormalHl = vim.api.nvim_get_hl(0, { name = "Normal" })
		local DgsErrorHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignError" })
		local DgsWarnHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignWarn" })
		local DgsHintHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignHint" })
		vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "none" })
		vim.api.nvim_set_hl(0, "BufferCurrent", { bg = NormalHl.bg, fg = NormalHl.fg, bold = true })
		vim.api.nvim_set_hl(0, "BufferVisible", { bg = "none", fg = NormalHl.fg })
		vim.api.nvim_set_hl(0, "BufferInactive", { bg = "none", fg = "#888888" })
		vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = NormalHl.bg, fg = "#ffddaa", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisibleMod", { bg = "none", fg = "#ffddaa" })
		vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = "none", fg = "#aa9977" })
		vim.api.nvim_set_hl(0, "BufferCurrentSign", { bg = NormalHl.bg, fg = "#88ccff", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisibleSign", { bg = "none", fg = "#5588dd" })
		vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferCurrentERROR", { bg = NormalHl.bg, fg = DgsErrorHl.fg })
		vim.api.nvim_set_hl(0, "BufferVisibleERROR", { bg = "none", fg = DgsErrorHl.fg })
		vim.api.nvim_set_hl(0, "BufferInactiveERROR", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferCurrentWARN", { bg = NormalHl.bg, fg = DgsWarnHl.fg })
		vim.api.nvim_set_hl(0, "BufferVisibleWARN", { bg = "none", fg = DgsWarnHl.fg })
		vim.api.nvim_set_hl(0, "BufferInactiveWARN", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferCurrentHINT", { bg = NormalHl.bg, fg = DgsHintHl.fg })
		vim.api.nvim_set_hl(0, "BufferVisibleHINT", { bg = "none", fg = DgsHintHl.fg })
		vim.api.nvim_set_hl(0, "BufferInactiveHINT", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferCurrentINFO", { bg = NormalHl.bg, fg = NormalHl.fg })
		vim.api.nvim_set_hl(0, "BufferVisibleINFO", { bg = "none", fg = NormalHl.fg })
		vim.api.nvim_set_hl(0, "BufferInactiveINFO", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferCurrentIcon", { bg = NormalHl.bg, fg = "#778899", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisibleIcon", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferInactiveIcon", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferOffset", { bg = "none", bold = true })
	end,
}
