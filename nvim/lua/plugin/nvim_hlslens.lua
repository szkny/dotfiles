require("hlslens").setup({
  calm_down = true,
  nearest_only = true,
  nearest_float_when = "auto",
  build_position_cb = function(plist, _, _, _)
    require("scrollbar.handlers.search").handler.show(plist.start_pos)
  end,
})
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
vim.keymap.set(
  "n",
  "<Leader>l",
  "exists(':MinimapUpdateHighlight') ? ':<C-u>set hlsearch!<CR>:MinimapUpdateHighlight<CR>' : ':<C-u>set hlsearch!<CR>'",
  { silent = true, expr = true }
)
vim.api.nvim_set_hl(0, "Search", { fg = "none", bg = "#334f7a" })
vim.api.nvim_set_hl(0, "IncSearch", { fg = "none", bg = "#334f7a" })
vim.api.nvim_set_hl(0, "WildMenu", { fg = "none", bg = "#334f7a" })
vim.api.nvim_set_hl(0, "HlSearchNear", { link = "IncSearch", default = true })
vim.api.nvim_set_hl(0, "HlSearchLens", { fg = "#777777", bg = "none" })
vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = "#777777", bg = "none" })
