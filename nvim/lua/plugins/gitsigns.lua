return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>", mode = "n" },
  },
  dependencies = {
    "petertriho/nvim-scrollbar",
  },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 0,
      ignore_whitespace = true,
      virt_text_priority = 0,
    },
    current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      map("n", "<leader>gn", function()
        if vim.wo.diff then
          return ""
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })
      map("n", "<leader>gp", function()
        if vim.wo.diff then
          return ""
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })
    end,
  },
  init = function()
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
