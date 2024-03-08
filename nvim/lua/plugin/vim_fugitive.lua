vim.cmd([[
    if exists('*fugitive#statusline')
        set statusline+=%{fugitive#statusline()}
    endif
    fun! s:fugitive_init() abort
        setlocal nonumber
        setlocal bufhidden=wipe
        setlocal nobuflisted
        setlocal nolist
        setlocal nospell
        setlocal noequalalways
        resize 10
    endf
    au FileType fugitive call s:fugitive_init()
]])
-- vim.keymap.set("n", "<Leader>gg", ":<C-u>G<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>gd", ":<C-u>Gvdiffsplit<CR>", { noremap = true, silent = true })
