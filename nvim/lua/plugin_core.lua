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
    'akinsho/bufferline.nvim',
    'brenoprata10/nvim-highlight-colors',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'lukas-reineke/indent-blankline.nvim',
    'tomasiser/vim-code-dark',
    'tpope/vim-fugitive',
    'stevearc/oil.nvim',
    require('plugin/nvim_tree'),
    'szkny/SplitTerm',
    'neovim/nvim-lspconfig',
    {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    },
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
    'folke/noice.nvim',
    { 'neoclide/coc.nvim' , branch = 'release', lazy = false },
    { 'antoinemadec/coc-fzf', branch = 'release', lazy = false },
    'junegunn/fzf',
    'junegunn/fzf.vim',
    { 'vim-denops/denops.vim', lazy = false },
    { 'yuki-yano/fuzzy-motion.vim', lazy = false },
    { 'vim-skk/skkeleton', lazy = false },
    { 'Shougo/ddc.vim', lazy = false },
    { 'szkny/pum.vim', lazy = false },
    { 'Shougo/ddc-ui-pum', lazy = false },
    { 'Shougo/ddc-source-around', lazy = false },
    { 'LumaKernel/ddc-source-file', lazy = false },
    { 'Shougo/ddc-source-mocword', lazy = false },
    { 'Shougo/ddc-source-cmdline', lazy = false },
    { 'Shougo/ddc-source-cmdline-history', lazy = false },
    { 'Shougo/neco-vim', lazy = false },
    { 'Shougo/ddc-matcher_head', lazy = false },
    { 'Shougo/ddc-converter_remove_overlap', lazy = false },
    { 'tani/ddc-fuzzy', lazy = false },
    { 'szkny/Ipython', ft = 'python' },
    { 'elzr/vim-json', ft = 'json' },
    'raimon49/requirements.txt.vim',
    { 'cespare/vim-toml', ft = 'toml' },
    -- { 'posva/vim-vue', ft = 'vue' },
    'hashivim/vim-terraform',
    'pearofducks/ansible-vim',
    -- { 'mechatroner/rainbow_csv', ft = { 'csv', 'tsv' } },
}

require("lazy").setup(plugins, options)

