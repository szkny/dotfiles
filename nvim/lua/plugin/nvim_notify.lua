--   stages = "fade_in_slide_out",
--   stages = "fade",
--   render = "default",
--   render = "compact",
require("notify").setup({
	stages = "fade_in_slide_out",
	render = "default",
	background_colour = "#252525",
	timeout = 3000,
	max_width = 80,
	minimum_width = 50,
	top_down = false,
	fps = 60,
	icons = {
		ERROR = " ",
		WARN = " ",
		INFO = " ",
		DEBUG = " ",
		TRACE = "✎ ",
	},
})
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#8a1f1f", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#79491d", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#4f6752", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#8b8b8b", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#4f3552", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = "#f70067", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = "#f79000", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#a9ff68", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = "#8b8b8b", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = "#d484ff", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#f70067", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#F79000", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#A9FF68", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#8B8B8B", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#D484FF", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = "none", bg = "#252525" })
