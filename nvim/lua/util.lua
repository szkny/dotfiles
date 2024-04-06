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
    fun! s:open() abort
        " openコマンドにより編集中ファイルを開く関数
        if executable('open')
            silent exe '!open '.expand('%')
        endif
    endf
    command! Open call s:open()
]])

vim.cmd([[
    fun! s:google(...) abort
      let l:current_dir = getcwd()
      let l:word = ''
      if a:0 > 0
        let l:word = '/search?q='.join(a:000, '&q=')
      endif
      silent enew
      silent exe 'term w3m "google.com' . l:word . '"'
      " silent exe 'file Google Search'
      silent exe 'lcd ' . l:current_dir
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
