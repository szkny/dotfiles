scriptencoding utf-8
"*****************************************************************************
"" python ftplugin
"*****************************************************************************

" initial script
if getline(0, '$') == ['']
    let s:user_name = 'Suzuki'
    call append(0, '#!/usr/bin/env python')
    call append(1,'# -*- coding: utf-8 -*-')
    call append(2,'"""')
    call append(3,'Created on '.GetNow())
    call append(4,'   @file  : '.expand('%:t'))
    call append(5,'   @author: '.s:user_name)
    call append(6,'   @brief :')
    call append(7,'"""')
endif

" mapping
nno <buffer><silent><leader>py :Python<CR>i
nno <buffer><silent><leader>ip :Ipython<CR>i
nno <buffer><silent><leader>pd :Ipdb<CR>

" auto command
aug vimrc_python
    au!
    au FileType python setlocal expandtab shiftwidth=4 tabstop=8
                \ formatoptions+=croq softtabstop=4
                \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
                \|let &colorcolumn=join(range(PythonMaxLineLength(), 300), ',')
                \|hi  ColorColumn guibg=#0f0f0f
                \|nno <silent> <leader>a :call jedi#goto_assignments()<CR>
                \|nno <silent> <leader>d :call jedi#goto_definitions()<CR>
    au BufNewFile,BufRead Pipfile setf toml
    au BufNewFile,BufRead Pipfile.lock setf json
aug END


" function
fun! Python(...) abort
    " 開いているPythonスクリプトを実行する関数
    "      以下のように使用する
    "      :Python
    "      コマンドライン引数が必要な場合は
    "      :Python [引数]
    let l:command = 'python'
    if &filetype ==# 'python'
        let l:args = ' ' . expand('%')
        if findfile('Pipfile',getcwd()) !=# ''
            \ && findfile('Pipfile.lock',getcwd()) !=# ''
            let l:command = 'pipenv run python'
        endif
        for l:i in a:000
            let l:args .= ' ' . l:i
        endfor
        call BeginTerm(l:command, l:args)
    else
        call BeginTerm(l:command)
    endif
endf
command! -complete=file -nargs=* Python call Python(<f-args>)


fun! Ipython() abort
    " ipythonを起動して開いているPythonスクリプトをロードする関数
    if !executable('ipython')
        echon 'Ipython: [error] ipython does not exist.'
        echon '                 isntalling ipython ...'
        if !executable('pip')
            echoerr 'You have to install pip!'
            return
        endif
        call system('pip install ipython')
        echo
    endif
    let l:command = 'ipython'
    if findfile('Pipfile',getcwd()) !=# ''
        \ && findfile('Pipfile.lock',getcwd()) !=# ''
        let l:command = 'pipenv run ipython'
    endif
    let l:args = '--no-confirm-exit --colors=Linux'
    if &filetype ==# 'python'
        let l:profile_name = InitIpython()
        let l:args .= ' --profile=' . l:profile_name
    endif
    call BeginTerm(l:command, l:args)
endf
command! Ipython call Ipython()


fun! InitIpython() abort
    " ipythonの初期化関数
    "      Ipython()で利用している
    let l:profile_name = 'neovim'
    let l:ipython_profile_dir = $HOME . '/.ipython/profile_' . l:profile_name
    let l:ipython_startup_dir = l:ipython_profile_dir . '/startup'
    if finddir(l:ipython_startup_dir) ==# ''
        call mkdir(l:ipython_startup_dir, 'p')
    endif
    let l:ipython_startup_file = l:ipython_startup_dir . '/startup.py'
    if expand('%:t:e') !=# ''
        let l:modulename = expand('%:t:r')
        let l:ipython_init_command = ['from ' . l:modulename . ' import *']
    else
        let l:ipython_init_command = getline('0','$')
        let l:main_flag = 0
        let l:operator = 0
        for l:line in l:ipython_init_command
            if l:line ==# 'if __name__ == ''__main__'':'
                let l:main_flag = 1
            endif
            if l:main_flag
                unlet l:ipython_init_command[l:operator]
            else
                let l:operator += 1
            endif
        endfor
    endif
    call writefile(l:ipython_init_command, l:ipython_startup_file)
    return l:profile_name
