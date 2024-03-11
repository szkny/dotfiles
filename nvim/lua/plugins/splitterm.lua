return {
  "szkny/SplitTerm",
  cmd = "SplitTerm",
  keys = {
    { "t",          "<CMD>18SplitTerm<CR>i",                              mode = "n" },
    { "<leader>gg", "<CMD>SplitTerm lazygit<CR><C-w>J:res 1000<CR>i<CR>", mode = "n" },
  },
  event = "VeryLazy",
  config = function()
    vim.api.nvim_set_var("splitterm_auto_close_window", 1)
  end,
}
