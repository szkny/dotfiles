return {
  "MeanderingProgrammer/markdown.nvim",
  name = "render-markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = "markdown",
  opts = {
    enabled = true,
    file_types = { "markdown" },
    render_modes = { "n", "c", "t" },
    heading = {
      -- Turn on / off heading icon & background rendering
      enabled = true,
      -- Turn on / off any sign column related rendering
      sign = true,
      -- Replaces '#+' of 'atx_h._marker'
      -- The number of '#' in the heading determines the 'level'
      -- The 'level' is used to index into the array using a cycle
      -- The result is left padded with spaces to hide any additional '#'
      -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
      -- Added to the sign column if enabled
      -- The 'level' is used to index into the array using a cycle
      signs = { '󰫎 ' },
      -- Width of the heading background:
      --  block: width of the heading text
      --  full: full width of the window
      width = 'full',
      -- The 'level' is used to index into the array using a clamp
      -- Highlight for the heading icon and extends through the entire line
      backgrounds = {
        'RenderMarkdownH1Bg',
        'RenderMarkdownH2Bg',
        'RenderMarkdownH3Bg',
        'RenderMarkdownH4Bg',
        'RenderMarkdownH5Bg',
        'RenderMarkdownH6Bg',
      },
      -- The 'level' is used to index into the array using a clamp
      -- Highlight for the heading and sign icons
      foregrounds = {
        'RenderMarkdownH1',
        'RenderMarkdownH2',
        'RenderMarkdownH3',
        'RenderMarkdownH4',
        'RenderMarkdownH5',
        'RenderMarkdownH6',
      },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "none", fg = "none" })
  end,
}
