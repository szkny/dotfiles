require("lightspeed").setup({
	ignore_case = false,
	exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
	limit_ft_matches = 4,
	repeat_ft_with_target_char = false,
})
vim.api.nvim_set_hl(0, "LightspeedOneCharMatch", { fg = "#ff3377", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "LightspeedCursor", { fg = "none", bg = "none", bold = true })
