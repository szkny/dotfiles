vim.cmd([[
    fun! LualineSkkeletonMode() abort
        try
            let l:current_mode = mode()
            if (l:current_mode=='i' || l:current_mode=='c') && exists("*skkeleton#is_enabled") && skkeleton#is_enabled()
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
		a = { fg = "#21213a", bg = "#77a0ff" },
		b = { fg = "#77a0ff", bg = "#394260" },
		c = { fg = "#a3aed2" },
	},
	insert = {
		a = { fg = "#394260", bg = "#a3aed2" },
		b = { fg = "#a3aed2", bg = "#394260" },
	},
	terminal = {
		a = { fg = "#394260", bg = "#a3aed2" },
		b = { fg = "#a3aed2", bg = "#394260" },
	},
	visual = {
		a = { fg = "#394260", bg = "#88b4c4" },
		b = { fg = "#88b4c4", bg = "#394260" },
	},
	replace = {
		a = { fg = "#394260", bg = "#9988dd" },
		b = { fg = "#9988dd", bg = "#394260" },
	},
	inactive = {
		a = { fg = "#ddddee" },
		b = { fg = "#ddddee" },
		c = { fg = "#ddddee" },
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
		-- error = " ",
		-- warn = " ",
		-- info = " ",
		-- hint = " ",
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
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { 'AndreM222/copilot-lualine' }
  },
	event = "VimEnter",
	opts = {
		options = {
			icons_enabled = true,
			theme = my_custom_theme,
			-- theme = 'vscode',
			component_separators = { left = " ", right = " " },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "NvimTree", "neo-tree", "vista", "minimap" },
				winbar = { "NvimTree", "neo-tree", "vista", "minimap" },
			},
			ignore_focus = { "NvimTree", "neo-tree", "vista", "minimap" },
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
        {
          "copilot",
          show_colors = true,
          show_loading = true,
        },
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
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
	config = function(_, opts)
		require("lualine").setup(opts)

		local DgsErrorHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignError" })
		local DgsWarnHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignWarn" })
		local DgsHintHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignHint" })
		vim.api.nvim_set_hl(0, "lualine_lsp_err", { fg = DgsErrorHl.fg })
		vim.api.nvim_set_hl(0, "lualine_lsp_warn", { fg = DgsWarnHl.fg })
		vim.api.nvim_set_hl(0, "lualine_lsp_hint", { fg = DgsHintHl.fg })
		vim.api.nvim_set_hl(0, "lualine_lsp_info", { fg = "#5599dd" })
		vim.api.nvim_set_hl(0, "lualine_diff_add", { fg = "#66aa88", bg = "#394260" })
		vim.api.nvim_set_hl(0, "lualine_diff_change", { fg = "#bbbb88", bg = "#394260" })
		vim.api.nvim_set_hl(0, "lualine_diff_delete", { fg = "#aa6666", bg = "#394260" })
	end,
}
