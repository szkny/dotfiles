return {
	"nvimdev/dashboard-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- lazy = false,
	event = "VimEnter",
	config = function()
		local open_fzf_lua = function(path)
			require("fzf-lua").fzf_exec("rg --files -uuu -g !.git/ -g !node_modules/ -L -- " .. path, {
				prompt = "Files> ",
				previewer = "builtin",
				actions = {
					["default"] = require("fzf-lua").actions.file_edit,
				},
				fn_transform = function(x)
					return require("fzf-lua").make_entry.file(x, {
						file_icons = true,
						color_icons = true,
					})
				end,
			})
		end
		require("dashboard").setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				packages = { enable = true },
				shortcut = {
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Edit New",
						group = "@property",
						action = "enew!",
						key = "e",
					},
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "@property",
						action = function()
							open_fzf_lua()
						end,
						key = "C-p",
					},
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Dotfiles",
						group = "@property",
						action = function()
							open_fzf_lua("~/dotfiles")
						end,
						key = ",",
					},
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Update",
						group = "@property",
						action = "Lazy update",
						key = "u",
					},
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Quit",
						group = "@property",
						action = "qall!",
						key = "q",
					},
				},
				project = {
					enable = true,
					limit = 5,
					icon = "  ",
					label = "Recent Projects:",
					action = "edit ",
				},
			},
		})
	end,
}
