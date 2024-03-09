vim.cmd([[
    fun! LualineSkkeletonMode() abort
        try
            let l:current_mode = mode()
            if (l:current_mode=='i' || l:current_mode=='c') && skkeleton#is_enabled()
                let l:mode_dict = #{
                  \ hira:    'あ',
                  \ kata:    'ア',
                  \ hankata: '_ｱ',
                  \ zenkaku: 'Ａ',
                  \ abbrev:  'abbr',
                  \ }
                let l:mode = mode_dict[skkeleton#mode()]
                return 'IME:'.l:mode
            else
                return ''
            endif
        catch
            return ''
        endtry
    endf
]])
vim.g.lualine_diagnostics_source = "nvim_diagnostic"
local my_custom_theme = {
	normal = {
		a = { fg = "#ddddee", bg = "#5588dd", gui = "bold" },
		b = { fg = "#5588dd", bg = "#394260" },
		c = { fg = "#5588dd", bg = "#212736" },
	},
	insert = { a = { fg = "#394260", bg = "#a3aed2", gui = "bold" } },
	terminal = { a = { fg = "#394260", bg = "#a3aed2", gui = "bold" } },
	visual = { a = { fg = "#394260", bg = "#88b4c4", gui = "bold" } },
	replace = { a = { fg = "#394260", bg = "#9988dd", gui = "bold" } },
	inactive = {
		a = { fg = "#ddddee", bg = "#212736" },
		b = { fg = "#ddddee", bg = "#212736" },
		c = { fg = "#ddddee", bg = "#212736" },
	},
}
local lualine_diagnostics = {
	"diagnostics",
	sources = { vim.g.lualine_diagnostics_source },
	sections = { "error", "warn", "info", "hint" },
	diagnostics_color = {
		error = "lualine_lsp_err",
		warn = "lualine_lsp_warn",
		info = "lualine_lsp_info",
		hint = "lualine_lsp_hint",
	},
	symbols = {
		error = " ",
		warn = " ",
		info = " ",
		hint = " ",
	},
	colored = true,
	update_in_insert = true,
	always_visible = false,
}
local lualine_diff = {
	"diff",
	colored = true,
	diff_color = {
		added = "lualine_diff_add",
		modified = "lualine_diff_change",
		removed = "lualine_diff_delete",
	},
	symbols = { added = "+", modified = "~", removed = "-" },
}
local lualine_filename = {
	"filename",
	file_status = true,
	newfile_status = false,
	symbols = {
		modified = "●",
		readonly = "",
		unnamed = "[No Name]",
		newfile = "[New]",
	},
}
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = my_custom_theme,
		-- theme = 'vscode',
		component_separators = { left = " ", right = " " },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "NvimTree", "vista", "minimap" },
			winbar = { "NvimTree", "vista", "minimap" },
		},
		ignore_focus = { "NvimTree", "vista", "minimap" },
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 250,
			tabline = 250,
			winbar = 250,
		},
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "", right = "" } },
			{ "LualineSkkeletonMode" },
		},
		lualine_b = { "branch", lualine_diff },
		lualine_c = {
			lualine_filename,
			-- { 'LualineVistaNearestMethodOrFunction' },
		},
		lualine_x = {
			lualine_diagnostics,
			"filetype",
			"encoding",
			"fileformat",
		},
		lualine_y = { "progress" },
		lualine_z = { { "location", separator = { left = "", right = "" } } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {
		-- lualine_c = {
		--   {
		--     [[
		--       require('nvim-navic').get_location()
		--       .. ( require('nvim-navic').is_available() and ' ' or '' )
		--     ]],
		--     color_correction = nil,
		--     navic_opts = nil,
		--     color = { fg = '#666666', bg = 'none' }
		--   }
		-- }
	},
	inactive_winbar = {},
	extensions = {},
})
vim.api.nvim_set_hl(0, "lualine_lsp_err", { fg = "#ee3333", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_warn", { fg = "#edd000", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_hint", { fg = "#5599dd", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_info", { fg = "#5599dd", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_diff_add", { fg = "#66aa88", bg = "#394260" })
vim.api.nvim_set_hl(0, "lualine_diff_change", { fg = "#bbbb88", bg = "#394260" })
vim.api.nvim_set_hl(0, "lualine_diff_delete", { fg = "#aa6666", bg = "#394260" })
