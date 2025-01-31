return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	event = "VeryLazy",
	opts = {
		messages = {
			enabled = true,
			view = "notify",
			view_error = "notify",
			view_warn = "notify",
			view_history = "messages",
			view_search = "mini",
		},
		cmdline = {
			enabled = true,
			view = "cmdline",
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "zsh" },
				lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
			},
		},
		presets = {
			bottom_search = false,
			command_palette = false,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		-- for LSP hover
		routes = {
			{
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = {
					skip = true,
				},
			},
		},
	},
	config = function(_, opts)
		require("noice").setup(opts)
		vim.api.nvim_set_hl(0, "NoiceMini", { fg = "#ffbb00", bg = "#383838" })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = "none", bg = "none" })
		vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = "none", bg = "none" })
		vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = "none", bg = "none" })
	end,
}
