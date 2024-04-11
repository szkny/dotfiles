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
		previewers = {
			builtin = {
				syntax = true,
				syntax_limit_l = 0,
				syntax_limit_b = 1024 * 1024 * 0.5,
				limit_b = 1024 * 1024 * 0.5,
				-- limit_b = 1024 * 1024 * 10,
				treesitter = { enable = true, disable = {} },
				toggle_behavior = "default",
			},
		},
		keymap = {
			builtin = {
				["<C-_>"] = "toggle-preview",
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
		vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { link = "Cursorline" })
		vim.api.nvim_set_hl(0, "FzfLuaPreview", { fg = "none", bg = "none" })

		local get_visual_selection = function()
			vim.cmd('noau normal! "vy"')
			local text = vim.fn.getreg("v")
			vim.fn.setreg("v", {})

			text = string.gsub(tostring(text), "\n", "")
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
