scriptencoding utf-8
"*****************************************************************************
"" vim ftplugin
"*****************************************************************************

" general setting
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" formatter
let g:prettier_on_save = 1
fun! s:prettier() abort
    if get(g:, 'prettier_on_save')
        let l:pos = getpos('.')
        silent exe "0, $!prettier --stdin-filepath ".expand("%")
        call setpos('.', l:pos)
        if v:shell_error != 0
            undo
            echoerr '[ERROR] prettier failed.'
            echoerr ''
        endif
    endif
endf
command! Prettier call s:prettier()

aug PrettierSettings
    au!
    au BufWritePre *.{vue*} call s:prettier()
aug END
