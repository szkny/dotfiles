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
        " let l:now .= strftime('%H:%M:%S %z (%Z) %Y')
        " let l:now = strftime('%Y-%m-%d(%a) %H:%M:%S')
        return l:now
    endf
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
    fun! RgPostProcess(...) abort
        cgetexpr a:000[0]
        let l:qflist = getqflist()
        if len(l:qflist) > 0
            let l:targetword = "require"
            " let l:targetword = input("Target Word: ")
            let l:replaceword = input("New Word: ")
            let l:choice = confirm(
                \ "Will you replace ".len(l:qflist)." of '".l:targetword."' with '".l:replaceword."' ?",
                \ "&Yes\n&No")
            if l:choice == 1
                exe "cdo s/".l:targetword."/".l:replaceword."/g | :w! | :cclose"
            endif
        endif
    endf
]])

vim.cmd([[
    command! Fshow exe "SplitTerm zsh -i -c fshow" | startinsert
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
