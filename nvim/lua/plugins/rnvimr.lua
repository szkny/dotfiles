return {
	"kevinhwang91/rnvimr",
	cmd = "RnvimrToggle",
	keys = {
		{ "<C-h>", "<CMD>RnvimrToggle<CR>", mode = "n" },
	},
	config = function()
		vim.g.rnvimr_enable_picker = 1
		vim.g.rnvimr_draw_border = 1
		vim.cmd([[
      let g:rnvimr_layout = {
        \ 'relative': 'editor',
        \ 'width':  float2nr(round(0.90 * &columns)),
        \ 'height': float2nr(round(0.90 * &lines)),
        \ 'col':    float2nr(round(0.05 * &columns)),
        \ 'row':    float2nr(round(0.05 * &lines)),
        \ 'style': 'minimal'
        \ }
    ]])
		vim.api.nvim_set_hl(0, "RnvimrCurses", { fg = "#555555", bg = "none" })
	end,
}
