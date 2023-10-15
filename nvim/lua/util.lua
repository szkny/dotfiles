-- *****************************************************************************
--   Utilities
-- *****************************************************************************

vim.cmd([[
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
        return l:now
    endf
]])

vim.cmd([[
fun! Term(...) abort
    " 新規バッファでターミナルモードを開始する関数
    "      :NewTerm [Command] で任意のシェルコマンドを実行
    let l:current_dir = expand('%:p:h')
    if l:current_dir[0] !=# '/'
        let l:current_dir = getcwd()
    endif
    " execute command
    let l:cmd = 'terminal '.join(a:000)
    if a:0 > 0
      let l:cmd = l:cmd.'; read -q'
    endif
    silent enew
    silent exe 'lcd ' . l:current_dir
    silent exe l:cmd
    " change buffer name
    if a:0 == 0
      let l:num = 1
      let l:name = split('zsh',' ')[0]
      while bufexists(l:num.':'.l:name)
          let l:num += 1
      endwhile
      exe 'file '.l:num.':'.l:name
    elseif a:0 > 0
      let l:num = 1
      let l:name = split(a:1,' ')[0]
      while bufexists(l:num.':'.l:name)
          let l:num += 1
      endwhile
      exe 'file '.l:num.':'.l:name
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
command! -complete=shellcmd -nargs=* Term call Term(<f-args>)
]])

vim.cmd([[
    fun! s:trans(...) abort range
        " transコマンド(Google翻訳)を利用してvisual選択中の文字列を日本語変換する関数
        if executable('trans')
            let l:text = ''
            if a:0 == 0
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
            let l:text = substitute(l:text, '`', '\\`', 'g')
            if len(l:text) < 900
                call splitterm#open('trans', '{en=ja}', '"'.l:text.'"', ' ; read -q')
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
            if a:0 == 0
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
                call splitterm#open('trans', '{ja=en}', '"'.l:text.'"', ' ; read -q')
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
        silent call splitterm#open('(echo "trans command not found. installing ..."'
                                 \.' && '.l:install_cmd
                                 \.' && echo " Success !!"'
                                 \.' && echo " you can do \":Trans [WORD]\".")'
                                 \.' ; read -q')
        startinsert
    endf
]])

vim.cmd([[
    fun! s:open() abort
        " openコマンドにより編集中ファイルを開く関数
        if executable('open')
            silent exe '!open '.expand('%:p')
        endif
    endf
    command! Open call s:open()
]])

vim.cmd([[
    command! Fshow exe "SplitTerm zsh -i -c fshow" | startinsert
]])

vim.cmd([[
    fun! s:viu(...) abort
        if executable('viu')
            if a:0 == 0
                let l:filepath = expand('%:p')
            else
                let l:filepath = join(a:000)
            endif
            call splitterm#open_width(1000, 'viu', l:filepath, '; read -q')
        else
            echo "command not found: viu"
        endif
    endf
    command! -nargs=* Viu call s:viu(<f-args>)
]])

function catch(what)
   return what[1]
end

function try(what)
   local status, result = pcall(what[1])
   if not status then
      what[2](result)
   end
   return result
end
