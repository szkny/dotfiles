return {
	"kevinhwang91/nvim-hlslens",
	tag = "v1.0.0",
	-- lazy = false,
	event = "VeryLazy",
	opts = {
		calm_down = true,
		nearest_only = true,
		nearest_float_when = "auto",
		build_position_cb = function(plist, _, _, _)
			require("scrollbar.handlers.search").handler.show(plist.start_pos)
		end,
	},
	config = function(_, opts)
		require("scrollbar.handlers.search").setup()
		require("hlslens").setup(opts)
		local kopts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.api.nvim_set_keymap(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "<Leader>l", "<CMD>set hlsearch!<CR>", { silent = true })

		vim.api.nvim_set_hl(0, "Search", { fg = "none", bg = "#334f7a" })
		vim.api.nvim_set_hl(0, "IncSearch", { fg = "none", bg = "#334f7a" })
		vim.api.nvim_set_hl(0, "WildMenu", { fg = "none", bg = "#334f7a" })
		vim.api.nvim_set_hl(0, "HlSearchNear", { link = "IncSearch", default = true })
		vim.api.nvim_set_hl(0, "HlSearchLens", { fg = "#777777", bg = "none" })
		vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = "#777777", bg = "none" })
	end,
}
