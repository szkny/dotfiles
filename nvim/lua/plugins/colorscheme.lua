-- return {
-- 	"Mofiqul/vscode.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	init = function()
-- 		vim.opt.background = "dark"
-- 	end,
-- 	config = function()
-- 		local c = require("vscode.colors").get_colors()
-- 		require("vscode").setup({
-- 			style = "dark",
-- 			transparent = true,
-- 			italic_comments = true,
-- 			disable_nvimtree_bg = true,
-- 			color_overrides = {
-- 				vscLineNumber = "#666666",
-- 			},
-- 			group_overrides = {
-- 				Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
-- 				DiagnosticSignError = { fg = "#ee3333", bg = "none" },
-- 				DiagnosticSignWarn = { fg = "#edd000", bg = "none" },
-- 				DiagnosticSignHint = { fg = "#5588dd", bg = "none" },
-- 			},
-- 		})
-- 		require("vscode").load("dark")
-- 	end,
-- }

-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
-- 		-- style = "storm",
-- 		-- style = "moon",
-- 		style = "night",
-- 		transparent = true,
-- 		styles = {
-- 			comments = { italic = true },
-- 			keywords = { italic = true },
-- 			functions = {},
-- 			variables = {},
-- 			sidebars = "transparent",
-- 			floats = "transparent",
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		require("tokyonight").setup(opts)
-- 		vim.cmd("colorscheme tokyonight")
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none", fg = "#c53b53" })
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none", fg = "#edd000" })
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none", fg = "#4fd6be" })
-- 	end,
-- }

return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha",
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = true,
		show_end_of_buffer = false,
		term_colors = false,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		no_italic = false,
		no_bold = false,
		no_underline = false,
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = true,
			aerial = true,
			barbar = true,
			barbecue = {
				dim_dirname = true,
				bold_basename = true,
				dim_context = true,
				alt_background = true,
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
-- 		transparent = true,
-- 		overrides = function(colors)
-- 			local theme = colors.theme
-- 			return {
-- 				NormalFloat = { bg = "none" },
-- 				FloatBorder = { bg = "none" },
-- 				FloatTitle = { bg = "none" },
-- 				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
-- 				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
-- 				MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
-- 				Normal = { bg = "none" },
-- 				NonText = { bg = "none" },
-- 				EndOfBuffer = { bg = "none" },
-- 				LineNr = { bg = "none" },
-- 				SignColumn = { bg = "none" },
-- 				Folded = { bg = "none" },
-- 				VertSplit = { bg = "none" },
-- 				NormalNC = { bg = "none" },
-- 				Comment = { bg = "none" },
-- 				Constant = { bg = "none" },
-- 				Special = { bg = "none" },
-- 				Identifier = { bg = "none" },
-- 				Statement = { bg = "none" },
-- 				PreProc = { bg = "none" },
-- 				Type = { bg = "none" },
-- 				Underlined = { bg = "none" },
-- 				Todo = { bg = "none" },
-- 				String = { bg = "none" },
-- 				Function = { bg = "none" },
-- 				Conditional = { bg = "none" },
-- 				Repeat = { bg = "none" },
-- 				Operator = { bg = "none" },
-- 				Structure = { bg = "none" },
-- 				StatusLine = { bg = "none" },
-- 				StatusLineNC = { bg = "none" },
-- 				CursorLine = { bg = "none" },
-- 				CursorLineNr = { bg = "none" },
-- 				Cursor = { bg = "none" },
-- 			}
-- 		end,
-- 	},
-- 	config = function(_, opts)
-- 		require("kanagawa").setup(opts)
-- 		require("kanagawa").load("wave")
-- 	end,
-- }

-- return {
-- 	"craftzdog/solarized-osaka.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
-- 		transparent = true,
-- 		terminal_colors = true,
-- 		styles = {
-- 			comments = { italic = true },
-- 			keywords = { italic = true },
-- 			functions = {},
-- 			variables = {},
-- 			sidebars = "transparent",
-- 			floats = "transparent",
-- 		},
-- 		sidebars = { "qf", "help", "NvimTree", "terminal" },
-- 		day_brightness = 0.0,
-- 		hide_inactive_statusline = false,
-- 		dim_inactive = true,
-- 		lualine_bold = true,
-- 	},
-- 	config = function(_, opts)
-- 		require("solarized-osaka").setup(opts)
-- 		vim.cmd([[colorscheme solarized-osaka]])
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none", fg = "#c53b53" })
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none", fg = "#edd000" })
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none", fg = "#4fd6be" })
-- 	end,
-- }
