return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VimEnter",
	opts = {
		highlight = {
			enable = true,
			disable = {
				"haskell",
				"markdown",
				"vim",
				"terraform",
				"terraform-vars",
			},
			additional_vim_regex_highlighting = false,
		},
		ensure_installed = {
			"vim",
			"regex",
			"json",
			"markdown",
			"markdown_inline",
			"c",
			"cpp",
			"cmake",
			"gitignore",
			"python",
			"go",
			"javascript",
			"typescript",
			"vue",
			"html",
			"css",
			"http",
			"bash",
		},
		sync_install = false,
		auto_install = true,
		ignore_install = { "haskell", "help" },
		indent = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
