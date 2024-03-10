-- *****************************************************************************
--   Ignore default plugins
-- *****************************************************************************
vim.api.nvim_set_var("did_install_default_menus", 1)
vim.api.nvim_set_var("did_install_syntax_menu", 1)
vim.api.nvim_set_var("did_indent_on", 1)
-- vim.api.nvim_set_var('did_load_filetypes', 1)
vim.api.nvim_set_var("did_load_ftplugin", 1)
vim.api.nvim_set_var("loaded_2html_plugin", 1)
vim.api.nvim_set_var("loaded_gzip", 1)
vim.api.nvim_set_var("loaded_man", 1)
vim.api.nvim_set_var("loaded_matchit", 1)
vim.api.nvim_set_var("loaded_matchparen", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)
vim.api.nvim_set_var("loaded_remote_plugins", 1)
vim.api.nvim_set_var("loaded_shada_plugin", 1)
vim.api.nvim_set_var("loaded_spellfile_plugin", 1)
vim.api.nvim_set_var("loaded_tarPlugin", 1)
vim.api.nvim_set_var("loaded_tutor_mode_plugin", 1)
vim.api.nvim_set_var("loaded_zipPlugin", 1)
vim.api.nvim_set_var("skip_loading_mswin", 1)

-- *****************************************************************************
--   Basic Setup
-- *****************************************************************************"
-- Encoding
-- vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"
vim.opt.fileformats = "unix,dos,mac"
vim.opt.bomb = true
vim.opt.binary = true

-- Fix backspace indent
vim.opt.backspace = "indent,eol,start"

-- filetype detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- Tabs. May be overriten by autocmd rules
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable hidden buffers
vim.opt.hidden = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"

-- completion
vim.opt.complete:remove("t")

-- Copy/Paste/Cut
if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd({ "TextYankPost" }, {
		pattern = "*",
		command = ":call system('clip.exe', @\")",
	})
else
	vim.opt.clipboard:append({ unnamedplus = true })
end

-- Directories for swp files
vim.opt.backup = false
vim.opt.swapfile = false

-- Time (msec)
vim.opt.ttimeoutlen = 0
vim.opt.updatetime = 250

-- etc..
vim.opt.shell = os.getenv("SHELL") or "/bin/sh"
vim.opt.autoread = true
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"
vim.opt.mouse = "a"
vim.opt.smartindent = true
vim.opt.wildmenu = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.virtualedit = "onemore"
vim.opt.foldmethod = "manual"
vim.opt.lazyredraw = false

-- netrw
vim.api.nvim_set_var("netrw_liststyle", 3)
vim.api.nvim_set_var("netrw_banner", 0)
vim.api.nvim_set_var("netrw_sizestyle", "H")
vim.api.nvim_set_var("netrw_timefmt", "%Y/%m/%d(%a) %H:%M:%S")

-- Session Management
vim.api.nvim_set_var("session_directory", "~/.config/nvim/session")
vim.api.nvim_set_var("session_autoload", "no")
vim.api.nvim_set_var("session_autosave", "no")
vim.api.nvim_set_var("session_command_aliases", 1)

-- Python Host Program
vim.g.python_host_prog = "~/.local/share/mise/shims/python2"
vim.g.python3_host_prog = "~/.local/share/mise/shims/python3"

-- conceal level
vim.api.nvim_set_var("conceallevel", 0)
vim.api.nvim_set_var("vim_json_syntax_conceal", 0)

-- *****************************************************************************
--   Visual Settings
-- *****************************************************************************
vim.opt.ruler = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.pumblend = 20
vim.opt.winblend = 20

vim.api.nvim_set_var("no_buffers_menu", 1)

vim.opt.mousemodel = "popup"
-- set t_Co=256
vim.opt.termguicolors = true

-- Change cursor by mode
vim.opt.guicursor = "n-v-c:block-Cursor,i:ver100-iCursor,n-v-c:blinkon0,i:blinkwait10"
-- if &term =~ '^xterm'
--     " normal mode
--     let &t_EI .= "\<Esc>[0 q"
--     " insert mode
--     let &t_SI .= "\<Esc>[6 q"
-- endif

vim.opt.scrolloff = 3

-- Status bar
vim.opt.laststatus = 3
vim.opt.showtabline = 1
vim.opt.showmode = false

-- Use modeline overrides
vim.opt.modeline = true
vim.opt.modelines = 10

vim.api.nvim_set_var("enable_bold_font", 1)
vim.api.nvim_set_var("enable_italic_font", 1)
vim.api.nvim_set_var("cpp_class_scope_highlight", 1)

vim.opt.list = true
vim.opt.listchars = "tab:¦ ,trail:-,eol:↲"
vim.opt.fillchars = "vert:│,eob: "
vim.opt.signcolumn = "yes"
vim.opt.cursorcolumn = false
vim.opt.cursorline = true

-- *****************************************************************************
--   Abbreviations
-- *****************************************************************************
-- no one is really happy until you have this shortcuts
vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]])

-- *****************************************************************************
--   Include user's local vim config
-- *****************************************************************************
-- vim.api.nvim_command('set runtimepath+=~/.config/nvim')
-- vim.api.nvim_command('ru! vimrc/*.vim')
-- command! Vimrc silent e ~/dotfiles/nvim
-- command! Reload silent source ~/.config/nvim/init.vim
