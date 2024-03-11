return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    vim.g.barbar_auto_setup = false
    require("barbar").setup({
      animation = true,
      auto_hide = false,
      tabpages = false,
      clickable = true,
      icons = {
        buffer_index = false,
        buffer_number = false,
        button = "",
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.HINT] = { enabled = true, icon = " " },
        },
        gitsigns = {
          added = { enabled = false, icon = "+" },
          changed = { enabled = false, icon = "~" },
          deleted = { enabled = false, icon = "-" },
        },
        filetype = {
          custom_colors = false,
          enabled = true,
        },
        separator = { left = "▎", right = "" },
        separator_at_end = false,
        modified = { button = "●" },
        pinned = { button = "", filename = true },
        preset = "default",
        alternate = { filetype = { enabled = false } },
        current = { buffer_index = false },
        inactive = { button = "×" },
        visible = { modified = { buffer_number = false } },
      },
      highlight_alternate = false,
      highlight_inactive_file_icons = false,
      highlight_visible = true,
      insert_at_end = false,
      insert_at_start = false,
      maximum_padding = 1,
      minimum_padding = 1,
      maximum_length = 60,
      minimum_length = 12,
      sidebar_filetypes = { NvimTree = { text = "   File Explorer" } },
      no_name_title = "[No Name]",
    })
  end,
}
