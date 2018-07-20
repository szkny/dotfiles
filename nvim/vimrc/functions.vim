scriptencoding utf-8
"*****************************************************************************
"" My-Functions
"*****************************************************************************

fun! s:ChangeBuffer(direction) abort
    " バッファタブを切り替える関数
    " directionにはnextかpreviousを指定する
    if a:direction ==? 'next' || a:direction ==? 'n'
        let l:cmd = 'bnext'
    elseif a:direction ==? 'previous' || a:direction ==? 'p'
        let l:cmd = 'bprevious'
    else
        let l:cmd = 'b'.a:direction
    endif
    exe l:cmd
    let l:termflag = str2nr(buffer_name('%')[0])
    if l:termflag
        setlocal nonumber
    else
        setlocal number
    endif
endf
command! -nargs=1 ChangeBuffer call s:ChangeBuffer(<f-args>)


fun! s:CloseBufferTab() abort
    " バッファタブを閉じる関数
    " バッファリストの数をカウント
    let l:buf_number = 0
    for l:i in range(1, bufnr('$'))
        if buflisted(l:i)
            let l:buf_number += 1
        endif
    endfor
    try
        if winnr('$') == 1
            " 単一ウィンドウの場合
            if l:buf_number == 1
                " バッファリストが１つの場合 quit
                quit
                return
            else
                " バッファリストが複数の場合 bdelete
                let l:deletebufnr = bufnr('%')
                let l:beforebufnr = bufnr('#')
                " 1つ前に編集していたバッファがあれば戻る、なければbnext
                if l:beforebufnr != -1 && buflisted(l:beforebufnr)
                    exe 'buffer '.l:beforebufnr
                else
                    bnext
                endif
                exe 'bdelete! '.l:deletebufnr
                return
            endif
        elseif winnr('$') > 1
            " 複数ウィンドウの場合
            if len(win_findbuf(bufnr('%'))) == 1 && &buflisted
                " 異なるファイルを画面分割している場合
                if l:buf_number == 1
                    " バッファリストが１つの場合 quit
                    quit
                    return
                else
                    " バッファリストが複数の場合 bdelete
                    let l:deletebufnr = bufnr('%')
                    let l:beforebufnr = bufnr('#')
                    " 1つ前に編集していたバッファがあれば戻る、なければbnext
                    if l:beforebufnr != -1 && buflisted(l:beforebufnr)
                        exe 'buffer '.l:beforebufnr
                    else
                        bnext
                    endif
                    exe 'bdelete! '.l:deletebufnr
                    return
                endif
            else
                " 同じファイルを画面分割している場合
                quit
                return
            endif
        endif
    catch
        echo 'CloseBufferTab: [error] "'.bufname('%').'" を閉じることができません。'
        return
    endtry
endf
command! CloseBufferTab call s:CloseBufferTab()


fun! Ranger() abort
    " rangerを利用してファイルを選択する関数
    "   (francoiscabrol/ranger.vimを利用)
    " vnew
    call OpenRanger()
    call s:SetNewBufName('ranger')
    setlocal nonumber
    setlocal filetype=terminal
endf
" NERDTreeのようにウィンドウ分割してファイル選択する機能を追加
" aug vimrc_ranger
"     au!
"     au BufNewFile * call CloseBufferTab()
" aug END


fun! BeginTerm(width, ...) abort
    " 現在のウィンドウサイズに応じてNewTerm()かSplitTerm()を呼び出す関数
    "      :BeginTerm [Command] で任意のシェルコマンドを実行
    let l:min_winwidth = 50
    let l:min_winheight = 20
    if a:0 == 0
        if winwidth(0) >= l:min_winwidth
           \ && winheight(0) >= l:min_winheight
            call SplitTerm(a:width)
        else
            call NewTerm()
        endif
    elseif a:0 >= 1
        let l:cmd = a:1
        let l:args = ''
        if a:0 >= 2
            for l:i in a:000[1:]
                let l:args .= ' '.l:i
            endfor
        endif
        if winwidth(0) >= l:min_winwidth
           \ && winheight(0) >= l:min_winheight
            call SplitTerm(a:width, l:cmd, l:args)
        else
            call NewTerm(l:cmd, l:args)
        endif
    endif
