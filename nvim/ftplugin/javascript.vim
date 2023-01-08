scriptencoding utf-8
"*****************************************************************************
"" javascript ftplugin
"*****************************************************************************

" ALE
let b:ale_linters = ['eslint']
let b:ale_fixers = ['prettier']

" fomatter
fun! s:jsbeautify() abort
    let l:pos = getpos('.')
    exe '0, $!js-beautify'
    call setpos('.', l:pos)
endf
command! Beautify call s:jsbeautify()

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
    au BufWritePre *.{js*} call s:prettier()
aug END
