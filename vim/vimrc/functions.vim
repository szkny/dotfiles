scriptencoding utf-8

fun! s:changebuffer(direction) abort
    " バッファタブを切り替える関数
    " directionにはnextかpreviousを指定する
    if tabpagenr('$') == 1
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
    else
        if a:direction ==? 'next' || a:direction ==? 'n'
            let l:cmd = 'tabnext'
        elseif a:direction ==? 'previous' || a:direction ==? 'p'
            let l:cmd = 'tabprevious'
        else
            return
        endif
        exe l:cmd
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
    if tabpagenr('$') > 1
        if l:buf_number == 1
            tabclose
        else
            if &buflisted
                exe 'bd '.buffer_number('%')
            else
                quit
            endif
        endif
    else
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
                        if l:buf_number == 2
                            quit
                        endif
                        return
                    endif
                else
                    " 同じファイルを画面分割している、またはバッファリストにないウィンドウの場合
                    quit
                    return
                endif
            endif
        catch
            echoerr 'CloseBufferTab: [error] "'.bufname('%').'" を閉じることができません。'
            return
        endtry
    endif
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


fun! s:CloseNetrw() abort
  for bufn in range(1, bufnr('$'))
    if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
      silent! execute 'bwipeout ' . bufn
      if getline(2) =~# '^" Netrw '
        silent! bwipeout
      endif
      return
    endif
  endfor
endf
autocmd FileType netrw nnoremap <buffer><silent> <Esc> :call <SID>CloseNetrw()<CR>
autocmd FileType netrw nnoremap <buffer><silent> q     :call <SID>CloseNetrw()<CR>
autocmd FileType netrw nnoremap <buffer><silent> <C-n> :call <SID>CloseNetrw()<CR>


fun! s:newtabpage() abort
    tabnew
    call Ranger()
endf
command! NewTabPage call s:newtabpage()

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
    let l:command = 'make '.join(a:000)
    if findfile('GNUmakefile',l:current_dir) !=# ''
       \|| findfile('Makefile',l:current_dir) !=# ''
        call term_start(l:command)
    elseif findfile('GNUmakefile',l:current_dir.'/../') !=# ''
           \|| findfile('Makefile',l:current_dir.'/../') !=# ''
        let l:command = 'cd ../ && '.l:command
        call term_start(l:command)
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
        call term_start(l:command)
    elseif findfile(l:cmakelists_txt,l:current_dir.'/../') !=# ''
        let l:builddir = '../'.l:builddir
        if finddir(l:builddir,l:current_dir) ==# ''
            call mkdir(l:builddir)
        endif
        let l:command = 'cd '.l:builddir.' && '.l:command
        call term_start(l:command)
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
    let l:args = join(a:000)
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
        call term_start(l:command.' '.l:args)
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
        call term_start(l:command.' '.l:args)
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
        call term_start(l:command.' '.l:args)
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


fun! ReplaceWord(...) abort
    let l:target = expand('<cword>')
    if a:0 > 0
        let l:text = join(a:000)
    else
        echoerr 'no argument.'
        return
    endif
    exe line('.').',$s/'.l:target.'/'.l:text.'/gc'
endf
command! -nargs=* ReplaceWord call ReplaceWord(<f-args>)


fun! VReplaceWord(...) abort range
    if a:0 > 0
        let l:text = join(a:000)
    else
        echoerr 'no argument.'
        return
    endif
    let @@ = ''
    exe 'silent normal gvy'
    if @@ !=# ''
        let l:target = join(split(@@,'\n'))
        exe line('.').',$s/'.l:target.'/'.l:text.'/gc'
    endif
endf
command! -range -nargs=* VReplaceWord call VReplaceWord(<f-args>)


fun! ReplaceWordText() abort
    let l:target = expand('<cword>')
    if l:target !=# ''
        return line('.').',$s/'.l:target.'//gc'
    else
        return ''
    endif
endf


fun! VReplaceWordText() abort range
    let l:target = s:get_vselect_txt()
    if l:target !=# ''
        return line('.').',$s/'.l:target.'//gc'
    else
        return ''
    endif
endf


fun! s:get_vselect_txt()
    if mode()=="v"
        let [line_start, column_start] = getpos("v")[1:2]
        let [line_end, column_end] = getpos(".")[1:2]
    else
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
    end
    if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
        let [line_start, column_start, line_end, column_end] =
        \   [line_end, column_end, line_start, column_start]
    end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
            return ''
    endif
    let lines[-1] = lines[-1][: column_end - 1]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endf


fun! s:jqfmt() abort
    if executable("jq")
        let l:pos = getpos('.')
        silent exe "0, $!jq -r ."
        call setpos('.', l:pos)
    else
        echoerr "jq not found."
    endif
endf
command! Jq call s:jqfmt()


fun! VimGrepWord(...) abort
    call system('git status')
    if v:shell_error ==# 0
        let l:target = '`git ls-files`'
    else
        let l:target = '**'
    endif
    if a:0 == 0
        let l:pattern = expand('<cword>')
    else
        let l:pattern = join(a:000)
    endif
    silent exe 'vimgrep /'.l:pattern.'/ '.l:target.' | cw'