endf
command! -count -complete=shellcmd -nargs=* BeginTerm call BeginTerm(<count>, <f-args>)


fun! NewTerm(...) abort
    " 新規バッファでターミナルモードを開始する関数
    "      :NewTerm [Command] で任意のシェルコマンドを実行
    let l:current_dir = expand('%:p:h')
    if l:current_dir[0] !=# '/'
        let l:current_dir = getcwd()
    endif
    " execute command
    let l:cmd = 'terminal'
    if a:0 > 0
        for l:i in a:000
            let l:cmd .= ' '.l:i
        endfor
    endif
    exe 'enew'
    exe 'lcd ' . l:current_dir
    exe l:cmd
    " change buffer name
    if a:0 == 0
        call s:SetNewBufName('bash')
    elseif a:0 > 0
        call s:SetNewBufName(a:1)
    endif
    " set local settings
    setlocal nonumber
    setlocal buftype=terminal
    setlocal filetype=terminal
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nolist
    setlocal nospell
    " start terminal mode
    startinsert
endf
command! -complete=shellcmd -nargs=* NewTerm call NewTerm(<f-args>)


fun! SplitTerm(width, ...) abort
    " 分割ウィンドウでターミナルモードを開始する関数
    "      縦分割か横分割かは現在のファイル内の文字数と
    "      ウィンドウサイズとの兼ね合いで決まる
    "      :SplitTerm [Command] で任意のシェルコマンドを実行
    let l:current_dir = expand('%:p:h')
    if l:current_dir[0] !=# '/'
        let l:current_dir = getcwd()
    endif
    " create split window
    let l:width = s:Vsplitwidth()
    if l:width
        let l:width = a:width ? a:width : l:width
        let l:split = l:width.'vnew'
    else
        let l:height = s:Splitheight()
        let l:height = a:width ? a:width : l:height
        let l:split = l:height ? l:height.'new' : 'new'
    endif
    exe l:split
    exe 'lcd ' . l:current_dir
    " execute command
    let l:cmd2 = 'terminal'
    if a:0 > 0
        for l:i in a:000
            let l:cmd2 .= ' '.l:i
        endfor
    endif
    exe l:cmd2
    " change buffer name
    if a:0 == 0
        call s:SetNewBufName('bash')
    elseif a:0 > 0
        call s:SetNewBufName(a:1)
    endif
    " set local settings
    setlocal nonumber
    setlocal buftype=terminal
    setlocal filetype=terminal
    setlocal bufhidden=wipe " windowが閉じられた時にバッファを消去
    setlocal nobuflisted    " バッファリストに追加しない
    setlocal nocursorline
    setlocal nocursorcolumn
    " setlocal winfixwidth   " ウィンドウ開閉時に幅を保持
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nolist
    setlocal nospell
    " start terminal mode
    startinsert
endf
command! -count -complete=shellcmd -nargs=* SplitTerm call SplitTerm(<count>, <f-args>)


fun! s:SetNewBufName(name) abort
    " 新規バッファのバッファ名(例: '1 bash')を設定する関数
    "      NewTermとSplitTermで利用している
    let l:num = 1
    let l:name = split(a:name,' ')[0]
    while bufexists(l:num.' '.l:name)
        let l:num += 1
    endwhile
    exe 'file '.l:num.' '.l:name
endf


fun! s:Splitheight() abort
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


