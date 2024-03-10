-- 1. LSP Sever management
require("neodev").setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"vimls",
		"jedi_language_server",
		"tsserver",
		"volar",
		"html",
		"jsonls",
		"yamlls",
		"bashls",
		"terraformls",
	},
	automatic_installation = true,
})
require("mason-lspconfig").setup_handlers({
	function(server)
		local opt = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/documentHighlight") then
					vim.api.nvim_create_autocmd(
						{ "CursorHold", "CursorHoldI" },
						{ callback = vim.lsp.buf.document_highlight, buffer = bufnr }
					)
					vim.api.nvim_create_autocmd(
						{ "CursorMoved", "CursorMovedI" },
						{ callback = vim.lsp.buf.clear_references, buffer = bufnr }
					)
				end
				-- vim.api.nvim_create_autocmd({ "CursorHold" }, { callback = vim.diagnostic.open_float, buffer = bufnr })
			end,
			handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			},
		}
		if server == "lua_ls" then
			opt.settings = {
				Lua = {
					diagnostics = { enable = true, globals = { "vim" } },
					completion = {
						callSnippet = "Replace",
					},
				},
			}
		end
		require("lspconfig")[server].setup(opt)
	end,
})

-- formatter
local formatter_on_save = true
require("mason-null-ls").setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"black",
	},
	automatic_installation = true,
})
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.black,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					if formatter_on_save then
						vim.lsp.buf.format({ async = false })
					end
				end,
				buffer = bufnr,
			})
		end
	end,
})
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = false })
end, {})
vim.api.nvim_create_user_command("FormatterEnable", function()
	formatter_on_save = true
end, {})
vim.api.nvim_create_user_command("FormatterDisable", function()
	formatter_on_save = false
end, {})

-- diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<leader>[", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
-- Command
vim.api.nvim_create_user_command("LspCodeAction", function()
	vim.lsp.buf.code_action()
end, { bang = true, nargs = "?" })
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	update_in_insert = false,
	signs = true,
	underline = true,
	virtual_text = {
		prefix = "",
		format = function(diagnostic)
			return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
		end,
	},
})

-- Highlight
vim.api.nvim_set_hl(0, "FloatNormal", { bg = "none", fg = "#9fa3a8" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#9fa3a8" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#252525", fg = "#9fa3af" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#334f7a", fg = "none", bold = true })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#334f7a", fg = "none" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#334f7a", fg = "none" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#334f7a", fg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticError", { bg = "none", fg = "#ee3333" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { bg = "none", fg = "#edd000" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { bg = "none", fg = "#5588dd" })

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "skkeleton" },
	},
	window = {
		completion = {
			border = "rounded",
		},
		documentation = {
			border = "rounded",
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<C-l>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	experimental = {
		ghost_text = true,
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "path" },
		{ name = "cmdline" },
	},
})

-- 4. etc.

-- nvim-navic
local symbol_kind_icons = {
	File = " ",
	Module = " ",
	Namespace = " ",
	Package = " ",
	Class = " ",
	Method = " ",
	Property = " ",
	Field = " ",
	Constructor = " ",
	Enum = " ",
	Interface = " ",
	Function = " ",
	Variable = " ",
	Constant = " ",
	String = " ",
	Number = " ",
	Boolean = " ",
	Array = " ",
	Object = " ",
	Key = " ",
	Null = " ",
	EnumMember = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}
local symbol_kind = {}
for k, _ in pairs(symbol_kind_icons) do
	table.insert(symbol_kind, k)
