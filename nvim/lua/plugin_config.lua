-- *****************************************************************************
--   Plugin Configuration
-- *****************************************************************************

-- nvim-notify
--   stages = "fade_in_slide_out",
--   stages = "fade",
--   render = "default",
--   render = "compact",
require("notify").setup({
	stages = "fade_in_slide_out",
	render = "default",
	background_colour = "#252525",
	timeout = 3000,
	max_width = 80,
	minimum_width = 50,
	top_down = false,
	fps = 60,
	icons = {
		ERROR = " ",
		WARN = " ",
		INFO = " ",
		DEBUG = " ",
		TRACE = "✎ ",
	},
})
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#8a1f1f", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#79491d", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#4f6752", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#8b8b8b", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#4f3552", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = "#f70067", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = "#f79000", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#a9ff68", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = "#8b8b8b", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = "#d484ff", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#f70067", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#F79000", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#A9FF68", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#8B8B8B", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#D484FF", bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = "none", bg = "#252525" })
vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = "none", bg = "#252525" })

-- noice.nvim
require("noice").setup({
	messages = {
		enabled = true,
		view = "notify",
		view_error = "notify",
		view_warn = "notify",
		view_history = "messages",
		view_search = "mini",
	},
	cmdline = {
		enabled = true,
		view = "cmdline",
		format = {
			cmdline = { pattern = "^:", icon = "", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "zsh" },
			lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
		},
	},
	presets = {
		bottom_search = false,
		command_palette = false,
		long_message_to_split = true,
	},
})
vim.api.nvim_set_hl(0, "NoiceMini", { fg = "#ffbb00", bg = "#383838" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = "none", bg = "#383838" })
vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = "none", bg = "#1f1f1f" })
vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = "none", bg = "#383838" })

-- which-key.nvim
require("which-key").setup({})

-- fzf.vim
vim.api.nvim_set_var("wildmode", "list:longest,list:full")
vim.api.nvim_set_var("wildignore", "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__")
vim.api.nvim_set_var("$FZF_DEFAULT_OPTS", "--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up")
vim.api.nvim_set_var("fzf_layout", { window = { width = 1.00, height = 0.98, yoffset = 1.00 } })
vim.api.nvim_set_var("fzf_preview_window", { "right,50%,<70(down,60%)", "ctrl-/" })
vim.api.nvim_set_var("fzf_colors", {
	fg = { "fg", "FzfNormal" },
	bg = { "bg", "FzfNormal" },
	["fg+"] = { "fg", "FzfCursorLine" },
	["bg+"] = { "bg", "FzfCursorLine" },
	["preview-fg"] = { "fg", "FzfPreview" },
	["preview-bg"] = { "bg", "FzfPreview" },
})
vim.api.nvim_create_user_command(
	"Files",
	"call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)",
	{ bang = true, nargs = "?" }
)
vim.api.nvim_set_hl(0, "FzfNormal", { fg = "none", bg = "#2a2a2a" })
vim.api.nvim_set_hl(0, "FzfCursorLine", { fg = "#ffffff", bg = "#5e5e5e" })
vim.api.nvim_set_hl(0, "FzfPreview", { fg = "none", bg = "none" })
-- fzf.vim for Silver Searcher
if vim.fn.executable("ag") then
	vim.api.nvim_set_var("$FZF_DEFAULT_COMMAND", 'ag --hidden --ignore .git -g ""')
	vim.opt.grepprg = "ag --nogroup --nocolor"
end
-- fzf.vim for RipGrep
if vim.fn.executable("rg") then
	vim.api.nvim_set_var("$FZF_DEFAULT_COMMAND", 'rg --files --hidden --follow --glob "!.git/*"')
	vim.opt.grepprg = "rg --vimgrep"
	vim.api.nvim_create_user_command(
		"Find",
		'call fzf#vim#grep(\'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" \'.shellescape(<q-args>).\'| tr -d "\\017"\', 1, <bang>0)',
		{ bang = true, nargs = "*" }
	)
	vim.api.nvim_create_user_command(
		"Files",
		"call fzf#run(fzf#wrap(#{source: 'rg --files -uuu -g !.git/ -g !node_modules/ -L', options: '--preview-window \"nohidden,wrap,down,60%\" --preview \"[ -f {} ] && bat --color=always --style=numbers {} || echo {}\"'}))",
		{ bang = true, nargs = "?" }
	)
end

