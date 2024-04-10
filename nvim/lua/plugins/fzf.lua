return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	cmd = {
		"FzfLua",
	},
	keys = {
		{ "<C-p>", "<CMD>FzfLua files<CR>", mode = "n" },
		{ "<C-f>", "<CMD>FzfLua grep_project<CR>", mode = "n" },
		{ "<C-f>", "<CMD>FzfLua grep_visual<CR>", mode = "v" },
		{ "<C-g>", "<CMD>FzfLua lsp_document_symbols<CR>", mode = "n" },
		{ "<C-b>", "<CMD>FzfLua buffers<CR>", mode = "n" },
		{ "<Leader>/", "<CMD>FzfLua lines<CR>", mode = "n" },
		{ "<Leader>m", "<CMD>FzfLua marks<CR>", mode = "n" },
	},
	opts = {
		"default",
		-- "fzf-vim",
		-- "telescope",
		winopts = {
			height = 0.90,
			width = 0.85,
			row = 0.35,
			col = 0.50,
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			fullscreen = false,
			preview = {
				default = "builtin",
				border = "border",
				wrap = "nowrap",
				hidden = "nohidden",
				vertical = "down:45%",
				horizontal = "right:60%",
				layout = "flex",
				flip_columns = 120,
				title = true,
				title_pos = "center",
				scrollbar = "float",
				scrolloff = "-2",
				scrollchars = { "█", "" },
				delay = 0,
				winopts = {
					number = true,
					relativenumber = false,
					cursorline = true,
					cursorlineopt = "both",
					cursorcolumn = false,
					signcolumn = "no",
					list = false,
					foldenable = false,
					foldmethod = "manual",
				},
			},
			on_create = function()
				-- vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
				-- vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
			end,
		},
		keymap = {
			builtin = {
				["<C-/>"] = "toggle-preview",
				["<C-j>"] = "preview-page-down",
				["<C-k>"] = "preview-page-up",
			},
		},
	},
	config = function(_, opts)
		require("fzf-lua").setup(opts)

		local NormalHl = vim.api.nvim_get_hl(0, { name = "Normal" })
		vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "FloatBorder" })
		vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = NormalHl.fg, bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { fg = "#ffffff", bg = "none" })
		vim.api.nvim_set_hl(0, "FzfLuaPreview", { fg = "none", bg = "none" })

		local get_visual_selection = function()
			vim.cmd('noau normal! "vy"')
			local text = vim.fn.getreg("v")
			vim.fn.setreg("v", {})

			text = string.gsub(text, "\n", "")
			if #text > 0 then
				return text
			else
				return ""
			end
		end
		vim.keymap.set("v", "<Leader>/", function()
			local text = get_visual_selection()
			vim.cmd("exe 'FzfLua lines " .. text .. "'")
		end, { silent = true })
	end,
}
-- return {
-- 	"junegunn/fzf.vim",
-- 	dependencies = { "junegunn/fzf" },
-- 	event = "VeryLazy",
-- 	config = function()
-- 		vim.api.nvim_set_var("wildmode", "list:longest,list:full")
-- 		vim.api.nvim_set_var("wildignore", "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__")
-- 		vim.api.nvim_set_var("$FZF_DEFAULT_OPTS", "--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up")
-- 		vim.api.nvim_set_var("fzf_layout", { window = { width = 0.90, height = 0.90, yoffset = 0.50 } })
-- 		vim.api.nvim_set_var("fzf_preview_window", { "right,50%,<70(down,60%)", "ctrl-/" })
-- 		vim.api.nvim_set_var("fzf_colors", {
-- 			fg = { "fg", "FzfNormal" },
-- 			bg = { "bg", "FzfNormal" },
-- 			["fg+"] = { "fg", "FzfCursorLine" },
-- 			["bg+"] = { "bg", "FzfCursorLine" },
-- 			["preview-fg"] = { "fg", "FzfPreview" },
-- 			["preview-bg"] = { "bg", "FzfPreview" },
-- 		})
-- 		vim.api.nvim_create_user_command(
-- 			"Files",
-- 			"call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)",
-- 			{ bang = true, nargs = "?" }
-- 		)
-- 		vim.api.nvim_set_hl(0, "FzfNormal", { fg = "none", bg = "none" })
-- 		vim.api.nvim_set_hl(0, "FzfCursorLine", { fg = "#ffffff", bg = "none" })
-- 		vim.api.nvim_set_hl(0, "FzfPreview", { fg = "none", bg = "none" })
-- 		-- fzf.vim for Silver Searcher
-- 		if vim.fn.executable("ag") then
-- 			vim.api.nvim_set_var("$FZF_DEFAULT_COMMAND", 'ag --hidden --ignore .git -g ""')
-- 			vim.opt.grepprg = "ag --nogroup --nocolor"
-- 		end
-- 		-- fzf.vim for RipGrep
-- 		if vim.fn.executable("rg") then
-- 			vim.api.nvim_set_var("$FZF_DEFAULT_COMMAND", 'rg --files --hidden --follow --glob "!.git/*"')
-- 			vim.opt.grepprg = "rg --vimgrep"
-- 			vim.api.nvim_create_user_command(
-- 				"Find",
-- 				'call fzf#vim#grep(\'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" \'.shellescape(<q-args>).\'| tr -d "\\017"\', 1, <bang>0)',
-- 				{ bang = true, nargs = "*" }
-- 			)
-- 			vim.api.nvim_create_user_command(
-- 				"Files",
-- 				"call fzf#run(fzf#wrap(#{source: 'rg --files -uuu -g !.git/ -g !node_modules/ -L', options: '--preview-window \"nohidden,wrap,down,60%\" --preview \"[ -f {} ] && bat --color=always --style=numbers {} || echo {}\"'}))",
-- 				{ bang = true, nargs = "?" }
-- 			)
-- 		end
--
-- 		local get_visual_selection = function()
-- 			vim.cmd('noau normal! "vy"')
-- 			local text = vim.fn.getreg("v")
-- 			vim.fn.setreg("v", {})
--
-- 			text = string.gsub(text, "\n", "")
-- 			if #text > 0 then
-- 				return text
-- 			else
-- 				return ""
-- 			end
-- 		end
--
-- 		local opts = { noremap = true, silent = true }
-- 		vim.keymap.set("n", "<C-b>", "<CMD>Buffers<CR>", opts)
-- 		vim.keymap.set("n", "<Leader>m", "<CMD>Marks<CR>", opts)
-- 		vim.keymap.set("n", "<C-p>", "<CMD>Files<CR>", opts)
-- 		vim.keymap.set("n", "<Leader>/", "<CMD>Lines<CR>", opts)
-- 		vim.keymap.set("v", "<Leader>/", function()
-- 			local text = get_visual_selection()
-- 			vim.cmd("exe 'Lines " .. text .. "'")
-- 		end, opts)
-- 		vim.keymap.set("n", "<C-f>", "<CMD>Rg<CR>", opts)
-- 		vim.keymap.set("v", "<C-f>", function()
-- 			local text = get_visual_selection()
-- 			vim.cmd("exe 'Rg " .. text .. "'")
-- 		end, opts)
-- 	end,
-- }
