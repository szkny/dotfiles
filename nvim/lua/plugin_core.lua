-- *****************************************************************************
--   Plugin manager core
-- *****************************************************************************
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- cache loader
if vim.loader then
	vim.loader.enable()
end

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- *****************************************************************************
--   Install plugins
-- *****************************************************************************
local options = {
	defaults = {
		lazy = true,
	},
	ui = {
		size = { width = 0.9, height = 0.9 },
		wrap = true,
		border = "rounded",
		backdrop = 100,
		title = "Lazy.nvim",
		title_pos = "center",
	},
}
require("lazy").setup("plugins", options)
