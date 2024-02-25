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
  { "nvim-tree/nvim-web-devicons" },
  { "numToStr/Comment.nvim" },
  { "kevinhwang91/rnvimr",                 cmd = "RnvimrToggle" },
  { "tpope/vim-fugitive",                  event = "CmdlineEnter" },
  { "lewis6991/gitsigns.nvim" },
  { "rbong/vim-flog",                      cmd = "Flog" },
  { "windwp/nvim-autopairs",               event = "InsertEnter" },
  { "junegunn/vim-easy-align",             lazy = false },
  { "kevinhwang91/nvim-hlslens" },
  { "liuchengxu/vista.vim",                cmd = "Vista" },
  { "dstein64/vim-startuptime",            cmd = "StartupTime" },
  { "nvim-lualine/lualine.nvim" },
  { "wfxr/minimap.vim",                    cmd = "MinimapToggle" },
  -- { 'mg979/vim-visual-multi' },
  { "petertriho/nvim-scrollbar" },
  { "karb94/neoscroll.nvim" },
  { "romgrk/barbar.nvim" },
  { "brenoprata10/nvim-highlight-colors" },
  { "nvim-treesitter/nvim-treesitter",     build = ":TSUpdate" },
  { "lukas-reineke/indent-blankline.nvim", tag = "v2.20.8" },
  { "rmagatti/auto-session" },
  { "Mofiqul/vscode.nvim" },
  { "stevearc/oil.nvim" },
  require("plugin/nvim_tree"),
  { "szkny/SplitTerm",     cmd = "SplitTerm" },
  { "junegunn/fzf",        lazy = false },
  { "junegunn/fzf.vim",    lazy = false },
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
  { "SmiteshP/nvim-navic",           lazy = false },
  { "SmiteshP/nvim-navbuddy",        lazy = false },
  { "utilyre/barbecue.nvim" },
  { "stevearc/aerial.nvim" },
  { "hrsh7th/nvim-cmp",              event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/cmp-nvim-lsp",          event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/vim-vsnip",             event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/cmp-path",              event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/cmp-buffer",            event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/cmp-cmdline",           event = { "InsertEnter", "CmdlineEnter" } },
  { "rinx/cmp-skkeleton",            event = { "InsertEnter", "CmdlineEnter" } },
  { "vim-denops/denops.vim",         lazy = false },
  { "vim-skk/skkeleton",             lazy = false,                             commit = "ce5968d" },
  { "yuki-yano/fuzzy-motion.vim",    lazy = false },
  { "ggandor/lightspeed.nvim",       lazy = false },
  { "szkny/Ipython",                 ft = "python" },
  { "elzr/vim-json",                 ft = "json" },
  { "raimon49/requirements.txt.vim", ft = "requirements" },
  { "cespare/vim-toml",              ft = "toml" },
  { "hashivim/vim-terraform",        ft = "terraform" },
  { "pearofducks/ansible-vim" },
}

require("lazy").setup(plugins, options)
