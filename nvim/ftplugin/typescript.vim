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
" fun! s:prettier() abort
"     let l:pos = getpos('.')
"     exe '%!prettier '.expand("%:p")
"     call setpos('.', l:pos)
"     if v:shell_error != 0
"         undo
"         echoerr '[ERROR] prettier failed.'
"     endif
" endf
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
    au BufWritePre *.{ts*} call s:prettier_on_save()
aug END
