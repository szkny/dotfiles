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

fun! s:prettier() abort
    let l:pos = getpos('.')
    silent exe "0, $!prettier --stdin-filepath ".expand("%")
    call setpos('.', l:pos)
    if v:shell_error != 0
        undo
        echoerr '[ERROR] prettier failed.'
        echoerr ''
    endif
endf
let g:prettier_on_save = 1
fun! s:prettier_on_save()
    if get(g:, 'prettier_on_save')
        call s:prettier()
    endif
endf

command! Prettier call s:prettier()
aug PrettierSettings
    au!
    au BufWritePre *.{js*} call s:prettier_on_save()
aug END
