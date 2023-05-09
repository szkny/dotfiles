-- *****************************************************************************
--   ColorScheme
-- *****************************************************************************
vim.cmd([[
    aug transparencyBG
        au!
        " au ColorScheme * hi EndOfBuffer              guifg=bg
        " au ColorScheme * hi NonText                  guifg=#404040
        " au ColorScheme * hi SpecialKey               guifg=#404040
        " au ColorScheme * hi LineNr                   guifg=#555555 guibg=#202020
        " au ColorScheme * hi SignColumn                             guibg=#202020
        " au ColorScheme * hi VertSplit   gui=none     guifg=#444444 guibg=#202020

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

vim.cmd('colorscheme codedark')
