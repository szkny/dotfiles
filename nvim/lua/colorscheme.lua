-- *****************************************************************************
--   ColorScheme
-- *****************************************************************************
vim.cmd([[
    aug transparencyBG
      au!
      au ColorScheme * hi Normal                    guibg=none
      au ColorScheme * hi NonText                   guibg=none
      au ColorScheme * hi EndOfBuffer guifg=#252525 guibg=none
      au ColorScheme * hi LineNr      guifg=#666666 guibg=none
      au ColorScheme * hi SignColumn                guibg=none
      au ColorScheme * hi Folded                    guibg=none
      au ColorScheme * hi VertSplit   guifg=#555555 guibg=none
      au ColorScheme * hi NormalNC                  guibg=none
      au ColorScheme * hi Comment                   guibg=none
      au ColorScheme * hi Constant                  guibg=none
      au ColorScheme * hi Special                   guibg=none
      au ColorScheme * hi Identifier                guibg=none
      au ColorScheme * hi Statement                 guibg=none
      au ColorScheme * hi PreProc                   guibg=none
      au ColorScheme * hi Type                      guibg=none
      au ColorScheme * hi Underlined                guibg=none
      au ColorScheme * hi Todo                      guibg=none
      au ColorScheme * hi String                    guibg=none
      au ColorScheme * hi Function                  guibg=none
      au ColorScheme * hi Conditional               guibg=none
      au ColorScheme * hi Repeat                    guibg=none
      au ColorScheme * hi Operator                  guibg=none
      au ColorScheme * hi Structure                 guibg=none
      au ColorScheme * hi StatusLine                guibg=none
      au ColorScheme * hi StatusLineNC              guibg=none
      au ColorScheme * hi CursorLine                guibg=#303030
      au ColorScheme * hi CursorLineNr              guibg=none
      au ColorScheme * hi Cursor      gui=reverse
    aug END
]])
