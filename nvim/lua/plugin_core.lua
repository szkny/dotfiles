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
options = {
    defaults = {
        lazy = false,
    }
}
plugins = {
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
    'liuchengxu/vista.vim',
    { 'dstein64/vim-startuptime', cmd = 'StartupTime', lazy = false },
    'nvim-lualine/lualine.nvim',
    'wfxr/minimap.vim',
    'petertriho/nvim-scrollbar',
    'akinsho/bufferline.nvim',
    'norcalli/nvim-colorizer.lua',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'lukas-reineke/indent-blankline.nvim',
    'tomasiser/vim-code-dark',
    'tpope/vim-fugitive',
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy = true,
        cmd = { "NvimTreeToggle" },
        keys = {
          { "<C-n>", "<CMD>NvimTreeToggle<CR>", mode = "n" },
        },
        config = function()
            require("nvim-tree").setup({
              auto_reload_on_write = true,
              disable_netrw = true,
              hijack_cursor = true,
              hijack_netrw = true,
              sort_by = "case_sensitive",
              view = {
                adaptive_size = true,
                width = 25,
                signcolumn = "yes",
                preserve_window_proportions = true,
              },
              renderer = {
                group_empty = true,
                highlight_git = true,
                highlight_modified = "name",
                full_name = false,
                root_folder_label = false,
                indent_width = 2,
                indent_markers = {
                  enable = true,
                  inline_arrows = true,
                  icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                  },
                },
                icons = {
                  git_placement = "before",
                  modified_placement = "after",
                  padding = " ",
                  symlink_arrow = " → ",
                  glyphs = {
                    git = {
                      unstaged = "M",
                      staged = "✓",
                      unmerged = "✗",
                      renamed = "R",
                      untracked = "U",
                      deleted = "D",
                      ignored = "◌",
                    },
                  },
                },
                special_files = { "Makefile", "README.md" },
              },
              update_focused_file = {
                enable = true,
              },
              diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
                debounce_delay = 50,
                severity = {
                  min = vim.diagnostic.severity.HINT,
                  max = vim.diagnostic.severity.ERROR,
                },
                icons = {
                  hint = "",
                  info = "",
                  warning = "",
                  error = "",
                },
              },
              filters = {
                dotfiles = true,
              },
              git = {
                enable = true,
                ignore = false,
                show_on_dirs = true,
                show_on_open_dirs = false,
              },
              modified = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
              },
              trash = {
                cmd = "rip",
                require_confirm = true,
              },
              on_attach = function(bufnr)
                local api = require('nvim-tree.api')
                local opts = function(desc)
                  return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set('n', '?',             api.tree.toggle_help,           opts('Help'))
                vim.keymap.set('n', 'H',             api.tree.toggle_hidden_filter,  opts('Toggle Dotfiles'))
                vim.keymap.set('n', 'I',             api.tree.toggle_hidden_filter,  opts('Toggle Ignore'))
                vim.keymap.set('n', '<BS>',          api.tree.toggle_hidden_filter,  opts('Toggle Dotfiles'))
                vim.keymap.set('n', '<C-h>',         api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', '<C-l>',         api.tree.change_root_to_node,   opts('Cd'))
                vim.keymap.set('n', '<Tab>',         api.node.open.preview,          opts('Open Preview'))
                vim.keymap.set('n', '<C-f>',         api.live_filter.start,          opts('Filter'))
                vim.keymap.set('n', 'o',             api.node.open.edit,             opts('Open'))
                vim.keymap.set('n', 'O',             api.tree.expand_all,            opts('Expand All'))
                vim.keymap.set('n', 'W',             api.tree.collapse_all,          opts('Collapse'))
                vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit,             opts('Open'))
            end,
            })
        end,
    },
    'szkny/SplitTerm',
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
    'folke/noice.nvim',
    'junegunn/fzf',
    'junegunn/fzf.vim',
    'vim-denops/denops.vim',
    'vim-skk/skkeleton',
    { 'neoclide/coc.nvim' , branch = 'release' },
    { 'antoinemadec/coc-fzf', branch = 'release' },
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
    { 'elzr/vim-json', ft = 'json' },
    'raimon49/requirements.txt.vim',
    { 'cespare/vim-toml', ft = 'toml' },
    { 'posva/vim-vue', ft = 'vue' },
    'hashivim/vim-terraform',
    'pearofducks/ansible-vim',
    { 'mechatroner/rainbow_csv', ft = { 'csv', 'tsv' } },
}

require("lazy").setup(plugins, options)

