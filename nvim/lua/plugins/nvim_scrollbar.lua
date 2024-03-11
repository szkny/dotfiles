return {
  "petertriho/nvim-scrollbar",
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  event = "VeryLazy",
  opts = {
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
  },
  config = function(_, opts)
    require("scrollbar").setup(opts)

    vim.api.nvim_set_hl(0, "ScrollbarHandle", { fg = "#333333", bg = "#555555" })
    vim.api.nvim_set_hl(0, "ScrollbarCursor", { fg = "#333333", bg = "#555555" })
    vim.api.nvim_set_hl(0, "ScrollbarCursorHandle", { fg = "#ffffff", bg = "#555555" })
    vim.api.nvim_set_hl(0, "ScrollbarSearch", { fg = "#5599dd", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarSearchHandle", { fg = "#5599dd", bg = "#555555", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarError", { fg = "#ee3333", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarErrorHandle", { fg = "#ee3333", bg = "#555555", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarWarn", { fg = "#edd000", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarWarnHandle", { fg = "#edd000", bg = "#555555", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarHint", { fg = "#5599dd", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarHintHandle", { fg = "#5599dd", bg = "#555555", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarInfo", { fg = "#ffffff", bg = "none", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarInfoHandle", { fg = "#ffffff", bg = "#555555", bold = true })
    vim.api.nvim_set_hl(0, "ScrollbarGitAdd", { fg = "#00bb00", bg = "none" })
    vim.api.nvim_set_hl(0, "ScrollbarGitAddHandle", { fg = "#00bb00", bg = "#555555" })
    vim.api.nvim_set_hl(0, "ScrollbarGitChange", { fg = "#cccc00", bg = "none" })
    vim.api.nvim_set_hl(0, "ScrollbarGitChangeHandle", { fg = "#cccc00", bg = "#555555" })
    vim.api.nvim_set_hl(0, "ScrollbarGitDelete", { fg = "#bb2222", bg = "none" })
    vim.api.nvim_set_hl(0, "ScrollbarGitDeleteHandle", { fg = "#bb2222", bg = "#555555" })
  end,
}
