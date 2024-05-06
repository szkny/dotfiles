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
		local logo = ""
			.. "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗\n"
			.. "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║\n"
			.. "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║\n"
			.. "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║\n"
			.. "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║\n"
			.. "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝\n"

		logo = string.rep("\n", 8) .. logo .. "\n\n"
		local header = vim.split(logo, "\n")
		require("dashboard").setup({
			theme = "hyper",
			disable_move = true, --  default is false disable move keymap for hyper
			shortcut_type = "number", --  shorcut type 'letter' or 'number'
			change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
			hide = {
				statusline = true,
				tabline = true,
				winbar = true,
			},
			-- preview = {
			-- 	command = "viu -x 15 -w 100 -t ~/dotfiles/nvim/logo/neovim-logo-2.png; read -q", -- preview command
			-- 	file_path = "", -- preview file path
			-- 	file_height = 20, -- preview file height
			-- 	file_width = 130, -- preview file width
			-- },
			-- preview = {
			-- 	command = [[
			--        FILE=$HOME/dotfiles/nvim/logo/nvim-ascii.txt;
			--        printf '%0.s\n' $(seq 1 $(($(tput lines) - $(wc -l < $FILE) - 2 )));
			--        cat $FILE;
			--        read -q
			--      ]], -- preview command
			-- 	file_path = "", -- preview file path
			-- 	file_height = 20, -- preview file height
			-- 	file_width = 80, -- preview file width
			-- },
			config = {
				header = header,
				week_header = {
					enable = false,
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
						icon = " ",
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
						icon = " ",
						icon_hl = "@variable",
						desc = "Update",
						group = "@property",
						action = "Lazy update",
						key = "U",
					},
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Quit",
						group = "@property",
						action = "qall!",
						key = "q",
					},
				},
				project = {
					enable = true,
					limit = 4,
					icon = "  ",
					label = "Recent Projects:",
					action = "edit ",
				},
				mru = {
					limit = 5,
					icon = "  ",
					label = "Most Recent Files:",
					cwd_only = false,
				},
			},
		})
	end,
}
