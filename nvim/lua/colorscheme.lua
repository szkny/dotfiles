-- *****************************************************************************
--   ColorScheme
-- *****************************************************************************
vim.cmd([[
    aug transparencyBG
        au!
        au ColorScheme * hi Normal                                 guibg=none
        au ColorScheme * hi NonText                                guibg=none
        au ColorScheme * hi EndOfBuffer              guifg=#252525 guibg=none
        au ColorScheme * hi LineNr                   guifg=#666666 guibg=none
        au ColorScheme * hi SignColumn                             guibg=none
        au ColorScheme * hi Folded                                 guibg=none
        au ColorScheme * hi VertSplit                guifg=#555555 guibg=none

        au ColorScheme * hi CursorLine                             guibg=#303030
        au ColorScheme * hi Cursor      gui=reverse
    aug END
]])

vim.opt.background = "dark"
local c = require("vscode.colors").get_colors()
require("vscode").setup({
  style = "dark",
  transparent = true,
  italic_comments = true,
  disable_nvimtree_bg = true,
  color_overrides = {
    vscLineNumber = "#666666",
  },
  group_overrides = {
    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
  },
})
require("vscode").load("dark")

-- gitsigns.nvim
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00bb00", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#aaaa00", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff2222", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#777777", bg = "none" })
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "none", bg = "#004400" })
vim.api.nvim_set_hl(0, "DiffChange", { fg = "none", bg = "#303000" })
vim.api.nvim_set_hl(0, "Difftext", { fg = "none", bg = "#505000" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "none", bg = "#440000" })

-- nvim-hlslens
vim.api.nvim_set_hl(0, "Search", { fg = "none", bg = "#334f7a" })
vim.api.nvim_set_hl(0, "IncSearch", { fg = "none", bg = "#334f7a" })
vim.api.nvim_set_hl(0, "WildMenu", { fg = "none", bg = "#334f7a" })
vim.api.nvim_set_hl(0, "HlSearchNear", { link = "IncSearch", default = true })
vim.api.nvim_set_hl(0, "HlSearchLens", { fg = "#777777", bg = "none" })
vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = "#777777", bg = "none" })

-- lualine.nvim
vim.api.nvim_set_hl(0, "lualine_lsp_err", { fg = "#ee3333", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_warn", { fg = "#edd000", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_hint", { fg = "#5599dd", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_info", { fg = "#5599dd", bg = "#212736" })
vim.api.nvim_set_hl(0, "lualine_diff_add", { fg = "#66aa88", bg = "#394260" })
vim.api.nvim_set_hl(0, "lualine_diff_change", { fg = "#bbbb88", bg = "#394260" })
vim.api.nvim_set_hl(0, "lualine_diff_delete", { fg = "#aa6666", bg = "#394260" })

-- nvim-scrollbar
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

-- barbar.nvim
vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "none" })
vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "#1e1e1e", fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "BufferVisible", { bg = "none", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "BufferInactive", { bg = "none", fg = "#888888" })
vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = "#1e1e1e", fg = "#ffaa00", bold = true })
vim.api.nvim_set_hl(0, "BufferVisibleMod", { bg = "none", fg = "#ffaa00" })
vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = "none", fg = "#bb7700" })
vim.api.nvim_set_hl(0, "BufferCurrentSign", { bg = "#1e1e1e", fg = "#88ccff", bold = true })
vim.api.nvim_set_hl(0, "BufferVisibleSign", { bg = "none", fg = "#5588dd" })
vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "none", fg = "#444444" })
vim.api.nvim_set_hl(0, "BufferCurrentERROR", { bg = "#1e1e1e", fg = "#ee3333" })
vim.api.nvim_set_hl(0, "BufferVisibleERROR", { bg = "none", fg = "#ee3333" })
vim.api.nvim_set_hl(0, "BufferInactiveERROR", { bg = "none", fg = "#aa3333" })
vim.api.nvim_set_hl(0, "BufferCurrentWARN", { bg = "#1e1e1e", fg = "#edd000" })
vim.api.nvim_set_hl(0, "BufferVisibleWARN", { bg = "none", fg = "#edd000" })
vim.api.nvim_set_hl(0, "BufferInactiveWARN", { bg = "none", fg = "#908000" })
vim.api.nvim_set_hl(0, "BufferCurrentHINT", { bg = "#1e1e1e", fg = "#5588dd" })
vim.api.nvim_set_hl(0, "BufferVisibleHINT", { bg = "none", fg = "#5588dd" })
vim.api.nvim_set_hl(0, "BufferInactiveHINT", { bg = "none", fg = "#4466aa" })
vim.api.nvim_set_hl(0, "BufferCurrentINFO", { bg = "#1e1e1e", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "BufferVisibleINFO", { bg = "none", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "BufferInactiveINFO", { bg = "none", fg = "#888888" })