end
require("nvim-navic").setup({
	icons = symbol_kind_icons,
	lsp = {
		auto_attach = true,
		preference = nil,
	},
	highlight = true,
	separator = " 〉",
	depth_limit = 0,
	depth_limit_indicator = "..",
	safe_output = true,
	lazy_update_context = false,
	click = true,
})
vim.api.nvim_set_hl(0, "NavicIconsFile", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsModule", { bold = false, bg = "none", fg = "#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { bold = false, bg = "none", fg = "#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { bold = false, bg = "none", fg = "#c08855" })
vim.api.nvim_set_hl(0, "NavicIconsClass", { bold = false, bg = "none", fg = "#c08855" })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { bold = false, bg = "none", fg = "#bb9999" })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsField", { bold = false, bg = "none", fg = "#5577bb" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { bold = false, bg = "none", fg = "#bb9999" })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { bold = false, bg = "none", fg = "#bb9999" })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { bold = false, bg = "none", fg = "#5577bb" })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsString", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsArray", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsObject", { bold = false, bg = "none", fg = "#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsKey", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsNull", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { bold = false, bg = "none", fg = "#c08855" })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { bold = false, bg = "none", fg = "#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { bold = false, bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicText", { bold = false, bg = "none", fg = "#888888" })
vim.api.nvim_set_hl(0, "NavicSeparator", { bold = false, bg = "none", fg = "#aaaaaa" })

-- barbeque
require("barbecue").setup({
	create_autocmd = false,
})
vim.api.nvim_create_autocmd({
	"WinScrolled",
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",
	"BufModifiedSet",
}, {
	group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})

-- nvim-navbuddy
require("nvim-navbuddy").setup({
	window = {
		border = "rounded",
		size = "80%",
	},
	icons = symbol_kind_icons,
	lsp = { auto_attach = true },
})

-- aerial.nvim
require("aerial").setup({
	backends = { "treesitter", "lsp", "markdown", "man" },
	layout = {
		max_width = { 40, nil },
		width = nil,
		min_width = 25,
		win_opts = {},
		default_direction = "prefer_right",
		placement = "window",
		resize_to_content = true,
		preserve_equality = false,
	},
	-- filter_kind = symbol_kind,
	filter_kind = {
		"Module",
		"Class",
		"Constructor",
		"Method",
		"Function",
	},
	highlight_mode = "split_width",
	highlight_closest = true,
	highlight_on_hover = false,
	highlight_on_jump = 300,
	icons = symbol_kind_icons,
	show_guides = false,
	update_events = "TextChanged,InsertLeave",
	on_attach = function(bufnr)
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})
vim.keymap.set("n", "<C-t>", "<cmd>AerialToggle!<CR>")
-- vim.keymap.set("n", "<C-t>", function ()
--   local aerial_api = require("aerial")
--   local script_winid
--   if not aerial_api.is_open() then
--     script_winid = vim.fn.win_getid()
--   end
--   aerial_api.toggle({focus = true})
--   if script_winid then
--     -- -- TODO: NvimTreeが開いている場合はNvimTreeの下に配置したい
--     -- local view = require('nvim-tree.view')
--     -- if view.is_visible() then
--     --   local current_win = vim.api.nvim_get_current_win()
--     --   local current_tabpage = vim.api.nvim_win_get_tabpage(current_win)
--     --   local tabpages = vim.api.nvim_list_tabpages()
--     --   for _, tabpage in ipairs(tabpages) do
--     --       if tabpage ~= current_tabpage then
--     --           local win_ids = vim.api.nvim_tabpage_list_wins(tabpage)
--     --           local first_win_id = win_ids[1]
--     --           vim.api.nvim_win_set_config(current_win, {relative='win', win=first_win_id})
--     --           break
--     --       end
--     --   end
--     -- end
--     vim.fn.win_gotoid(script_winid)
--   end
-- end)

-- trouble.nvim
require("trouble").setup({
	position = "bottom",
	height = 5,
	mode = "workspace_diagnostics",
	severity = {
		vim.diagnostic.severity.ERROR,
		vim.diagnostic.severity.WARN,
		vim.diagnostic.severity.HINT,
		vim.diagnostic.severity.INFO,
	},
	icon = true,
	use_diagnostic_signs = false,
})
