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

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader>o", require("oil").open_float, opts)
vim.keymap.set("n", "<Leader>t", require("util").oil_ssh_term, opts)
