return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  opts = {
    mappings = {
      "<C-u>",
      "<C-d>",
    },
    hide_cursor = true,
    stop_eof = true,
    respect_scrolloff = true,
    cursor_scrolls_alone = true,
    easing_function = "quadratic",
    performance_mode = false,
  },
}
