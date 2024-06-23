return {
	"danilamihailov/beacon.nvim",
	event = "VeryLazy",
	opts = {
		enabled = true,
		speed = 2,
		width = 50,
		winblend = 70,
		fps = 60,
		min_jump = 5,
		cursor_events = { "CursorMoved" },
		window_events = { "WinEnter", "FocusGained" },
		highlight = { bg = "#77a0ff" },
	},
}