fun! s:Vsplitwidth() abort
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
    let l:max_line_len += 1
    " count line number or ale column width
    let l:linenumwidth = 0
    if &number
        " add line number column width
        let l:linenumwidth = 4
        let l:digits = 0
        let l:linenum = line('$')
        while l:linenum
            let l:digits += 1
            let l:linenum = l:linenum/10
        endwhile
        if l:digits > 3
            let l:linenumwidth += l:digits - 3
        endif
    endif
    " add ale sign line column width
    if exists('*airline#extensions#ale#get_error')
        if airline#extensions#ale#get_error() !=# ''
           \|| airline#extensions#ale#get_warning() !=# ''
            let l:linenumwidth += 2
        endif
    endif
    let l:width = winwidth(0)-l:max_line_len-l:linenumwidth
    let l:width = l:width>l:min_winwidth ? l:width : 0
    let l:width = l:width>l:max_winwidth ? l:max_winwidth : l:width
    return l:width
endf


fun! ResizeWindow(size) abort
    " 分割ウィンドウの高さと幅を調節する関数
    "      :ResizeWindow + でカレントウィンドウを広くする
    "      :ResizeWindow - でカレントウィンドウを狭くする
    "      以下のマッピングがおすすめ
    "      nno +  :ResizeWindow +<CR>
    "      nno -  :ResizeWindow -<CR>
    if a:size ==# ''
        echo '[warning] the args "size" is empty.'
        return
    endif
    if winwidth(0) >= winheight(0)*3
        exe 'res '.a:size
    else
        exe 'vertical res '.a:size
    endif
endf
command! -nargs=1 ResizeWindow call ResizeWindow(<f-args>)


fun! Make(width, ...) abort
    " makeコマンドを走らせる関数
    let l:current_dir = expand('%:p:h')
    let l:command = 'make'
    let l:args = ''
    if a:0 > 0
        for l:i in a:000
            let l:tmp     = ' '.l:i
            let l:args .= l:tmp
        endfor
    endif
    if findfile('GNUmakefile',l:current_dir) !=# ''
       \|| findfile('Makefile',l:current_dir) !=# ''
        call BeginTerm(a:width, l:command, l:args)
    elseif findfile('GNUmakefile',l:current_dir.'/../') !=# ''
           \|| findfile('Makefile',l:current_dir.'/../') !=# ''
        let l:command = 'cd ../ && '.l:command
        call BeginTerm(a:width, l:command, l:args)
    else
        echo 'not found: "GNUmakefile" or "Makefile"'
    endif
endf
command! -count -nargs=* Make call Make(<count>, <f-args>)


fun! CMake(width, ...) abort
    " cmakeコマンドを走らせる関数
    let l:current_dir = expand('%:p:h')
    let l:builddir = 'build'
    let l:cmakelists_txt = 'CMakeLists.txt'
    let l:command = 'cmake .. && make'
    if a:0 > 0
        if a:1 ==? 'run'
            let l:exename = GetProjectName(l:cmakelists_txt)
            let l:command .= ' && ./'.l:exename
        endif
    endif
    if findfile(l:cmakelists_txt,l:current_dir) !=# ''
        if finddir(l:builddir,l:current_dir) ==# ''
            call mkdir(l:builddir)
        endif
        let l:command = 'cd '.l:builddir.' && '.l:command
        call BeginTerm(a:width, l:command)
    elseif findfile(l:cmakelists_txt,l:current_dir.'/../') !=# ''
        let l:builddir = '../'.l:builddir
        if finddir(l:builddir,l:current_dir) ==# ''
            call mkdir(l:builddir)
        endif
        let l:command = 'cd '.l:builddir.' && '.l:command
        call BeginTerm(a:width, l:command)
    else
        echo 'not found: '.l:cmakelists_txt
    endif
endf
command! -count -nargs=* CMake call CMake(<count>, <f-args>)


