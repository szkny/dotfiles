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
    exe '%!js-beautify'
    call setpos('.', l:pos)
endf
command! Beautify call s:jsbeautify()

fun! s:prettier() abort
    let l:textall = join(getline(0,'$'), "\\n")
    let l:command = "echo '".l:textall."' | prettier --stdin-filepath ".expand("%:p")
    let l:pos = getpos('.')
    exe '%!'.l:command
    call setpos('.', l:pos)
endf
command! Prettier call s:prettier()

