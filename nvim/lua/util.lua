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
    "      :Term [Command] で任意のシェルコマンドを実行
    let l:current_dir = getcwd()
    let l:basepath = expand('%:p:h')
    if l:basepath[0] !=# '/'
        let l:basepath = getcwd()
    endif
    " execute command
    let l:cmd = 'terminal '.join(a:000)
    if a:0 > 0
      let l:cmd = l:cmd.'; read -q'
    endif
    silent enew
    " silent exe 'lcd ' . l:basepath
    silent exe l:cmd
    silent exe 'lcd ' . l:current_dir
    " " change buffer name
    " if a:0 == 0
    "   let l:num = 1
    "   let l:name = split('zsh',' ')[0]
    "   while bufexists(l:num.':'.l:name)
    "       let l:num += 1
    "   endwhile
    "   exe 'file '.l:num.':'.l:name
    " elseif a:0 > 0
    "   let l:num = 1
    "   let l:name = split(a:1,' ')[0]
    "   while bufexists(l:num.':'.l:name)
    "       let l:num += 1
    "   endwhile
    "   exe 'file '.l:num.':'.l:name
    " endif
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
command! -nargs=* Term call Term(<f-args>)
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
            let l:text = substitute(l:text, '%', '\\%', 'g')
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
            let l:text = substitute(l:text, '`', '\\`', 'g')
            let l:text = substitute(l:text, '%', '\\%', 'g')
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
            silent exe '!open '.expand('%')
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

vim.cmd([[
    fun! s:delta(...) abort
      exe "1000SplitTerm file=$(fzf) && delta -s --paging always "..expand("%").." $file"
      startinsert
    endf
    command! -nargs=* Delta call s:delta(<f-args>)
]])

vim.cmd([[
    fun! s:google(...) abort
      let l:word = ''
      if a:0 > 0
        let l:word = '/search?q='.join(a:000, '&q=')
      endif
      exe 'term w3m "google.com' . l:word . '"'
      exe 'file Google Search'
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
      startinsert
    endf
    command! -nargs=* Google call s:google(<f-args>)
]])

function Catch(what)
	return what[1]
end

function Try(what)
	local status, result = pcall(what[1])
	if not status then
		what[2](result)
	end
	return result
end

function Dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. Dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local function oil_ssh_term()
	local fname = vim.fn.expand("%:p")
	if type(fname) == "table" then
		fname = fname[0]
	end
	local protocol, target, path = string.match(fname, "^(.+)://(.-)%/(.+)")
	if protocol ~= "oil-ssh" then
		path = fname
	end
	local basepath = path:match("(.*" .. "/" .. ")")
	if basepath == nil then
		basepath = vim.fn.expand("%:p:h")
	end
	local command
	if protocol == "oil-ssh" then
		command = "ssh " .. target .. " -t 'cd \\'" .. basepath .. "\\' && $SHELL'"
	else
		command = "cd \\'" .. basepath .. "\\' && $SHELL"
	end
	vim.cmd('call splitterm#open_width(18, "' .. command .. '")')
	vim.cmd("startinsert")
end
vim.api.nvim_create_user_command("OilSshTerm", oil_ssh_term, { bang = true, nargs = "?" })
return {
	oil_ssh_term = oil_ssh_term,
}
