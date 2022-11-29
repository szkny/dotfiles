scriptencoding utf-8
"*****************************************************************************
"" javascript ftplugin
"*****************************************************************************

" ALE
let b:ale_linters = ['eslint']
let b:ale_fixers = ['prettier']

" fomatter
fun! s:jsbeautify() abort
    if exists('js-beautify')
        let l:pos = getpos('.')
        exe '%!js-beautify'
        call setpos('.', l:pos)
    else
        echoerr 'js-beautify does not exist.'
    endif
endf
command! Beautify call s:jsbeautify()

fun! s:prettier() abort
    if exists('prettier')
        let l:pos = getpos('.')
        exe '%!prettier '.expand("%:p")
        call setpos('.', l:pos)
    else
        echoerr 'prettier does not exist.'
    endif
endf
command! Prettier call s:prettier()

