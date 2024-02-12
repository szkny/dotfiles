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

vim.opt.background = 'dark'
local c = require('vscode.colors').get_colors()
require('vscode').setup({
  style = 'dark',
  transparent = true,
  italic_comments = true,
  disable_nvimtree_bg = true,
  color_overrides = {
    vscLineNumber = '#666666',
  },
  group_overrides = {
    Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
  }
})
require('vscode').load('dark')

-- vim.cmd[[colorscheme solarized-osaka]]
-- require("solarized-osaka").setup({
--   -- your configuration comes here
--   -- or leave it empty to use the default settings
--   transparent = true, -- Enable this to disable setting the background color
--   terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
--   styles = {
--     -- Style to be applied to different syntax groups
--     -- Value is any valid attr-list value for `:help nvim_set_hl`
--     comments = { italic = true },
--     keywords = { italic = true },
--     functions = {},
--     variables = {},
--     -- Background styles. Can be "dark", "transparent" or "normal"
--     sidebars = "dark", -- style for sidebars, see below
--     floats = "dark", -- style for floating windows
--   },
--   sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
--   day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
--   hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
--   dim_inactive = false, -- dims inactive windows
--   lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
-- })
