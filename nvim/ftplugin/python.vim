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
nno <silent> <C-p>      :Python<CR>
nno <silent> <leader>ip :Ipython<CR>
nno <silent> <leader>pd :IpdbToggle<CR>
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
        hi BracelessIndent guifg=#a0a0a0
    endif
aug END


" plugin setting
"" ALE (Asynchronous Lint Engine)
let b:ale_linters = ['flake8']
" polyglot (Syntax highlight) Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let g:python_highlight_all = 1
"" IpdbDebugger
let g:ipdbdebug_map_enabled = 1


" function
fun! s:python(...) abort
    " 開いているPythonスクリプトを実行する関数
    "      以下のように使用する
    "      :Python
    "      コマンドライン引数が必要な場合は
    "      :Python [引数]
    let l:command = 'python'
    if findfile('Pipfile',getcwd()) !=# ''
        \ && findfile('Pipfile.lock',getcwd()) !=# ''
        let l:command = 'pipenv run python'
    endif
    let l:filename = ' '
    if &filetype ==# 'python'
        let l:filename .= expand('%')
    endif
    let l:args = ''
    if a:0 > 0
        for l:i in a:000
            let l:args .= ' ' . l:i
        endfor
    endif
    let l:args = l:filename . l:args
    call BeginTerm(l:command, l:args)
endf
" command! -complete=file -nargs=* Python call s:python(<f-args>)


fun! s:ipython() abort
    " ipythonを起動して開いているPythonスクリプトをロードする関数
    if !executable('ipython')
        echon 'Ipython: [error] ipython does not exist.'
        echon '                 isntalling ipython ...'
        if !executable('pip')
            echoerr 'You have to install pip!'
            return
        endif
        call system('pip install ipython')
        echon
    endif
    let l:command = 'ipython'
    if findfile('Pipfile',getcwd()) !=# ''
        \ && findfile('Pipfile.lock',getcwd()) !=# ''
        let l:command = 'pipenv run ipython'
    endif
    let l:args = '--no-confirm-exit --colors=Linux'
    if &filetype ==# 'python'
        let l:profile_name = s:initipython()
        let l:args .= ' --profile=' . l:profile_name
    endif
    call BeginTerm(l:command, l:args)
    startinsert
endf
command! Ipython call s:ipython()


fun! s:initipython() abort
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


""""""""""""""" Python Console plugin """"""""""""""""""""
command! -complete=file -nargs=* Python call s:console_run(<f-args>)
command! PythonConsoleInfo call s:console_info()

fun! s:console_run(...) abort
    " Pythonコンソール上で編集中のPythonスクリプトを実行する関数
    "      以下のように使用する
    "      :Python
    if &filetype ==# 'python'
        if s:console_exist()
            "" コンソールが有ればスクリプトを実行
            let l:script_name = expand('%:p')
            let l:script_dir = expand('%:p:h')
            if has_key(s:term, 'script_name')
                \&& s:term.script_name !=# l:script_name
                call s:console_jobsend('%reset')
                call s:console_jobsend('y')
            endif
            if has_key(s:term, 'script_dir')
                \ && s:term.script_dir !=# l:script_dir
                call s:console_jobsend('%cd '.l:script_dir)
            endif
            let s:term.script_name = l:script_name
            let s:term.script_dir = l:script_dir
            call s:console_jobsend('%run '.s:term.script_name)
        else
            "" コンソールが無ければコンソール用のウィンドウを作る
            let l:command = 'ipython'
            let l:filename = ' ' . expand('%')
            if findfile('Pipfile', expand('%:p')) !=# ''
                \ && findfile('Pipfile.lock', expand('%:p')) !=# ''
                let l:command = 'pipenv run ipython'
            endif
            let s:term = {}
            let s:term.script_winid = win_getid()
            call s:splitterm(l:command, '--no-confirm-exit --colors=Linux')
            silent exe 'normal G'
            let s:term.jobid = b:terminal_job_id
            let s:term.console_winid = win_getid()
            call win_gotoid(s:term.script_winid)
        endif
    endif
endf


fun! s:console_exist() abort
    if !exists('s:term')
        let s:term = {}
    endif
    let l:current_winid = win_getid()
    if has_key(s:term, 'jobid')
      \&& has_key(s:term, 'console_winid')
        \&& win_gotoid(s:term.console_winid)
        call win_gotoid(l:current_winid)
        return 1
    else
        return 0
    endif
endf


fun! s:console_jobsend(...) abort
    if s:console_exist()
        let l:command = ''
        if a:0 > 0
            let l:command = a:1
            for l:arg in a:000[1:]
                let l:command .= ' ' . l:arg
            endfor
        endif
        try
            call jobsend(s:term.jobid, "\<C-u>".l:command."\<CR>")
        catch
        endtry
    endif
endf


fun! s:console_info() abort
    echo s:term
endf


fun! s:splitterm(...) abort
    " 分割ウィンドウでターミナルモードを開始する関数
    "      縦分割か横分割かは現在のファイル内の文字数と
    "      ウィンドウサイズとの兼ね合いで決まる
    "      :SplitTerm [Command] で任意のシェルコマンドを実行
    let l:current_dir = expand('%:p:h')
    " create split window
    let l:split = ''
    let l:width = s:vsplitwidth()
    if l:width
        let l:split = 'vnew'
        let l:cmd1 = l:width.l:split
    else
        let l:split = 'new'
        let l:height = s:splitheight()
        let l:cmd1 = l:height ? l:height.l:split : l:split
    endif
    silent exe l:cmd1
    silent exe 'lcd ' . l:current_dir
    " execute command
    let l:cmd2 = 'terminal'
    if a:0 > 0
        for l:i in a:000
            let l:cmd2 .= ' '.l:i
        endfor
    endif
    silent exe l:cmd2
    " change buffer name
    if a:0 == 0
        silent call s:setnewbufname('bash')
    elseif a:0 > 0
        silent call s:setnewbufname(a:1)
    endif
    " set local settings
    setlocal nonumber
    setlocal buftype=terminal
    setlocal filetype=terminal
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal winfixwidth
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nolist
    setlocal nospell
    setlocal lazyredraw
    return l:split
endf


fun! s:setnewbufname(name) abort
    " 新規バッファのバッファ名(例: '1:bash')を設定する関数
    "      NewTermとSplitTermで利用している
    let l:num = 1
    let l:name = split(a:name,' ')[0]
    while bufexists(l:num.':'.l:name)
        let l:num += 1
    endwhile
    exe 'file '.l:num.':'.l:name
endf


fun! s:splitheight() abort
    " 新規分割ウィンドウの高さを決める関数
    "      SplitTermで利用している
    let l:min_winheight = 10
    let l:max_winheight = winheight(0)/2
    " count max line length
    let l:height = winheight(0)-line('$')
    let l:height = l:height>l:min_winheight ? l:height : 0
    let l:height = l:height>l:max_winheight ? l:max_winheight : l:height
    return l:height
endf


fun! s:vsplitwidth() abort
    " 新規分割ウィンドウの幅を決める関数
    "      SplitTermで利用している
    let l:min_winwidth = 60
    let l:max_winwidth = winwidth(0)/2
    " count max line length
    let l:all_lines = getline('w0', 'w$')
    let l:max_line_len = 0
    for l:line in l:all_lines
        if len(l:line) > l:max_line_len
            let l:max_line_len = strwidth(l:line)
        endif
    endfor
    let l:width = winwidth(0)-l:max_line_len - 1
    let l:width = l:width>l:min_winwidth ? l:width : 0
    let l:width = l:width>l:max_winwidth ? l:max_winwidth : l:width
    return l:width
endf
