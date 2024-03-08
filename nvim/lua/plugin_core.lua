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

-- *****************************************************************************
--   Install plugins
-- *****************************************************************************
local options = {
	defaults = {
		lazy = true,
	},
}
local plugins = {
	{
		"nvim-tree/nvim-web-devicons",
		opts = require("plugin.nvim_web_devicons"),
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = require("plugin.comment"),
	},
	{
		"kevinhwang91/rnvimr",
		cmd = "RnvimrToggle",
		keys = {
			{ "<C-h>", "<CMD>RnvimrToggle<CR>", mode = "n" },
		},
		config = function()
			require("plugin.rnvimr")
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "CmdlineEnter",
		config = function()
			require("plugin.vim_fugitive")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin.gitsigns")
		end,
	},
	{ "rbong/vim-flog", cmd = "Flog" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	},
	{
		"junegunn/vim-easy-align",
		event = "VeryLazy",
		config = function()
			vim.g.easy_align_ignore_groups = { "String" }
			vim.keymap.set("v", "<Leader>=", ":EasyAlign *=<CR>", { noremap = true, silent = true })
			vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)", { noremap = true, silent = true })
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		-- lazy = false,
		-- event = "VeryLazy",
		dependencies = {
			"petertriho/nvim-scrollbar",
		},
		-- config = function()
		-- 	require("plugin.nvim_hlslens")
		-- end,
	},
	{ "liuchengxu/vista.vim", cmd = "Vista" },
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{ "nvim-lualine/lualine.nvim" },
	{ "wfxr/minimap.vim", cmd = "MinimapToggle" },
	-- { 'mg979/vim-visual-multi' },
	{ "petertriho/nvim-scrollbar" },
	{ "karb94/neoscroll.nvim" },
	{ "romgrk/barbar.nvim" },
	{ "brenoprata10/nvim-highlight-colors" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "lukas-reineke/indent-blankline.nvim", tag = "v2.20.8" },
	{ "rmagatti/auto-session" },
	{ "Mofiqul/vscode.nvim" },
	{ "stevearc/oil.nvim" },
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "NvimTreeToggle" },
		keys = {
			{ "<C-n>", "<CMD>NvimTreeToggle<CR>", mode = "n" },
		},
		config = function()
			require("plugin.nvim_tree")
		end,
	},
	{ "szkny/SplitTerm", lazy = false },
	{ "junegunn/fzf", lazy = false },
	{ "junegunn/fzf.vim", lazy = false },
	{ "MunifTanjim/nui.nvim" },
	{ "rcarriga/nvim-notify" },
	{ "folke/noice.nvim" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
	},
	{ "folke/neodev.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "SmiteshP/nvim-navic", lazy = false },
	{ "SmiteshP/nvim-navbuddy", lazy = false },
	{ "utilyre/barbecue.nvim" },
	{ "stevearc/aerial.nvim" },
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "hrsh7th/nvim-cmp", event = { "InsertEnter", "CmdlineEnter" } },
	{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter", "CmdlineEnter" } },
	{ "hrsh7th/vim-vsnip", event = { "InsertEnter", "CmdlineEnter" } },
	{ "hrsh7th/cmp-path", event = { "InsertEnter", "CmdlineEnter" } },
	{ "hrsh7th/cmp-buffer", event = { "InsertEnter", "CmdlineEnter" } },
	{ "hrsh7th/cmp-cmdline", event = { "InsertEnter", "CmdlineEnter" } },
	{ "rinx/cmp-skkeleton", event = { "InsertEnter", "CmdlineEnter" } },
	{ "vim-denops/denops.vim", lazy = false },
	{ "vim-skk/skkeleton", lazy = false, commit = "ce5968d" },
	{ "yuki-yano/fuzzy-motion.vim", lazy = false },
	{ "ggandor/lightspeed.nvim", lazy = false },
	{ "szkny/Ipython", ft = "python" },
	{ "elzr/vim-json", ft = "json" },
	{ "cespare/vim-toml", ft = "toml" },
	{ "hashivim/vim-terraform", ft = "terraform" },
	{ "raimon49/requirements.txt.vim" },
	{ "pearofducks/ansible-vim" },
}

require("lazy").setup(plugins, options)