endf
command! -nargs=* VimGrepWord call VimGrepWord(<f-args>)


fun! VVimGrepWord() abort range
    call system('git status')
    if v:shell_error ==# 0
        let l:target = '`git ls-files`'
    else
        let l:target = '**'
    endif
    let @@ = ''
    exe 'silent normal gvy'
    if @@ !=# ''
        let l:pattern = join(split(@@,'\n'))
        silent exe 'vimgrep /'.l:pattern.'/ '.l:target.' | cw'
    endif
endf


fun! AgWord(...) abort
    " let l:file_dir = expand('%:p:h')
    " if l:file_dir[0] !=# '/'
    "     let l:file_dir = getcwd()
    " endif
    " silent exe 'lcd '.l:file_dir
    if a:0 == 0
        let l:text = expand('<cword>')
    else
        let l:text = join(a:000)
    endif
    silent exe 'Ag '.l:text
endf
command! -nargs=* AgWord call AgWord(<f-args>)


fun! VAgWord() abort range
    " let l:file_dir = expand('%:p:h')
    " if l:file_dir[0] !=# '/'
    "     let l:file_dir = getcwd()
    " endif
    " silent exe 'lcd '.l:file_dir
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
                " case of a:1 is list
                let l:wrd = join(a:1, '+')
            endif
        else
            let l:wrd = join(a:000, '+')
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
    let l:cmd = 'w3m'
    if executable(l:cmd)
        if $HTTP_PROXY !=# ''
            let l:cmd .= printf(' -o http_proxy="%s"', $HTTP_PROXY)
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
        call term_start(l:cmd.' '.l:url)
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
            let l:text = join(a:000)
        endif
        let l:text = substitute(l:text, '"', '\\"', 'g')
        if len(l:text) < 900
            call term_start('trans {en=ja} '.'"'.l:text.'"')
        else
            echo 'Trans: [error] text too long.'
        endif
    else
        call s:install_trans()
    endif
endf
command! -range -nargs=* Trans call s:trans(<f-args>)


fun! s:transja(...) abort range
    " transコマンド(Google翻訳)を利用してvisual選択中の日本語を英語に変換する関数
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
            let l:text = join(a:000)
        endif
        let l:text = substitute(l:text, '"', '\\"', 'g')
        if len(l:text) < 900
            call term_start('trans {ja=en} '.'"'.l:text.'"')
        else
            echo 'Trans: [error] text too long.'
        endif
    else
        call s:install_trans()
    endif
endf
command! -range -nargs=* Transja call s:transja(<f-args>)


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
    silent call term_start('echo "trans command not found. installing ..."'
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
    if a:1 ==# 'acp'
        if a:0 >= 2
            let l:cmd = 'git add -A && git commit -m "'.join(a:000[1:], ' ').'" && git push -u'
        else
            let l:cmd = 'git add -A && git commit -m "`date`" && git push -u'
        endif
        call s:git_autocmd()
    elseif a:1 ==# 'pull'
        let l:cmd = 'git pull'
        call s:git_autocmd()
    elseif a:1 ==# 'fpull'
        let l:cmd = 'git reset --hard && git pull'
        call s:git_autocmd()
    elseif a:1 ==# 'diff'
        let l:cmd = 'git status -v -v'
    elseif a:1 ==# 'reset'
        let l:cmd = 'git reset --hard'
        call s:git_autocmd()
    elseif a:1 ==# 'blame'
        let l:cmd = 'git blame '.expand('%:p')
    else
        let l:cmd = 'git '.join(a:000)
    endif
    let l:script_winid = win_getid()
    let s:git_wininfo = term_start(l:cmd)
    call win_gotoid(l:script_winid)
endf
fun! s:CompletionGitCommands(ArgLead, CmdLine, CusorPos)
    return filter(['acp', 'pull', 'fpull',  'diff', 'reset', 'status', 'blame', 'show'], printf('v:val =~ "^%s"', a:ArgLead))
endf
command! -complete=customlist,s:CompletionGitCommands -nargs=* Git call s:git(<f-args>)

fun! s:git_autocmd() abort
    aug git_auto_command
        au CursorHold <buffer> call s:git_close()
    aug END
endf

fun! s:git_close() abort
    let l:script_winid = win_getid()
    if splitterm#exist(s:git_wininfo)
        \&& win_gotoid(s:git_wininfo.console_winid)
        let l:lines = getline(0, '$')
        for l:line in l:lines
            if l:line ==# '[Process exited 0]'
                quit
                edit
            endif
        endfor
        call win_gotoid(l:script_winid)
    else
        aug git_auto_command
            au!
        aug END
    endif
endf


fun! s:open() abort
    " openコマンドにより編集中ファイルを開く関数
    if executable('open')
        silent exe '!open '.expand('%:p')
    endif
endf
command! Open call s:open()
