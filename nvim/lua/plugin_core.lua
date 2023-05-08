-- *****************************************************************************
--   Plugin manager core
-- *****************************************************************************
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- *****************************************************************************
--   Install plugins
-- *****************************************************************************
plugins = {
    'tomtom/tcomment_vim',
    'kevinhwang91/rnvimr',
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    'rbong/vim-flog',
    'Raimondi/delimitMate',
    'szkny/SplitTerm',
    'junegunn/vim-easy-align',
    'kevinhwang91/nvim-hlslens',
    'liuchengxu/vista.vim',
    'dstein64/vim-startuptime',
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
    'wfxr/minimap.vim',
    'petertriho/nvim-scrollbar',
    'akinsho/bufferline.nvim',
    { 'rrethy/vim-hexokinase', build = 'make hexokinase' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'lukas-reineke/indent-blankline.nvim',
    'tomasiser/vim-code-dark',
    'tpope/vim-fugitive',
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'szkny/SplitTerm',
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
    'folke/noice.nvim',
    'junegunn/fzf',
    'junegunn/fzf.vim',
    'vim-denops/denops.vim',
    'vim-skk/skkeleton',
    { 'neoclide/coc.nvim' , branch = 'release' },
    'antoinemadec/coc-fzf',
    'Shougo/ddc.vim',
    'szkny/pum.vim',
    'Shougo/ddc-ui-pum',
    'Shougo/ddc-source-around',
    'LumaKernel/ddc-source-file',
    'Shougo/ddc-source-mocword',
    'Shougo/ddc-source-cmdline',
    'Shougo/ddc-source-cmdline-history',
    'Shougo/neco-vim',
    'Shougo/ddc-matcher_head',
    'Shougo/ddc-converter_remove_overlap',
    'tani/ddc-fuzzy',
    { 'szkny/Ipython', ft = 'python' },
    'elzr/vim-json',
    'raimon49/requirements.txt.vim',
    'cespare/vim-toml',
    'posva/vim-vue',
    'hashivim/vim-terraform',
    'pearofducks/ansible-vim',
}

require("lazy").setup(plugins)

