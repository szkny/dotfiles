return {
	"romgrk/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- lazy = false,
	event = "VeryLazy",
	opts = {
		animation = true,
		auto_hide = false,
		tabpages = false,
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
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = false },
			inactive = { button = "×", separator = { left = "│", right = "" } },
			visible = { modified = { buffer_number = false } },
		},
		highlight_alternate = false,
		highlight_inactive_file_icons = false,
		highlight_visible = true,
		insert_at_end = false,
		insert_at_start = false,
		maximum_padding = 1,
		minimum_padding = 1,
		maximum_length = 60,
		minimum_length = 12,
		sidebar_filetypes = { NvimTree = { text = "   File Explorer" } },
		no_name_title = "[No Name]",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	config = function(_, opts)
		require("barbar").setup(opts)

		local kopts = { noremap = true, silent = true }
		-- vim.keymap.set("n", "<Leader>q", ":BufferNext    <CR>:try|bdelete#|catch|bdelete|endtry|redraw!<CR>", kopts)
		-- vim.keymap.set("n", "<Leader>bq", ":BufferNext    <CR>:try|bdelete#|catch|bdelete|endtry|redraw!<CR>", kopts)
		-- vim.keymap.set("n", "<Leader>pq", ":BufferPrevious<CR>:try|bdelete#|catch|bdelete|endtry|redraw!<CR>", kopts)
		vim.keymap.set("n", "<Leader>q", ":BufferDelete<CR>", kopts)
		vim.keymap.set("n", "<Right>", ":BufferNext<CR>", kopts)
		vim.keymap.set("n", "<Left>", ":BufferPrevious<CR>", kopts)
		vim.keymap.set("n", "<M-l>", ":BufferNext<CR>", kopts)
		vim.keymap.set("n", "<M-h>", ":BufferPrevious<CR>", kopts)
		vim.keymap.set("n", "<Leader><Right>", ":BufferMoveNext<CR>", kopts)
		vim.keymap.set("n", "<Leader><Left>", ":BufferMovePrevious<CR>", kopts)

		local NormalHl = vim.api.nvim_get_hl(0, { name = "Normal" })
		vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "none" })
		vim.api.nvim_set_hl(0, "BufferCurrent", { bg = NormalHl.bg, fg = "#ffffff", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisible", { bg = "none", fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "BufferInactive", { bg = "none", fg = "#888888" })
		vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = NormalHl.bg, fg = "#ffaa00", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisibleMod", { bg = "none", fg = "#ffaa00" })
		vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = "none", fg = "#bb7700" })
		vim.api.nvim_set_hl(0, "BufferCurrentSign", { bg = NormalHl.bg, fg = "#88ccff", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisibleSign", { bg = "none", fg = "#5588dd" })
		vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "none", fg = "#555555" })
		vim.api.nvim_set_hl(0, "BufferCurrentERROR", { bg = NormalHl.bg, fg = "#ee3333" })
		vim.api.nvim_set_hl(0, "BufferVisibleERROR", { bg = "none", fg = "#ee3333" })
		vim.api.nvim_set_hl(0, "BufferInactiveERROR", { bg = "none", fg = "#aa3333" })
		vim.api.nvim_set_hl(0, "BufferCurrentWARN", { bg = NormalHl.bg, fg = "#edd000" })
		vim.api.nvim_set_hl(0, "BufferVisibleWARN", { bg = "none", fg = "#edd000" })
		vim.api.nvim_set_hl(0, "BufferInactiveWARN", { bg = "none", fg = "#908000" })
		vim.api.nvim_set_hl(0, "BufferCurrentHINT", { bg = NormalHl.bg, fg = "#5588dd" })
		vim.api.nvim_set_hl(0, "BufferVisibleHINT", { bg = "none", fg = "#5588dd" })
		vim.api.nvim_set_hl(0, "BufferInactiveHINT", { bg = "none", fg = "#4466aa" })
		vim.api.nvim_set_hl(0, "BufferCurrentINFO", { bg = NormalHl.bg, fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "BufferVisibleINFO", { bg = "none", fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "BufferInactiveINFO", { bg = "none", fg = "#888888" })
		vim.api.nvim_set_hl(0, "BufferCurrentIcon", { bg = NormalHl.bg, fg = "#667788", bold = true })
		vim.api.nvim_set_hl(0, "BufferVisibleIcon", { bg = "none", fg = "#667788" })
		vim.api.nvim_set_hl(0, "BufferInactiveIcon", { bg = "none", fg = "#667788" })
		vim.api.nvim_set_hl(0, "BufferOffset", { bg = "none" })
	end,
}