fun! GetProjectName(cmakelists_txt) abort
    " CMakeLists.txtからプロジェクト名を取得する関数
    "      CMake関数で利用している
    if findfile(a:cmakelists_txt,getcwd()) !=# ''
        let  l:cmakelists_txt = a:cmakelists_txt
    elseif findfile(a:cmakelists_txt,getcwd().'/../') !=# ''
        let  l:cmakelists_txt = '../'.a:cmakelists_txt
    else
        return
    endif
    for l:line in readfile(l:cmakelists_txt)
        let l:AddExe = matchstrpos(l:line,'add_executable')
        if l:AddExe[0] !=# ''
            let l:Name = split(l:line[l:AddExe[2]+1:],' ')[0]
            return l:Name
        endif
    endfor
endf
command! -nargs=1 GetProjectName call GetProjectName(<f-args>)


fun! AppendChar(...) abort range
    " カーソルがある行の末尾に引数の文字を追加する関数
    "      C言語,js等で末尾にセミコロンをつけるときに使う
    "      すでに指定の文字が末尾にあれば追加しない。
    "      :AppendChar ;
    let l:pos = getpos('.')
    let l:pos[1] = a:lastline
    let l:args = ''
    for l:i in a:000
        let l:args .= l:i
    endfor
    let l:len = len(l:args)
    if !l:len
        return
    endif
    for l:linenum in range(a:firstline,a:lastline)
        call setpos('.', [0,l:linenum,0,0])
        let l:line = getline('.')
        if l:line[len(l:line)-l:len :] ==# l:args
            continue
        endif
        exe 'silent normal A'.l:args
    endfor
    call setpos('.', l:pos)
endf
command! -nargs=* -range Appendchar :<line1>,<line2>call AppendChar(<f-args>)


fun! Python(width, ...) abort
    " 開いているPythonスクリプトを実行する関数
    "      以下のようにスクリプト名は必要ない
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
        call BeginTerm(a:width, l:command, l:args)
    else
        call BeginTerm(a:width, l:command)
    endif
endf
command! -count -complete=file -nargs=* Python call Python(<count>, <f-args>)


fun! Ipython(width) abort
    " ipythonを起動して開いているPythonスクリプトをロードする関数
    if !executable('ipython')
        echo 'Ipython: [error] ipython does not exist.'
        echo '                 isntalling ipython ...'
        if !executable('pip')
            echoerr 'You have to install pip!'
            return
        endif
        silent exe '!pip install ipython'
        echo ''
    endif
    let l:command = 'ipython'
    if findfile('Pipfile',getcwd()) !=# ''
        \ && findfile('Pipfile.lock',getcwd()) !=# ''
        let l:command = 'pipenv run ipython'
    endif
    let l:args = '--no-confirm-exit --colors=Linux'
    let l:width = a:width
    if &filetype ==# 'python'
        let l:profile_name = InitIpython()
        let l:args .= ' --profile=' . l:profile_name
    endif
    call BeginTerm(a:width, l:command, l:args)
endf
command! -count Ipython call Ipython(<count>)


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


fun! Pyform(...) abort
    " autopep8やyapfに利用して編集中のPythonスクリプトを自動整形する関数
    "      :Pyform [autopep8(デフォルト) もしくは yapf]
    if &filetype ==# 'python'
        let l:formatter = 'autopep8'
        if a:0 > 0
            let l:formatter = a:1
        endif
        if l:formatter ==# 'autopep8'
            if !executable('autopep8')
                echo 'Pyform: [error] autopep8 command not found.'
                echo '                installing autopep8...'
                if !executable('pip')
                    echoerr 'You have to install pip!'
                    return
                endif
                silent exe '!pip install autopep8'
                echo ''
            endif
            let l:pos = getpos('.')
            silent exe '%!autopep8 -'
            call setpos('.', l:pos)
        elseif l:formatter ==# 'yapf'
            if !executable('yapf')
                echo 'Pyform: [error] yapf command not found.'
                echo '                installing yapf...'
                if !executable('pip')
                    echoerr 'You have to install pip!'
                    return
                endif
                silent exe '!pip install git+https://github.com/google/yapf'
                echo ''
            endif
            let l:pos = getpos('.')
            silent exe '0, $!yapf'
            call setpos('.', l:pos)
        else
            echo 'Pyfrom: [error] you can use autopep8 or yapf.'
        endif
    else
        echo 'Pyform: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
