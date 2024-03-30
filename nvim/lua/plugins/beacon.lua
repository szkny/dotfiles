return {
	"danilamihailov/beacon.nvim",
	cmd = {
		"Beacon",
		"BeaconToggle",
		"BeaconOn",
		"BeaconOff",
	},
	event = "VeryLazy",
	config = function()
		-- local kopts = { noremap = true, silent = true }
		-- vim.keymap.set("n", "n", "n<CMD>Beacon<CR>", kopts)
		-- vim.keymap.set("n", "N", "N<CMD>Beacon<CR>", kopts)
		-- vim.keymap.set("n", "*", "*<CMD>Beacon<CR>", kopts)
		-- vim.keymap.set("n", "#", "#<CMD>Beacon<CR>", kopts)

		vim.g.beacon_size = 40
		vim.g.beacon_show_jumps = 1
		vim.g.beacon_shrink = 1
		vim.g.beacon_fade = 1
		vim.g.beacon_timeout = 500
		vim.api.nvim_set_hl(0, "Beacon", { bg = "#77a0ff" })
	end,
}
