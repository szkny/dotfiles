return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  cmd = { "Trouble" },
  keys = {
    {
      "<leader>t",
      "<CMD>lua require('trouble').toggle('diagnostics')<CR>",
      mode = "n",
    },
  },
  opts = {
    auto_open = false,
    auto_close = false,
    auto_preview = true,
    auto_refresh = true,
    auto_jump = false,
    warn_no_results = false,
    open_no_results = true,
    focus = false,
    position = "bottom",
    height = 5,
    mode = "workspace_diagnostics",
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.HINT,
      vim.diagnostic.severity.INFO,
    },
    icon = true,
    use_diagnostic_signs = true,
    signs = {
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "",
    },
  },
  config = function(_, opts)
    local trouble_api = require("trouble")
    trouble_api.setup(opts)
  end,
}
