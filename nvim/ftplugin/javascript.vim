scriptencoding utf-8
"*****************************************************************************
"" javascript ftplugin
"*****************************************************************************

" ALE
let b:ale_linters = ['eslint']
let b:ale_fixers = ['eslint']

" js-beautify
fun! s:jsbeautify() abort
    exe '%!js-beautify'
endf
command! Beautify call s:jsbeautify()
