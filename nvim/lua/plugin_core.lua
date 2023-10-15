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
    lazy = false,
  }
}
local plugins = {
  'nvim-tree/nvim-web-devicons',
  'numToStr/Comment.nvim',
  'kevinhwang91/rnvimr',
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',
  'rbong/vim-flog',
  'Raimondi/delimitMate',
  'szkny/SplitTerm',
  'junegunn/vim-easy-align',
  'kevinhwang91/nvim-hlslens',
  { 'liuchengxu/vista.vim', lazy = false },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime', lazy = false },
  'nvim-lualine/lualine.nvim',
  'wfxr/minimap.vim',
  -- 'mg979/vim-visual-multi',
  'petertriho/nvim-scrollbar',
  'romgrk/barbar.nvim',
  'brenoprata10/nvim-highlight-colors',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'lukas-reineke/indent-blankline.nvim', tag = 'v2.20.8' },
  'Mofiqul/vscode.nvim',
  'stevearc/oil.nvim',
  require('plugin/nvim_tree'),
  'szkny/SplitTerm',
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'MunifTanjim/nui.nvim',
  'rcarriga/nvim-notify',
  'folke/noice.nvim',
  { 'neovim/nvim-lspconfig', lazy = false },
  { 'williamboman/mason.nvim', lazy = false },
  { 'williamboman/mason-lspconfig.nvim', lazy = false },
  { 'SmiteshP/nvim-navic', lazy = false},
  { 'SmiteshP/nvim-navbuddy', lazy = false },
  { 'simrat39/symbols-outline.nvim', lazy = false },
  { "hrsh7th/nvim-cmp", lazy = false },
  { "hrsh7th/cmp-nvim-lsp", lazy = false },
  { "hrsh7th/vim-vsnip", lazy = false },
  { "hrsh7th/cmp-path", lazy = false },
  { "hrsh7th/cmp-buffer", lazy = false },
  { "hrsh7th/cmp-cmdline", lazy = false },
  { "rinx/cmp-skkeleton", lazy = false },
  { 'vim-denops/denops.vim', lazy = false },
  { 'vim-skk/skkeleton', lazy = false },
  { 'yuki-yano/fuzzy-motion.vim', lazy = false },
  { 'szkny/Ipython', ft = 'python' },
  { 'elzr/vim-json', ft = 'json' },
  'raimon49/requirements.txt.vim',
  { 'cespare/vim-toml', ft = 'toml' },
  'hashivim/vim-terraform',
  'pearofducks/ansible-vim',
}

require("lazy").setup(plugins, options)

