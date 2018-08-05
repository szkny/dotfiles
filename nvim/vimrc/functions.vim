scriptencoding utf-8
"*****************************************************************************
"" My-Functions
"*****************************************************************************

fun! s:changebuffer(direction) abort
    " バッファタブを切り替える関数
    " directionにはnextかpreviousを指定する
    if &buflisted
        if a:direction ==? 'next' || a:direction ==? 'n'
            let l:cmd = 'bnext'
        elseif a:direction ==? 'previous' || a:direction ==? 'p'
            let l:cmd = 'bprevious'
        else
            return
        endif
        exe l:cmd
        let l:termflag = str2nr(buffer_name('%')[0])
        if l:termflag
            setlocal nonumber
        else
            setlocal number
        endif
    endif
endf
command! -nargs=1 ChangeBuffer call s:changebuffer(<f-args>)


fun! s:closebuffertab() abort
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
                call s:deletebuffer()
                return
            endif
        elseif winnr('$') > 1
            " 複数ウィンドウの場合
            if len(win_findbuf(bufnr('%'))) == 1 && &buflisted
                " 異なるファイルを画面分割している場合
                if l:buf_number == 1 || &buftype ==? 'quickfix'
                    " バッファリストが１つ、または特定のバッファタイプの場合quit
                    quit
                    return
                else
                    call s:deletebuffer()
                    return
                endif
            else
                " 同じファイルを画面分割している、またはバッファリストにないウィンドウの場合
                quit
                return
            endif
        endif
    catch
        echon 'CloseBufferTab: [error] "'.bufname('%').'" を閉じることができません。'
        return
    endtry
endf
command! CloseBufferTab call s:closebuffertab()


fun! s:deletebuffer() abort
    " buffer deleteのwrapper関数
    try
        let l:deletebufnr = bufnr('%')
        let l:beforebufnr = bufnr('#')
        " 1つ前に編集していたバッファがあれば戻る、なければbnext
        if l:beforebufnr != -1 && buflisted(l:beforebufnr)
            exe 'buffer '.l:beforebufnr
        else
            bnext
        endif
        exe 'bdelete! '.l:deletebufnr
    catch
    endtry
endf


fun! Ranger() abort
    " rangerコマンドでファイルを選択する関数
    "   (francoiscabrol/ranger.vimを利用)
    " vnew
    if &buflisted
        silent call OpenRanger()
        silent call s:setnewbufname('ranger')
        setlocal nonumber
        setlocal filetype=terminal
    endif
endf


fun! BeginTerm(...) abort
    " 現在のウィンドウサイズに応じてNewTerm()かSplitTerm()を呼び出す関数
    "      :BeginTerm [Command] で任意のシェルコマンドを実行
    let l:min_winwidth = 50
    let l:min_winheight = 20
    if a:0 == 0
        if winwidth(0) >= l:min_winwidth
           \ && winheight(0) >= l:min_winheight
            call SplitTerm()
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
            call SplitTerm(l:cmd, l:args)
        else
            call NewTerm(l:cmd, l:args)
        endif
    endif
endf
command! -complete=shellcmd -nargs=* BeginTerm call BeginTerm(<f-args>)


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
    silent enew
    silent exe 'lcd ' . l:current_dir
    silent exe l:cmd
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
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nolist
    setlocal nospell
    setlocal lazyredraw
endf
command! -complete=shellcmd -nargs=* NewTerm call NewTerm(<f-args>)


fun! SplitTerm(...) abort
    " 分割ウィンドウでターミナルモードを開始する関数
    "      縦分割か横分割かは現在のファイル内の文字数と
    "      ウィンドウサイズとの兼ね合いで決まる
    "      :SplitTerm [Command] で任意のシェルコマンドを実行
    let l:current_dir = expand('%:p:h')
    if l:current_dir[0] !=# '/'
        let l:current_dir = getcwd()
    endif
    " create split window
    let l:width = s:vsplitwidth()
    if l:width
        let l:split = l:width.'vnew'
    else
        let l:height = s:splitheight()
        let l:split = l:height ? l:height.'new' : 'new'
    endif
    silent exe l:split
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
    setlocal bufhidden=wipe " windowが閉じられた時にバッファを消去
    setlocal nobuflisted    " バッファリストに追加しない
    setlocal nocursorline
    setlocal nocursorcolumn
    " setlocal winfixwidth   " ウィンドウ開閉時に幅を保持
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nolist
    setlocal nospell
    setlocal lazyredraw
endf
command! -complete=shellcmd -nargs=* SplitTerm call SplitTerm(<f-args>)