fun! s:CompletionPyformCommands(ArgLead, CmdLine, CusorPos)
    return filter(['autopep8', 'yapf'], printf('v:val =~ "^%s"', a:ArgLead))
endf
command! -complete=customlist,s:CompletionPyformCommands -nargs=? Pyform call Pyform(<f-args>)


fun! Pudb() abort
    " Pudbを起動する関数
    if &filetype ==# 'python'
        if !executable('pudb3')
            echo 'Pudb: [error] pudb3 command not found.'
            echo '                   installing pudb3...'
            if !executable('pip')
                echoerr 'You have to install pip!'
                return
            endif
            silent exe '!pip install pudb'
            echo ''
        endif
        call NewTerm('pudb3', expand('%'))
    else
        echo 'Pudb: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! Pudb call Pudb()


fun! Pdb() abort
    " Pdbを起動する関数
    if &filetype ==# 'python'
        call BeginTerm(0, 'python', '-m pdb', expand('%'))
    else
        echo 'Pdb: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! Pdb call Pdb()


fun! Ipdb() abort
    " Ipdbを起動する関数
    if &filetype ==# 'python'
        call BeginTerm(0, 'python', '-m ipdb', expand('%'))
    else
        echo 'Ipdb: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! Ipdb call Ipdb()


fun! SQL(width) abort
    " mysqlを起動する関数
    let l:command = 'mysql'
    if executable(l:command)
        let l:args = ''
        if &filetype ==# 'sql'
            let l:args = ' < ' . expand('%')
        endif
        call BeginTerm(a:width, l:command, l:args)
    else
        echo 'SQL: [error] '.l:command.' command not found.'
    endif
endf
command! -count SQL call SQL(<count>)


fun! SQLplot(width, ...) abort
    " sqlplot(自作シェルコマンド) を実行する関数
    if &filetype ==# 'sql' && executable('sqlplot')
        let l:command = 'sqlplot'
        let l:args = ' ' . expand('%')
        call BeginTerm(a:width, l:command, l:args)
    endif
endf
command! -count -nargs=* SQLplot call SQLplot(<count>, <f-args>)


fun! Pyplot(...) abort
    " pyplot(自作シェルコマンド) を実行する関数
    if &filetype ==# 'text' && executable('pyplot')
        if a:0 == 0
            let l:column = ' -u1'
        elseif a:0 == 1
            let l:column = ' -u'.a:1
        elseif a:0 >= 2
            let l:column = ' -n'.a:0
            for l:i in a:000
                let l:tmp  = ' -u'.l:i
                let l:column .= l:tmp
            endfor
        endif
        exe ':!pyplot %'.l:column
    endif
endf
command! -nargs=* Pyplot call Pyplot(<f-args>)


fun! Gnuplot() abort
    " gnuplotを実行する関数
    if expand('%:e') ==# 'gp' || expand('%:e') ==# 'gpi'
        let l:command = 'gnuplot'
        let l:args = ' ' . expand('%')
        call BeginTerm(0, l:command, l:args)
        starti
    else
        echo 'Gnuplot: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! -nargs=* Gnuplot call Gnuplot(<f-args>)


if executable('pdftotext')
    command! -complete=file -nargs=1 Pdf :r !pdftotext -nopgbrk -layout <q-args> -
endif


fun! SetHlsearch() abort
    " 検索結果のハイライトのオン/オフ切り替え
    if &hlsearch
        set nohlsearch
    else
        set hlsearch
    endif
endf


