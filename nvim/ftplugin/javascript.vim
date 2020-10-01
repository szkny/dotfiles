scriptencoding utf-8
"*****************************************************************************
"" javascript ftplugin
"*****************************************************************************

" ALE
let b:ale_linters = ['eslint']
let b:ale_fixers = ['eslint']

" js-beautify
fun! s:jsbeautify() abort
    let l:pos = getpos('.')
    exe '%!js-beautify'
    call setpos('.', l:pos)
endf
command! Beautify call s:jsbeautify()
