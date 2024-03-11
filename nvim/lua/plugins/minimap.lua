return {
  "wfxr/minimap.vim",
  cmd = "MinimapToggle",
  dependencies = {
    "petertriho/nvim-scrollbar",
  },
  keys = {
    {
      "<C-k>",
      "<CMD>ScrollbarToggle<CR>:MinimapToggle<CR>:try|e|catch|endtry<CR>:MinimapUpdateHighlight<CR>",
      mode = "n",
      silent = true,
    },
  },
  config = function()
    vim.g.minimap_auto_start = 0
    vim.g.minimap_auto_start_win_enter = 0
    vim.g.minimap_width = 10
    vim.g.minimap_window_width_override_for_scaling = 2147483647
    vim.g.minimap_block_filetypes = { "terminal", "fzf", "vista", "vista_kind", "NvimTree", "rnvimr" }
    -- vim.g.minimap_close_buftypes                    = {'nofile', 'startify', 'netrw', 'vim-plug', 'terminal'}
    vim.g.minimap_enable_highlight_colorgroup = 0
    vim.g.minimap_highlight_range = 1
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1
    vim.g.minimap_cursor_color_priority = 110
    vim.g.minimap_search_color_priority = 120
    vim.g.minimap_base_highlight = "Normal"
    vim.g.minimap_cursor_color = "MyMinimapCursor"
    vim.g.minimap_range_color = "MyMinimapRange"
    vim.g.minimap_search_color = "MyMinimapSearch"
    vim.g.minimap_diff_color = "MyMinimapDiffLine"
    vim.g.minimap_diffadd_color = "MyMinimapDiffAdded"
    vim.g.minimap_diffremove_color = "MyMinimapDiffRemoved"
    vim.api.nvim_set_hl(0, "MyMinimapCursor", { fg = "#000000", bg = "#ffffff" })
    vim.api.nvim_set_hl(0, "MyMinimapRange", { fg = "#ffffff", bg = "#555555" })
    vim.api.nvim_set_hl(0, "MyMinimapSearch", { fg = "#ffffff", bg = "#334f7a" })
    vim.api.nvim_set_hl(0, "MyMinimapDiffLine", { fg = "#bbbb00", bg = "none" })
    vim.api.nvim_set_hl(0, "MyMinimapDiffAdded", { fg = "#00aa77", bg = "none" })
    vim.api.nvim_set_hl(0, "MyMinimapDiffRemoved", { fg = "#bb0000", bg = "none" })
    -- vim.cmd([[
    --     aug minimap_auto_start
    --         au!
    --         au WinEnter * if g:minimap_auto_start_win_enter | exe 'Minimap' | endif
    --     aug END
    -- ]])
  end,
}
