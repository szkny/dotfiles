return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"ibhagwan/fzf-lua",
	},
	event = "VeryLazy",
	-- config = true,
	opts = {},
	config = function(_, opts)
		require("neogit").setup(opts)
	end,
}
