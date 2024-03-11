return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  opts = {
    padding = true,
    sticky = true,
    toggler = {
      line = "<C-_>",
      block = "gbc",
    },
    opleader = {
      line = "<C-_>",
      block = "gb",
    },
    extra = {
      -- above = 'gcO',
      -- below = 'gco',
      -- eol = 'gcA',
    },
    mappings = {
      basic = true,
      extra = true,
    },
  },
}
