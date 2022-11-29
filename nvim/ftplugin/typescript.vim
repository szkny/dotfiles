scriptencoding utf-8
"*****************************************************************************
"" typescript ftplugin
"*****************************************************************************

" ALE
let b:ale_linters = ['eslint']
let b:ale_fixers = ['prettier']
" let g:ale_fix_on_save = 1
" let g:ale_javascript_prettier_use_local_config = 1

" fomatter
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
