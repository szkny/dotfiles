return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "TroubleToggle" },
	opts = {
		position = "bottom",
		height = 5,
		mode = "workspace_diagnostics",
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.HINT,
			vim.diagnostic.severity.INFO,
		},
		icon = true,
		use_diagnostic_signs = false,
		signs = {
			error = "",
			warning = "",
			hint = "",
			information = "",
			other = "",
		},
	},
}
