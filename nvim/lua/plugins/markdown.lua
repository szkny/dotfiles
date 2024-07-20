return {
  "MeanderingProgrammer/markdown.nvim",
  name = "render-markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = "markdown",
  opts = {},
  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,
}
