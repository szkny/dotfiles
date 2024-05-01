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
			-- 	command = "viu -x 25 -t ~/dotfiles/nvim/logo/nvim.png; read -q", -- preview command
			-- 	file_path = "", -- preview file path
			-- 	file_height = 15, -- preview file height
			-- 	file_width = 80, -- preview file width
			-- },
			preview = {
				command = "cat", -- preview command
				file_path = "~/dotfiles/nvim/logo/nvim-ascii.txt ; read -q", -- preview file path
				file_height = 15, -- preview file height
				file_width = 80, -- preview file width
			},
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
					icon = "  ",
					label = "Recent Projects:",
					action = "edit ",
				},
			},
		})
		-- vim.api.nvim_create_user_command("DashboardImage", function()
		-- 	vim.cmd([[
		--       " Show image in dashboard using ansi escape sequences
		--       function! DashboardImage()
		--         let s:width = 120
		--         let s:height = 17
		--         let s:row = float2nr(s:height / 5)
		--         let s:col = float2nr((&columns - s:width) / 2)
		--         let s:opts = {
		--           \ 'relative': 'editor',
		--           \ 'row': s:row,
		--           \ 'col': s:col,
		--           \ 'width': s:width,
		--           \ 'height': s:height,
		--           \ 'style': 'minimal'
		--           \ }
		--         let s:buf = nvim_create_buf(v:false, v:true)
		--         let s:win = nvim_open_win(s:buf, v:true, s:opts)
		--         hi! DashboardImage guibg=NONE guifg=NONE
		--         call nvim_win_set_option(s:win, "winblend", 0)
		--         call nvim_win_set_option(s:win, "winhl", "Normal:DashboardImage")
		--         terminal cat ~/Downloads/ascii.txt
		--         :exe "normal \<C-W>\<C-w>"
		--       endfunction
		--     ]])
		-- end, {})
	end,
}
