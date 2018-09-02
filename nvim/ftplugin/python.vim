scriptencoding utf-8
"*****************************************************************************
"" python ftplugin
"*****************************************************************************

" initial script
if getline(0, '$') == ['']
    call append(0,'#!/usr/bin/env python')
    call append(1,'# -*- coding: utf-8 -*-')
    call append(2,'"""')
    call append(3,'Created on '.GetNow())
    call append(4,'   @file  : '.expand('%:t'))
    call append(5,'   @author: '.$USER)
    call append(6,'   @brief :')
    call append(7,'"""')
endif


" mapping
nno <silent> <leader>ip :Ipython<CR>
vno <silent> <leader>ip :VIpython<CR>
nno <silent> <leader>pd :Ipdb<CR>

nmap <silent> <leader>n <Plug>(ipdbdebug_next)
nmap <silent> <leader>u <Plug>(ipdbdebug_until)
nmap <silent> <leader>b <Plug>(ipdbdebug_break)
nmap <silent> <leader>c <Plug>(ipdbdebug_continue)
nmap <silent> <leader>p <Plug>(ipdbdebug_print)
vmap <silent> <leader>p <Plug>(ipdbdebug_vprint)
nmap <silent> <leader>q <Plug>(ipdbdebug_close)

if exists('*jedi#goto')
    " nno <silent> <leader>d :call jedi#goto()<CR>
    nno <silent> <leader>a :<C-u>call jedi#goto_assignments()<CR>
    nno <silent> <leader>d :<C-u>call jedi#goto_definitions()<CR>
endif


" auto command
aug vimrc_python
    au!
    au FileType python setlocal expandtab shiftwidth=4 tabstop=8
                \ formatoptions+=croq softtabstop=4
                \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
                \|let &colorcolumn=join(range(s:pythonmaxlinelength(), 300), ',')
                \|hi  ColorColumn guibg=#0f0f0f
    au BufNewFile,BufRead Pipfile      setfiletype toml
    au BufNewFile,BufRead Pipfile.lock setfiletype json
aug END
aug delimitMate
    if exists('delimitMate_version')
        au FileType python   let b:delimitMate_nesting_quotes = ['"',"'"]
    endif
aug END
aug Braceless
    if exists(':BracelessEnable') == 2
        au FileType python BracelessEnable +indent +fold "+highlight
        hi BracelessIndent guifg=#555555
    endif
aug END


" plugin setting
"" ALE (Asynchronous Lint Engine)
let b:ale_linters = ['flake8']
"" polyglot (Syntax highlight) Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let g:python_highlight_all = 1
"" IpdbDebugger
let g:ipdbdebug_map_enabled = 0
"" Ipython
let g:ipython_startup_options = [
            \'--no-confirm-exit',
            \'--colors=Linux',
            \'--no-banner']
let g:ipython_startup_import_modules = [
            \'import matplotlib.pyplot as plt',
            \'import pandas as pd',
            \'import numpy as np']
"" jupyter-vim
let g:jupyter_auto_connect = 1
let g:jupyter_mapkeys = 0
let g:jupyter_monitor_console = 1
let g:jupyter_verbose = 1


" function
fun! s:pythonmaxlinelength() abort
    " flake8のconfigファイルからpythonスクリプトの文字数上限(max-line-length)を取得する関数
    "      以下のようにcolorcolumnを設定することでバッファに文字数の上限ラインが引かれる
    "      :set colorcolumn=s:pythonmaxlinelength()
    let l:flake8_config = $HOME.'/.config/flake8'
    let l:max_line_length = 0
    if findfile(l:flake8_config) !=# ''
        for l:line in readfile(l:flake8_config)
            let l:match_param = matchstrpos(l:line,'max-line-length')
            if l:match_param[0] !=# ''
                let l:param_list = split(l:line, ' ')
                if len(l:param_list) == 3
                    let l:max_line_length = str2nr(l:param_list[2])
                elseif len(l:param_list) == 1
                    let l:param_list = split(l:line, '=')
                    let l:max_line_length = str2nr(l:param_list[1])
                endif
            endif
        endfor
    endif
    if l:max_line_length == 0
        let l:max_line_length = 100
    endif
    return l:max_line_length + 1
endf


fun! s:pyform(...) abort
    " autopep8やyapfに利用して編集中のPythonスクリプトを自動整形する関数
    "      :Pyform [autopep8(デフォルト) もしくは yapf]
    if &filetype ==# 'python'
        let l:formatter = 'autopep8'
        if a:0 > 0
            let l:formatter = a:1
        endif
        if l:formatter ==# 'autopep8'
            if !executable('autopep8')
                echon 'Pyform: [error] autopep8 command not found.'
                echon '                installing autopep8...'
                if !executable('pip')
                    echoerr 'You have to install pip!'
                    return
                endif
                call system('pip install autopep8')
                echon
            endif
            let l:pos = getpos('.')
            silent exe '%!autopep8 -'
            call setpos('.', l:pos)
        elseif l:formatter ==# 'yapf'
            if !executable('yapf')
                echon 'Pyform: [error] yapf command not found.'
                echon '                installing yapf...'
                if !executable('pip')
                    echoerr 'You have to install pip!'
                    return
                endif
                call system('pip install git+https://github.com/google/yapf')
                echon
            endif
            let l:pos = getpos('.')
            silent exe '0, $!yapf'
            call setpos('.', l:pos)
        else
            echon 'Pyfrom: [error] you can use autopep8 or yapf.'
        endif
    else
        echon 'Pyform: [error] invalid file type. this is "' . &filetype. '".'
    endif
endf
fun! s:CompletionPyformCommands(ArgLead, CmdLine, CusorPos)
    return filter(['autopep8', 'yapf'], printf('v:val =~ "^%s"', a:ArgLead))
endf
command! -complete=customlist,s:CompletionPyformCommands -nargs=? Pyform call s:pyform(<f-args>)


fun! s:pdb() abort
    " Pdbを起動する関数
    if &filetype ==# 'python'
        call BeginTerm('python', '-m pdb', expand('%'))
    else
        echon 'Pdb: [error] invalid file type. this is "' . &filetype. '".'
    endif
endf
command! Pdb call s:pdb()


fun! s:pudb() abort
    " pudbを起動する関数
    if &filetype ==# 'python'
        if !executable('pudb3')
            echon 'Pudb: [error] pudb3 command not found.'
            echon '                   installing pudb3...'
            if !executable('pip')
                echoerr 'You have to install pip!'
                return
            endif
            call system('pip install pudb')
            echon
        endif
        call NewTerm('pudb3', expand('%'))
    else
        echon 'Pudb: [error] invalid file type. this is "' . &filetype. '".'
    endif
endf
command! Pudb call s:pudb()
