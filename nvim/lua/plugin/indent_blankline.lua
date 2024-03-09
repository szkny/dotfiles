require("indent_blankline").setup({
	show_current_context = true,
	show_current_context_start = true,
})
vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_context_char = "┃"
vim.g.indent_blankline_space_char_blankline = " "
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_indent_level = 30
vim.g.indent_blankline_max_indent_increase = vim.g.indent_blankline_indent_level
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_show_current_context_start = true
vim.g.indent_blankline_filetype_exclude =
	{ "terminal", "help", "fzf", "vista", "vista_kind", "NvimTree", "mason", "rnvimr" }
vim.g.indent_blankline_bufname_exclude = { "README.md" }
vim.g.indent_blankline_disable_with_nolist = true
vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3a3a3a", bg = "none", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#606060", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg = "#3a3a3a", bg = "none", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { fg = "#3a3a3a", bg = "none", nocombine = true })
