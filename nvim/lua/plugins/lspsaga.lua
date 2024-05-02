return {
	"szkny/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	opts = {
		ui = {
			border = "rounded",
			devicon = true,
			title = true,
			expand = "⊞",
			collapse = "⊟",
			code_action = "💡",
			actionfix = " ",
		},
		symbol_in_winbar = {
			enable = false,
		},
		code_action = {
			num_shortcut = true,
			show_server_name = true,
			extend_gitsigns = false,
			keys = {
				quit = { "<ESC>", "q" },
				exec = "<CR>",
			},
		},
		definition = {
			width = 0.9,
			height = 0.9,
			keys = {
				quit = { "<ESC>", "q" },
			},
		},
		diagnostic = {
			show_code_action = true,
			jump_num_shortcut = true,
			max_width = 0.8,
			max_height = 0.6,
			text_hl_follow = true,
			border_follow = true,
			extend_relatedInformation = true,
			show_layout = "float",
			show_normal_height = 10,
			max_show_width = 0.9,
			max_show_height = 0.6,
			diagnostic_only_current = false,
			keys = {
				exec_action = "o",
				toggle_or_jump = "<CR>",
				quit = { "q", "<ESC>" },
				quit_in_show = { "q", "<ESC>" },
			},
		},
	},
	config = function(_, opts)
		require("lspsaga").setup(opts)
		vim.keymap.set("n", "<leader>a", function()
			Try({
				function()
					vim.cmd([[Lspsaga code_action]])
				end,
				Catch({
					nil,
				}),
			})
		end)
		-- vim.keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>")
		vim.keymap.set("n", "<leader>n", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		vim.keymap.set("n", "<leader>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>")
		vim.keymap.set("n", "<leader>]", "<cmd>Lspsaga peek_definition<CR>")
		vim.keymap.set("n", "<C-]>", "<cmd>Lspsaga goto_definition<CR>")
	end,
}