fun! s:setnewbufname(name) abort
    " 新規バッファのバッファ名(例: '1:bash')を設定する関数
    "      NewTermとSplitTermで利用している
    let l:num = 1
    let l:name = split(a:name,':')[0]
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
        \&& (airline#extensions#ale#get_error()!=#'' || airline#extensions#ale#get_warning()!=#'')
            \|| exists('*GitGutterGetHunkSummary') && GitGutterGetHunkSummary() != [0, 0, 0]
        let l:linenumwidth += 2
    endif
    let l:width = winwidth(0)-l:max_line_len-l:linenumwidth
    let l:width = l:width>l:min_winwidth ? l:width : 0
    let l:width = l:width>l:max_winwidth ? l:max_winwidth : l:width
    return l:width
endf


fun! s:resizewindow(size) abort
    " 分割ウィンドウの高さと幅を調節する関数
    "      :ResizeWindow + でカレントウィンドウを広くする
    "      :ResizeWindow - でカレントウィンドウを狭くする
    "      以下のマッピングがおすすめ
    "      nno +  :ResizeWindow +<CR>
    "      nno -  :ResizeWindow -<CR>
    if a:size ==# ''
        echon '[warning] the args "size" is empty.'
        return
    endif
    if winwidth(0) >= winheight(0)*3
        exe 'res '.a:size
    else
        exe 'vertical res '.a:size
    endif
endf
command! -nargs=1 ResizeWindow call s:resizewindow(<f-args>)


fun! s:make(...) abort
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
        call BeginTerm(l:command, l:args)
    elseif findfile('GNUmakefile',l:current_dir.'/../') !=# ''
           \|| findfile('Makefile',l:current_dir.'/../') !=# ''
        let l:command = 'cd ../ && '.l:command
        call BeginTerm(l:command, l:args)
    else
        echon 'not found: "GNUmakefile" or "Makefile"'
    endif
endf
command! -nargs=* Make call s:make(<f-args>)


fun! s:cmake(...) abort
    " cmakeコマンドを走らせる関数
    let l:current_dir = expand('%:p:h')
    let l:builddir = 'build'
    let l:cmakelists_txt = 'CMakeLists.txt'
    let l:command = 'cmake .. && make'
    if a:0 > 0
        if a:1 ==? 'run'
            let l:exename = s:getprojectname(l:cmakelists_txt)
            let l:command .= ' && ./'.l:exename
        endif
    endif
    if findfile(l:cmakelists_txt,l:current_dir) !=# ''
        if finddir(l:builddir,l:current_dir) ==# ''
            call mkdir(l:builddir)
        endif
        let l:command = 'cd '.l:builddir.' && '.l:command
        call BeginTerm(l:command)
    elseif findfile(l:cmakelists_txt,l:current_dir.'/../') !=# ''
        let l:builddir = '../'.l:builddir
        if finddir(l:builddir,l:current_dir) ==# ''
            call mkdir(l:builddir)
        endif
        let l:command = 'cd '.l:builddir.' && '.l:command
        call BeginTerm(l:command)
    else
        echon 'not found: '.l:cmakelists_txt
    endif
endf
command! -nargs=* CMake call s:cmake(<f-args>)


fun! s:getprojectname(cmakelists_txt) abort
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


fun! s:appendchar(...) abort range
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
command! -nargs=* -range Appendchar :<line1>,<line2>call s:appendchar(<f-args>)


fun! s:sql() abort
    " mysqlを起動する関数
    let l:command = 'mysql'
    if executable(l:command)
        let l:args = ''
        if &filetype ==# 'sql' || &filetype ==# 'mysql'
            let l:args = ' < ' . expand('%')
        endif
        call BeginTerm(l:command, l:args)
    else
        echon 'SQL: [error] '.l:command.' command not found.'
    endif
endf
command! SQL call s:sql()


fun! s:sqlplot(...) abort
    " sqlplot(自作シェルコマンド) を実行する関数
    if (&filetype ==# 'sql' || &filetype ==# 'mysql') && executable('sqlplot')
        let l:command = 'sqlplot'
        let l:args = ' ' . expand('%')
        call BeginTerm(l:command, l:args)
    endif
endf
command! -nargs=* SQLplot call s:sqlplot(<f-args>)


fun! s:pyplot(...) abort
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
        call system('pyplot %'.l:column)
    endif
endf
command! -nargs=* Pyplot call s:pyplot(<f-args>)


fun! s:gnuplot() abort
    " gnuplotを実行する関数
    if expand('%:e') ==# 'gp' || expand('%:e') ==# 'gpi'
        let l:command = 'gnuplot'
        let l:args = ' ' . expand('%')
        call BeginTerm(l:command, l:args)
        startinsert
    else
        echon 'Gnuplot: [error] invalid file type. this is "' . &filetype. '".'
    endif
endf
command! -nargs=* Gnuplot call s:gnuplot(<f-args>)


if executable('pdftotext')
    command! -complete=file -nargs=1 Pdf :r !pdftotext -nopgbrk -layout <q-args> -
endif


fun! s:sethlsearch() abort
    " 検索結果のハイライトのオン/オフ切り替え
    if &hlsearch
        set nohlsearch
    else
        set hlsearch
    endif
endf
command! SetHlSearch call s:sethlsearch()


fun! AgWord(...) abort
    let l:file_dir = expand('%:p:h')
    if l:file_dir[0] !=# '/'
        let l:file_dir = getcwd()
    endif
    silent exe 'lcd '.l:file_dir
    if a:0 == 0
        let l:text = expand('<cword>')
    else
        let l:text = ''
        for l:i in a:000
            let l:text .= ' '.l:i
        endfor
    endif
    silent exe 'Ag '.l:text
endf
command! -nargs=* AgWord call AgWord(<f-args>)


fun! VAgWord() abort range
    let l:file_dir = expand('%:p:h')
    if l:file_dir[0] !=# '/'
        let l:file_dir = getcwd()
    endif
    silent exe 'lcd '.l:file_dir
    let @@ = ''
    exe 'silent normal gvy'
    if @@ !=# ''
        let l:text = join(split(@@,'\n'))
        silent exe 'Ag '.l:text
    endif
endf


fun! s:googlesearchurl(...) abort
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


fun! s:chrome(...) abort range
    " Google Chrome を開いて引数のキーワードを検索する関数
    if has('mac')
        let l:cmd = 'open -a Google\ Chrome '
    elseif system('uname') ==# "Linux\n"
        let l:cmd = 'chrome '
    else
        return
    endif
    let l:url = ''
    if a:0 == 0
        let @@ = ''
        exe 'silent normal gvy'
        if @@ !=# ''
            let @@ = join(split(@@,'\n'))
            let l:url = s:googlesearchurl(@@)
        else
            let l:url = s:googlesearchurl()
        endif
    else
        let l:url = s:googlesearchurl(a:000)
    endif
    call system(l:cmd.l:url)
endf
command! -nargs=* -range Chrome call s:chrome(<f-args>)


fun! s:w3m(...) abort range
    " w3mで引数のキーワードを検索する関数
    if executable('w3m')
        let l:url = ''
        if a:0 == 0
            let @@ = ''
            exe 'silent normal gvy'
            if @@ !=# ''
                let @@ = join(split(@@,'\n'))
                let l:url = s:googlesearchurl(@@)
            else
                let l:url = s:googlesearchurl()
            endif
        else
            let l:url = s:googlesearchurl(a:000)
        endif
        call BeginTerm('w3m', '-M', l:url)
        startinsert
    else
        echon 'W3m: [error] w3m command not found.'
    endif
endf
command! -range -nargs=* W3m call s:w3m(<f-args>)


fun! s:nyaovim_browser(...) abort range
    if exists('g:nyaovim_version')
        let l:url = ''
        if a:0 == 0
            let @@ = ''
            exe 'silent normal gvy'
            if @@ !=# ''
                let @@ = join(split(@@,'\n'))
                let l:url = s:googlesearchurl(@@)
            else
                let l:url = s:googlesearchurl()
            endif
        else
            let l:url = s:googlesearchurl(a:000)
        endif
        let l:url = split(l:url, '"')[0]
        exe 'MiniBrowser '.l:url
    endif
endf
command! -range -nargs=* Browse call s:nyaovim_browser(<f-args>)


fun! s:trans(...) abort range
    " transコマンド(Google翻訳)を利用してvisual選択中の文字列を日本語変換する関数
    if executable('trans')
        let l:text = ''
        if a:0 ==0
            let @@ = ''
            exe 'silent normal gvy'
            if @@ !=# ''
                let l:text = join(split(@@,'\n'))
            else
                let l:text = expand('<cword>')
            endif
        else
            for l:i in a:000
                let l:text .= ' '.l:i
            endfor
        endif
        let l:text = substitute(l:text, '"', '\\"', 'g')
        if len(l:text) < 900
            call SplitTerm('trans', '{en=ja}', '"'.l:text.'"')
        else
            echo 'Trans: [error] text too long.'
        endif
    else
        call s:install_trans()
    endif
endf
command! -range -nargs=* Trans call s:trans(<f-args>)


fun! s:install_trans() abort
    if has('mac')
        let l:install_cmd = 'brew install http://www.soimort.org/translate-shell/translate-shell.rb'
    elseif system('uname') ==# "Linux\n"
        let l:exe = '/usr/local/bin/trans'
        let l:install_cmd = 'sudo wget git.io/trans -O '.l:exe
        let l:install_cmd .= ' && sudo chmod +x '.l:exe
    else
        echon 'Trans: [error] trans command not found.'
        return
    endif
    silent call SplitTerm('echo "trans command not found. installing ..."'
                        \.' && '.l:install_cmd
                        \.' && echo " Success !!"'
                        \.' && echo " you can do \":Trans [WORD]\"."')
    startinsert
endf


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


fun! s:git(...) abort
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
    call BeginTerm(l:cmd)
endf
fun! s:CompletionGitCommands(ArgLead, CmdLine, CusorPos)
    return filter(['acp','fpull',  'diff', 'reset', 'status'], printf('v:val =~ "^%s"', a:ArgLead))
endf
command! -complete=customlist,s:CompletionGitCommands -nargs=* Git call s:git(<f-args>)
