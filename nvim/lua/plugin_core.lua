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
		-- TODO: WIP lazy load setup
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		-- keys = {
		-- 	{ "<Leader>gb", require("gitsigns").toggle_current_line_blame, mode = "n" },
		-- },
		dependencies = {
			"petertriho/nvim-scrollbar",
		},
		-- config = function()
		-- 	require("plugin.gitsigns")
		-- end,
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
			vim.keymap.set("v", "<Leader>=", "<CMD>EasyAlign *=<CR>", { noremap = true, silent = true })
			vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)", { noremap = true, silent = true })
		end,
	},
	{
		-- TODO: WIP lazy load setup
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
	{
		"liuchengxu/vista.vim",
		cmd = "Vista",
		keys = {
			-- { "<C-t>", "<CMD>Vista!!<CR>", mode = "n" },
			{ "<C-g>", "<CMD>Vista finder<CR>", mode = "n" },
		},
		config = function()
			require("plugin.vista")
		end,
	},
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{
		"nvim-lualine/lualine.nvim",
		-- event = "VeryLazy",
		event = "VimEnter",
		config = function()
			require("plugin.lualine")
		end,
	},
	{
		"wfxr/minimap.vim",
		cmd = "MinimapToggle",
		dependencies = {
			"petertriho/nvim-scrollbar",
		},
		config = function()
			require("plugin.minimap")
		end,
	},
	-- { 'mg979/vim-visual-multi' },
	{
		-- TODO: WIP lazy load setup
		"petertriho/nvim-scrollbar",
		dependencies = {
			"kevinhwang91/nvim-hlslens",
			"lewis6991/gitsigns.nvim",
		},
		-- lazy = false,
		-- event = "VeryLazy",
		-- opt = require("plugin.nvim_scrollbar"),
		-- config = function()
		-- 	require("plugin.nvim_scrollbar")
		-- end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin.neoscroll")
		end,
	},
	{
		-- TODO: WIP lazy load setup
		"romgrk/barbar.nvim",
		-- lazy = false,
		-- config = function()
		-- 	require("plugin.barbar")
		-- end,
	},
	{
		-- TODO: WIP lazy load setup
		"brenoprata10/nvim-highlight-colors",
		-- lazy = false,
		-- event = "VeryLazy",
		-- opt = require("plugin.nvim_highlight_colors"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		-- evnet = "VeryLazy",
		config = function()
			require("plugin.nvim_treesitter")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.8",
		event = "VeryLazy",
		config = function()
			require("plugin.indent_blankline")
		end,
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("plugin.auto-session")
		end,
	},
	{ "Mofiqul/vscode.nvim" },
	{
		"stevearc/oil.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin.oil")
		end,
	},
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
	{
		"szkny/SplitTerm",
		cmd = "SplitTerm",
		keys = {
			{ "t", "<CMD>18SplitTerm<CR>i", mode = "n" },
			{ "<leader>gg", "<CMD>SplitTerm lazygit<CR><C-w>J:res 1000<CR>i<CR>", mode = "n" },
		},
		event = "VeryLazy",
		config = function()
			require("plugin.splitterm")
		end,
	},
	{
		"junegunn/fzf",
		dependencies = { "junegunn/fzf.vim" },
		cmd = { "FZF" },
	},
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		event = "VeryLazy",
		config = function()
			require("plugin.fzf")
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("plugin.nvim_notify")
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VeryLazy",
		config = function()
			require("plugin.noice")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		config = function()
			require("which-key").setup({})
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
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
	},
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
