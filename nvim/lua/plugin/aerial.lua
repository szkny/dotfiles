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
	icons = {
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
	},
	show_guides = false,
	update_events = "TextChanged,InsertLeave",
	on_attach = function(bufnr)
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})
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
