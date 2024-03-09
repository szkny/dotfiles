require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"vim",
		"regex",
		"json",
		"markdown",
		"c",
		"cpp",
		"python",
		"go",
		"javascript",
		"typescript",
		"vue",
		"css",
	},
	sync_install = false,
	auto_install = true,
	ignore_install = { "haskell", "help" },
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
	indent = {
		enable = true,
	},
})
