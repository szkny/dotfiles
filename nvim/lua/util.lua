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

-- reload nvim configurations
local excluded_reload_plugins = {
  ["lazy.nvim"] = true,
  ["nvim-lspconfig"] = true,
  ["promise-async"] = true,
  ["plenary.nvim"] = true,
  ["nvim-highlight-colors"] = true,
  ["nui.nvim"] = true
}
local function reload_nvim_config()
  local dir = vim.fn.expand("~/.config/nvim/lua")
  local files = vim.fn.readdir(dir)
  for _, file in ipairs(files) do
    if vim.fn.isdirectory(dir .. "/" .. file) == 0 and file:match("%.lua$") then
      if file ~= "plugin_core.lua" then
        name = file:gsub("%.lua$", "")
        package.loaded[name] = nil
        dofile(dir .. "/" .. file)
      end
    end
  end
  local plugins = require("lazy").plugins()
  for _, plugin in ipairs(plugins) do
    if plugin._.loaded and not excluded_reload_plugins[plugin.name] then
      Try({
        function()
          vim.cmd("try | silent! Lazy reload " .. plugin.name .. " | catch | echomsg 'Error: " .. plugin.name .. " not reloaded' | endtry")
        end,
        Catch({}),
      })
    end
  end
  vim.notify("Nvim configurations reloaded!")
end
-- keymap("n", "<leader><leader>", reload_nvim_config, opts)
vim.api.nvim_create_user_command("ReloadConfig", reload_nvim_config, {})
