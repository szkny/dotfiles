return {
  "yuki-yano/fuzzy-motion.vim",
  dependencies = { "vim-denops/denops.vim" },
  keys = {
    { "<Leader>f", "<CMD>silent FuzzyMotion<CR>", mode = "n" },
    { "s",         "<CMD>silent FuzzyMotion<CR>", mode = "n" },
  },
  config = function()
    vim.g.fuzzy_motion_auto_jump = true
    vim.api.nvim_set_hl(0, "FuzzyMotionShade", { fg = "#666666", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "FuzzyMotionChar", { fg = "#eeeeee", bg = "#ff3377", bold = true })
    vim.api.nvim_set_hl(0, "FuzzyMotionSubChar", { fg = "#eeeeee", bg = "#ff3377", bold = true })
    vim.api.nvim_set_hl(0, "FuzzyMotionMatch", { fg = "#66bbee", bg = "none", bold = true })
  end,
}