endf


fun! PythonMaxLineLength() abort
    " flake8のconfigファイルからpythonスクリプトの文字数上限(max-line-length)を取得する関数
    "      以下のようにcolorcolumnを設定することでバッファに文字数の上限ラインが引かれる
    "      :set colorcolumn=PythonMaxLineLength()
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


let s:ipdb = {}
fun! s:ipdb_open() abort
    " Ipdbを起動する関数
    if &filetype ==# 'python'
        " start ipdb debbug mode
        silent write
        let s:ipdb.save_updatetime = &updatetime
        setlocal updatetime=100
        setlocal nomodifiable
        " if exists('*airline#add_statusline_func')
        "     call airline#add_statusline_func('IpdbStatus')
        " endif
        " mapping
        nno <buffer><silent> <ESC> :<C-u>call <SID>ipdb_close()<CR>
        nno <buffer><silent> <C-[> :<C-u>call <SID>ipdb_close()<CR>
        nno <buffer><silent> q     :<C-u>call <SID>ipdb_close()<CR>
        nno <buffer><silent> n     :<C-u>call <SID>ipdb_step()<CR>
        nno <buffer><silent> u     :<C-u>call <SID>ipdb_until()<CR>
        nno <buffer><silent> <C-c> :<C-u>call <SID>ipdb_sigint()<CR>
        " autocmd
        aug ipdb_auto_command
            au!
            au CursorHold <buffer> echon '-- DEBUG --'
        aug END
        let s:ipdb.script_winid = win_getid()
        silent call SplitTerm('python', '-m ipdb', expand('%'))
        nno <buffer><silent> <ESC> :<C-u>call <SID>ipdb_close()<CR>
        nno <buffer><silent> <C-[> :<C-u>call <SID>ipdb_close()<CR>
        nno <buffer><silent> q     :<C-u>call <SID>ipdb_close()<CR>
        let s:ipdb.jobid = b:terminal_job_id
        let s:ipdb.debug_winid = win_getid()
        call win_gotoid(s:ipdb.script_winid)
        echon '-- DEBUG -- '
    else
        echon 'ipdb: [error] invalid file type. this is "' . &filetype. '".'
    endif
endf
command! Ipdb call s:ipdb_open()

fun! IpdbStatus(...)
  let w:airline_section_a = 'IPDB'
  let w:airline_section_b = g:airline_section_b
  let w:airline_section_c = g:airline_section_c
endf

fun! s:ipdb_close()
    if has_key(s:ipdb, 'jobid')
       \&& has_key(s:ipdb, 'save_updatetime')
           \&& has_key(s:ipdb, 'script_winid')
               \&& has_key(s:ipdb, 'debug_winid')
        call win_gotoid(s:ipdb.script_winid)
        let &updatetime=s:ipdb.save_updatetime
        setlocal modifiable
        try
            " nunmap <buffer><silent> <ESC>
            nunmap <buffer><silent> <C-[>
            nunmap <buffer><silent> q
            nunmap <buffer><silent> n
            nunmap <buffer><silent> u
            nunmap <buffer><silent> <C-c>
        endtry
        aug ipdb_auto_command
            au!
        aug END
        call win_gotoid(s:ipdb.debug_winid)
        try
            " nunmap <buffer><silent> <ESC>
            nunmap <buffer><silent> <C-[>
            nunmap <buffer><silent> q
        endtry
        quit
        unlet s:ipdb.jobid
        unlet s:ipdb.script_winid
        unlet s:ipdb.debug_winid
        echon
    endif
endf

fun! s:ipdb_step() abort
    try
        call jobsend(s:ipdb.jobid, "n\<CR>")
    catch
        call s:ipdb_close()
    endtry
endf

fun! s:ipdb_until() abort
    call jobsend(s:ipdb.jobid, 'until '.line('.')."\<CR>")
endf

fun! s:ipdb_sigint() abort
    call jobsend(s:ipdb.jobid, "\<C-c>")
endf


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


" plugin setting
let b:ale_linters = ['flake8']
