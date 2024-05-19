return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	opts = {
		chunk = {
			enable = true,
			notify = true,
			use_treesitter = true,
			chars = {
				horizontal_line = "─",
				vertical_line = "│",
				left_top = "╭",
				left_bottom = "╰",
				right_arrow = "→",
			},
			textobject = "",
			max_file_size = 1024 * 1024,
			error_sign = true,
		},
		indent = {
			enable = true,
			use_treesitter = false,
			chars = {
				"│",
			},
		},
		line_num = {
			enable = false,
			use_treesitter = true,
		},
		blank = {
			enable = true,
			chars = {
				-- "․",
				" ",
			},
		},
	},
	config = function(_, opts)
		-- local HighlightFg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "fg", "gui")
		local HighlightFg = "#80b0c0"
		local OtherFg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui")
		opts.chunk.style = {
			{ fg = HighlightFg, bg = "none", bold = true },
			{ fg = "#c21f30", bold = true },
		}
		opts.indent.style = {
			{ fg = OtherFg, bg = "none" },
		}
		opts.line_num.style = HighlightFg
		opts.blank.style = { OtherFg }
		require("hlchunk").setup(opts)
	end,
}
