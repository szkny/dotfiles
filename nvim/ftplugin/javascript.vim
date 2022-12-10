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
endf
command! Prettier call s:prettier()

