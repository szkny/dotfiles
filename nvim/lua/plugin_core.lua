-- *****************************************************************************
--   Plugin manager core
-- *****************************************************************************
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
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
  }
}
local plugins = {
  { 'nvim-tree/nvim-web-devicons' },
  { 'numToStr/Comment.nvim' },
  { 'kevinhwang91/rnvimr', cmd = 'RnvimrToggle' },
  { 'tpope/vim-fugitive', lazy = false },
  { 'lewis6991/gitsigns.nvim' },
  { 'rbong/vim-flog', cmd = 'Flog' },
  { 'windwp/nvim-autopairs', event = 'InsertEnter' },
  { 'junegunn/vim-easy-align', lazy = false },
  { 'kevinhwang91/nvim-hlslens' },
  { 'folke/which-key.nvim', event = 'VeryLazy', init = function() vim.o.timeout = true vim.o.timeoutlen = 500 end },
  { 'liuchengxu/vista.vim', cmd = 'Vista' },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'nvim-lualine/lualine.nvim' },
  { 'wfxr/minimap.vim', cmd = 'MinimapToggle' },
  -- { 'mg979/vim-visual-multi' },
  { 'petertriho/nvim-scrollbar' },
  { 'karb94/neoscroll.nvim', lazy = false },
  { 'romgrk/barbar.nvim' },
  { 'brenoprata10/nvim-highlight-colors' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'lukas-reineke/indent-blankline.nvim', tag = 'v2.20.8' },
  { 'rmagatti/auto-session' },
  { 'Mofiqul/vscode.nvim' },
  { 'stevearc/oil.nvim' },
  require('plugin/nvim_tree'),
  { 'szkny/SplitTerm', lazy = false },
  { 'junegunn/fzf', lazy = false},
  { 'junegunn/fzf.vim', lazy = false},
  { 'MunifTanjim/nui.nvim' },
  { 'rcarriga/nvim-notify' },
  { 'folke/noice.nvim' },
  { 'neovim/nvim-lspconfig', lazy = false },
  { 'williamboman/mason.nvim', lazy = false },
  { 'williamboman/mason-lspconfig.nvim', lazy = false },
  { 'SmiteshP/nvim-navic', lazy = false},
  { 'SmiteshP/nvim-navbuddy', lazy = false },
  { 'utilyre/barbecue.nvim', lazy = false },
  { 'simrat39/symbols-outline.nvim', lazy = false },
  { 'hrsh7th/nvim-cmp', lazy = false },
  { 'hrsh7th/cmp-nvim-lsp', lazy = false },
  { 'hrsh7th/vim-vsnip', lazy = false },
  { 'hrsh7th/cmp-path', lazy = false },
  { 'hrsh7th/cmp-buffer', lazy = false },
  { 'hrsh7th/cmp-cmdline', lazy = false },
  { 'rinx/cmp-skkeleton', lazy = false },
  { 'vim-denops/denops.vim', lazy = false },
  { 'vim-skk/skkeleton', lazy = false, commit = 'ce5968d' },
  { 'yuki-yano/fuzzy-motion.vim', lazy = false },
  { 'ggandor/lightspeed.nvim', lazy = false},
  { 'szkny/Ipython', ft = 'python' },
  { 'elzr/vim-json', ft = 'json' },
  { 'raimon49/requirements.txt.vim' },
  { 'cespare/vim-toml', ft = 'toml' },
  { 'hashivim/vim-terraform' },
  { 'pearofducks/ansible-vim' },
}

require('lazy').setup(plugins, options)
