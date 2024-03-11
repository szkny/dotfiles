return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    require("neoscroll").setup({
      mappings = {
        "<C-u>",
        "<C-d>",
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = true,
      easing_function = "quadratic",
    })
    require("neoscroll.config").set_mappings({
      ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "300" } },
      ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "300" } },
    })
  end,
}