-- skkeleton
vim.cmd([[
"" skkeleton
fun! s:skkeleton_init() abort
    call skkeleton#config(#{
      \ globalJisyo: '~/.skk/SKK-JISYO.L',
      \ kanaTable: 'rom',
      \ eggLikeNewline: v:true,
      \ showCandidatesCount: 10,
      \ usePopup: v:false,
      \ registerConvertResult: v:true,
      \ acceptIllegalResult: v:true,
      \ keepState: v:false,
      \ })
    call skkeleton#register_kanatable('rom', {
      \ "z\<Space>": ["\u3000", ''],
      \ })
    call add(g:skkeleton#mapped_keys, '<C-h>')
    call add(g:skkeleton#mapped_keys, '<F6>')
    call add(g:skkeleton#mapped_keys, '<F7>')
    call add(g:skkeleton#mapped_keys, '<F8>')
    call add(g:skkeleton#mapped_keys, '<F9>')
    call add(g:skkeleton#mapped_keys, '<F10>')
    call add(g:skkeleton#mapped_keys, '<C-k>')
    call add(g:skkeleton#mapped_keys, '<C-q>')
    call add(g:skkeleton#mapped_keys, '<C-a>')
    call skkeleton#register_keymap('input', '<C-h>', '')
    call skkeleton#register_keymap('input', '<Up>', '')
    call skkeleton#register_keymap('input', '<Down>', '')
    call skkeleton#register_keymap('input', '<F6>',  'katakana')
    call skkeleton#register_keymap('input', '<F7>',  'katakana')
    call skkeleton#register_keymap('input', '<F8>',  'hankatakana')
    call skkeleton#register_keymap('input', '<F9>',  'zenkaku')
    call skkeleton#register_keymap('input', '<F10>', 'disable')
    call skkeleton#register_keymap('input', '<C-k>', 'katakana')
        call skkeleton#register_keymap('input', '<C-q>', 'hankatakana')
        call skkeleton#register_keymap('input', '<C-a>', 'zenkaku')
endf
aug skkeleton-initialize-pre
  au!
  au User skkeleton-initialize-pre call s:skkeleton_init()
aug END
aug skkeleton-mode-changed
  au!
  au User skkeleton-mode-changed redrawstatus
aug END
]])

-- oil.nvim
require("oil").setup({
	columns = {
		"permissions",
		"size",
		"mtime",
		"icon",
	},
	buf_options = {
		buflisted = false,
		bufhidden = "hide",
	},
	win_options = {
		wrap = false,
		signcolumn = "no",
		cursorcolumn = false,
		foldcolumn = "0",
		spell = false,
		list = false,
		conceallevel = 3,
		concealcursor = "n",
	},
	default_file_explorer = true,
	trash_command = "rip",
	use_default_keymaps = false,
	keymaps = {
		["?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<2-LeftMouse>"] = "actions.select",
		["<C-l>"] = "actions.select",
		["<C-h>"] = "actions.parent",
		["W"] = "actions.open_cwd",
		["<Tab>"] = "actions.preview",
		["q"] = "actions.close",
		["R"] = "actions.refresh",
		["H"] = "actions.toggle_hidden",
		["I"] = "actions.toggle_hidden",
		["<BS>"] = "actions.toggle_hidden",
	},
})
vim.cmd([[
    fun! s:oil_init() abort
        setlocal nonumber
        setlocal nobuflisted
        setlocal nolist
        setlocal nospell
        setlocal noequalalways
        " vertical resize 25
    endf
    au FileType oil call s:oil_init()
]])
vim.api.nvim_set_hl(0, "OilFile", { fg = "#bbbbbb", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "OilDir", { fg = "#77aadd", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "OilLink", { fg = "#77afaf", bg = "none", bold = true })

-- barbar.nvim
require("plugin.barbar")

-- gitsigns
require("plugin.gitsigns")

-- nvim-scrollbar
require("plugin.nvim_scrollbar")

-- nvim-hlslens
require("plugin.nvim_hlslens")

-- lightspeed.nvim
require("lightspeed").setup({
	ignore_case = false,
	exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
	limit_ft_matches = 4,
	repeat_ft_with_target_char = false,
})
vim.api.nvim_set_hl(0, "LightspeedOneCharMatch", { fg = "#ff3377", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "LightspeedCursor", { fg = "none", bg = "none", bold = true })

-- fuzzy-motion.vim
vim.g.fuzzy_motion_auto_jump = true
vim.api.nvim_set_hl(0, "FuzzyMotionShade", { fg = "#666666", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionChar", { fg = "#eeeeee", bg = "#ff3377", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionSubChar", { fg = "#eeeeee", bg = "#ff3377", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionMatch", { fg = "#66bbee", bg = "none", bold = true })

--  visual-multi  " TODO
vim.cmd([[
    let g:VM_default_mappings = 0
    let g:VM_maps = {}
    let g:VM_maps['Find Under']         = '<C-d>'      " replace C-n
    let g:VM_maps['Find Subword Under'] = '<C-d>'      " replace visual C-n
    let g:VM_maps["Select Cursor Down"] = '<M-C-Down>' " start selecting down
    let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'   " start selecting up
]])

-- nvim-highlight-colors
require("plugin.nvim_highlight_colors")
