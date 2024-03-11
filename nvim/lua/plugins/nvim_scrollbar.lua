-- TODO: WIP lazy load setup
return {
  "petertriho/nvim-scrollbar",
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  event = "VeryLazy",
  config = function()
    require("scrollbar").setup({
      show = true,
      show_in_active_only = true,
      set_highlights = true,
      max_lines = false,
      hide_if_all_visible = true,
      handle = {
        text = " ",
        highlight = "CursorColumn",
        hide_if_all_visible = true,
      },
      marks = {
        Cursor = {
          text = "•",
          priority = 0,
          highlight = "Normal",
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          highlight = "Search",
        },
      },
      Error = {
        text = { "-", "=" },
        priority = 2,
        highlight = "DiagnosticVirtualTextError",
      },
      Warn = {
        text = { "-", "=" },
        priority = 3,
        highlight = "DiagnosticVirtualTextWarn",
      },
      Info = {
        text = { "-", "=" },
        priority = 4,
        highlight = "DiagnosticVirtualTextInfo",
      },
      Hint = {
        text = { "-", "=" },
        priority = 5,
        highlight = "DiagnosticVirtualTextHint",
      },
      GitAdd = {
        text = "│",
        priority = 7,
        highlight = "GitSignsAdd",
      },
      GitChange = {
        text = "│",
        priority = 7,
        highlight = "GitSignsChange",
      },
      GitDelete = {
        text = "▁",
        priority = 7,
        highlight = "GitSignsDelete",
      },
      excluded_buftypes = {
        "terminal",
        "nofile",
      },
      excluded_filetypes = {
        "prompt",
        "minimap",
        "NvimTree",
        "noice",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        cursor = false,
        handle = true,
        diagnostic = true,
        gitsigns = true,
        search = true,
      },
    })
  end,
}