fun! GoogleSearchURL(...) abort
    " Google検索をするURLを返す関数
    let l:url = '"http://www.google.co.jp/'
    let l:opt = 'search?num=100'
    let l:wrd = ''
    if a:0 >= 1
        if a:0 == 1
            if type(a:1) == 1
                " case of a:1 == string
                let l:arglist = split(a:1, ' ')
                for l:i in l:arglist
                    if l:i == l:arglist[0]
                        let l:wrd = l:i
                    else
                        let l:wrd .= '+' . l:i
                    endif
                endfor
            elseif type(a:1) == 3
                " case of a:1 == list
                for l:i in a:1
                    if l:i == a:1[0]
                        let l:wrd = l:i
                    else
                        let l:wrd .= '+' . l:i
                    endif
                endfor
            endif
        else
            for l:i in a:000
                if l:i == a:1
                    let l:wrd = l:i
                else
                    let l:wrd .= '+' . l:i
                endif
            endfor
        endif
        let l:opt .= '&q=' . l:wrd
        let l:url .= l:opt
    endif
    let l:url .= '"'
    return l:url
endf


fun! Chrome(...) abort range
    " Google Chrome を開いて引数のキーワードを検索する関数
    if has('mac')
        let l:cmd = '!open -a Google\ Chrome '
    elseif system('uname') ==# "Linux\n"
        let l:cmd = '!chrome '
    else
        return
    endif
    let l:args = ''
    if a:0 == 0
        let l:tmp = @@
        exe 'silent normal gvy'
        if @@ !=# ''
            let l:args = GoogleSearchURL(@@)
        endif
        let @@ = l:tmp
    else
        let l:args = GoogleSearchURL(a:000)
    endif
    exe 'silent '.l:cmd.l:args
endf
command! -nargs=* -range Chrome :<line1>,<line2>call Chrome(<f-args>)


fun! W3m(width, ...) abort
    " w3mで引数のキーワードを検索する関数
    if executable('w3m')
        let l:url = GoogleSearchURL(a:000)
        call BeginTerm(a:width, 'w3m', '-M', l:url)
    else
        echo 'W3m: [error] w3m command not found.'
    endif
endf
command! -count -nargs=* W3m call W3m(<count>, <f-args>)


fun! GetNow() abort
    " 現在時刻を取得する関数
    let l:day = printf('%d', strftime('%d'))
    let l:nday = l:day[len(l:day)-1]
    let l:daytail = 'th'
    if     l:nday == 1
        let l:daytail = 'st'
    elseif l:nday == 2
        let l:daytail = 'nd'
    elseif l:nday == 3
        let l:daytail = 'rd'
    endif
    let l:day = l:day . l:daytail . ' '
    let l:nweek = strftime('%w')
    let l:weeks = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    let l:week = l:weeks[l:nweek] . ' '
    let l:nmonth = strftime('%m') - 1
    let l:months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    let l:month = l:months[l:nmonth] . ' '
    let l:now = l:week . l:month . l:day
    let l:now .= strftime('%H:%M:%S %Y')
    " let l:now .= strftime('%H:%M:%S %z (%Z) %Y')
    " let l:now = strftime('%Y-%m-%d(%a) %H:%M:%S')
    return l:now
endf


fun! Git(...) abort
    " gitコマンドを実行する関数
    let l:cmd = 'git'
    if a:1 ==# 'diff'
        let l:cmd = 'git status -v -v'
    elseif a:1 ==# 'acp'
        let l:cmd = 'git add -A && git commit -m "`date`" && git push -u'
    elseif a:1 ==# 'reset'
        let l:cmd = 'git reset --hard'
    elseif a:1 ==# 'fpull'
        let l:cmd = 'git reset --hard && git pull'
    else
        let l:args = ''
        for l:i in a:000
            let l:args .= ' '.l:i
        endfor
        let l:cmd .= l:args
    endif
    call BeginTerm(0, l:cmd)
endf
fun! s:CompletionGitCommands(ArgLead, CmdLine, CusorPos)
    return filter(['acp','fpull',  'diff', 'reset', 'status'], printf('v:val =~ "^%s"', a:ArgLead))
endf
command! -complete=customlist,s:CompletionGitCommands -nargs=* Git call Git(<f-args>)
