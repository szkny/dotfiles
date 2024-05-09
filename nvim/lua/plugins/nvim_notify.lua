return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		-- stages = "fade",
		-- render = "compact",
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
	},
}
