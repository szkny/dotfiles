return {
  "junegunn/vim-easy-align",
  event = "VeryLazy",
  config = function()
    vim.g.easy_align_ignore_groups = { "String" }
    vim.keymap.set("v", "<Leader>=", "<CMD>EasyAlign *=<CR>", { noremap = true, silent = true })
    vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)", { noremap = true, silent = true })
  end,
}
