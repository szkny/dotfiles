scriptencoding utf-8
"*****************************************************************************
"" My-Functions
"*****************************************************************************

fun! BeginTerminal(width, ...)
    "" create split window
    if winwidth(0) >= winheight(0) * 3
        let l:split = 'vnew'
    else
        let l:split = 'new'
    endif
    let l:cmd1 = a:width ? a:width.l:split : l:split
    exe l:cmd1
    "" execute command
    let l:cmd2 = 'terminal'
    if a:0 > 0
        for l:i in a:000
            let l:tmp = ' '.l:i
            let l:cmd2 .= l:tmp
        endfor
    endif
    exe l:cmd2
    "" change buffer name
    let l:bufname = 'bash'
    if a:0 > 0
        let l:bufname = a:1
    endif
    while bufexists(l:bufname)
        let l:bufname = AddNameNumber(l:bufname)
    endwhile
    exe 'file ' . l:bufname
    "" visual settings & start terminal mode
    set nonumber
    startinsert
endf
command! -count -nargs=* BeginTerminal call BeginTerminal(<count>, <f-args>)


fun! AddNameNumber(name)
    let l:num = str2nr(a:name[0])
    if l:num == 0
        let l:name = '1 ' . a:name
    else
        let l:name = printf('%d', l:num+1) . a:name[1:]
    endif
    return l:name
endf


fun! ResizeWindow(size)
    if a:size ==# ''
        echo '[warning] the args "size" is empty.'
        return
    endif
    if winwidth(0) >= winheight(0) * 3
        exe 'res '.a:size
    else
        exe 'vertical res '.a:size
    endif
endf
command! -nargs=1 ResizeWindow call ResizeWindow(<f-args>)


fun! Make(width, ...)
    let l:command = 'make'
    let l:args = ''
    if a:0 > 0
        for l:i in a:000
            let l:tmp     = ' '.l:i
            let l:args .= l:tmp
        endfor
    endif
    if findfile('GNUmakefile',getcwd()) !=# '' || findfile('Makefile',getcwd()) !=# ''
        call BeginTerminal(a:width, l:command, l:args)
    elseif findfile('GNUmakefile',getcwd().'/../') !=# '' || findfile('Makefile',getcwd().'/../') !=# ''
        cd ../
        call BeginTerminal(a:width, l:command, l:args)
        cd -
    else
        echo 'not found: "GNUmakefile" or "Makefile"'
    endif
endf
command! -count -nargs=* Make call Make(<count>, <f-args>)


fun! CMake(width, ...)
    let l:builddir = 'build'
    let l:cmakelists_txt = 'CMakeLists.txt'
    let l:command = 'cmake .. && make'
    if a:0 > 0
        if a:1 ==? 'run'
            let l:exename = GetProjectName(l:cmakelists_txt)
            let l:command .= ' && ./'.l:exename
        endif
    endif
    if findfile(l:cmakelists_txt,getcwd()) !=# ''
        if finddir(l:builddir,getcwd()) ==# ''
            call mkdir(l:builddir)
        endif
        cd ./build
        call BeginTerminal(a:width, l:command)
        cd ..
    elseif findfile(l:cmakelists_txt,getcwd().'/../') !=# ''
        cd ../
        if finddir(l:builddir,getcwd()) ==# ''
            call mkdir(l:builddir)
        endif
        cd ./build
        call BeginTerminal(a:width, l:command)
        cd ..
    else
        echo 'not found: '.l:cmakelists_txt
    endif
endf
command! -count -nargs=* CMake call CMake(<count>, <f-args>)


fun! GetProjectName(cmakelists_txt)
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
command! -nargs=+ GetProjectName call GetProjectName(<f-args>)


fun! AppendChar(arg)
    let l:text = a:arg
    if l:text ==# ''
        let l:text = ';'
    endif
    let l:pos = getpos('.')
    exe ':normal A'.l:text
    call setpos('.', l:pos)
endf
command! -nargs=+ AppendChar call AppendChar(<f-args>)


fun! Python(width, ...)
    let l:command = 'python'
    if &filetype ==# 'python'
        let l:args = ' ' . expand('%')
        if findfile('Pipfile',getcwd()) !=# ''
            let l:command = 'pipenv run python'
        endif
        for l:i in a:000
            let l:args .= ' ' . l:i
        endfor
        call BeginTerminal(a:width, l:command, l:args)
    else
        call BeginTerminal(a:width, l:command)
    endif
endf
command! -count -nargs=* Python call Python(<count>, <f-args>)


fun! Ipython(width, ...)
    if executable('ipython')
        let l:command = 'ipython'
        let l:args = '--no-confirm-exit'
        if &filetype ==# 'python'
            let l:profile_name = InitIpython()
            let l:args .= ' --profile=' . l:profile_name
        endif
        call BeginTerminal(a:width, l:command, l:args)
    else
        echo 'Ipython: [error] ipython does not exist.'
    endif
endf
command! -count -nargs=* Ipython call Ipython(<count>, <f-args>)


fun! InitIpython()
    let l:ipython_root_dir = finddir('.ipython', $HOME)
    if l:ipython_root_dir !=# ''
        let l:profile_name = 'neovim'
        let l:ipython_profile_dir = finddir('profile_' . l:profile_name, l:ipython_root_dir)
        if l:ipython_profile_dir ==# ''
            echo 'initializing ipython ...'
            silent exe '!ipython profile create ' . l:profile_name
            let l:ipython_profile_dir = finddir('profile_' . l:profile_name, l:ipython_root_dir)
            if l:ipython_profile_dir ==# ''
                return
            endif
        endif
        let l:ipython_config_profile = l:ipython_profile_dir . '/ipython_config.py'
        let l:modulename = expand('%:t:r')
        let l:ipython_init_command = 'c.InteractiveShellApp.exec_lines = ["from ' . l:modulename . ' import *"]'
        call writefile([l:ipython_init_command], l:ipython_config_profile)
        return l:profile_name
    else
        echo 'Ipython: [error] ~/.ipython directory does not exist.'
    endif
endf


fun! SQL(width)
    let l:command = 'mysql'
    let l:args = ''
    if &filetype ==# 'sql'
        let l:args = ' < ' . expand('%')
    endif
    call BeginTerminal(a:width, l:command, l:args)
endf
command! -count SQL call SQL(<count>)


fun! SQLplot(width, ...)
    if &filetype ==# 'sql' && executable('sqlplot')
        let l:command = 'sqlplot'
        let l:args = ' ' . expand('%')
        call BeginTerminal(a:width, l:command, l:args)
    endif
endf
command! -count -nargs=* SQLplot call SQLplot(<count>, <f-args>)


fun! Pyplot(...)
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


fun! Gnuplot()
    if expand('%:e') ==# 'gp' || expand('%:e') ==# 'gpi'
        let l:command = 'gnuplot'
        let l:args = ' ' . expand('%')
        call BeginTerminal(0, l:command, l:args)
        starti
    else
        echo 'Gnuplot: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! -nargs=* Gnuplot call Gnuplot(<f-args>)


if executable('pdftotext')
    command! -complete=file -nargs=1 Pdf :r !pdftotext -nopgbrk -layout <q-args> -
endif


fun! Tex()
    if expand('%:e') ==# 'tex'
        let l:command = ':!platex '.expand('%')
        let l:command .= '>& /dev/null && '
        let l:dvi = expand('%:r').'.dvi'
        if findfile(l:dvi,getcwd()) !=# ''
            let l:command .= 'open -a Skim '
            exe l:command.dvi
        endif
        let l:aux = expand('%:r').'.aux'
        let l:log = expand('%:r').'.log'
        if findfile(l:aux,getcwd()) !=# ''
            call delete(l:aux)
        endif
        if findfile(l:log,getcwd()) !=# ''
            call delete(l:log)
        endif
    else
        echo 'Tex: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! Tex call Tex()


fun! SetHlsearch()
    if &hlsearch
        set nohlsearch
    else
        set hlsearch
    endif
endf


fun! GoogleSearch(...)
    let l:url = '"http://www.google.co.jp/'
    let l:opt = 'search?num=100'
    let l:wrd = ''
    if a:0 >= 1
        if a:0 == 1
            for l:i in a:1
                if l:i == a:1[0]
                    let l:wrd = l:i
                else
                    let l:wrd .= '+' . l:i
                endif
            endfor
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


fun! Chrome(...)
    let l:cmd = ''
    if has('mac')
        let l:cmd = '!open -a Google\ Chrome '
    elseif system('uname') ==# "Linux\n"
        let l:cmd = '!chrome '
    endif
    let l:cmd .= GoogleSearch(a:000)
    exe l:cmd
endf
command! -nargs=* Chrome call Chrome(<f-args>)


fun! W3m(width, ...)
    if executable('w3m')
        let l:url = GoogleSearch(a:000)
        call BeginTerminal(a:width, 'w3m', l:url)
    endif
endf
command! -count -nargs=* W3m call W3m(<count>, <f-args>)


fun! CloseBufferTab()
    try
        let l:buf_number = 0
        for l:i in range(1, bufnr('$'))
            if buflisted(l:i) == 1
                let l:buf_number += 1
            endif
        endfor
        if l:buf_number == 1
            exe 'quit'
        else
            exe 'bdelete'
            call win_gotoid(1000)
        endif
    catch
        exe 'bdelete'
        call win_gotoid(1000)
    endtry
endf
command! -nargs=* CloseBufferTab call CloseBufferTab(<f-args>)


fun! GetNow()
    let l:day = strftime('%d')
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
    let l:now .= strftime('%H:%M:%S %z (%Z) %Y')
    " let l:now = strftime('%Y-%m-%d(%a) %H:%M:%S')
    return l:now
endf


fun! VimrcGit(command)
    if &filetype ==# 'vim' || &filetype ==# 'neosnippet'
        let l:cmd = 'git '
        if a:command ==# 'push'
            let l:cmd = './gitcommit.sh'
        else
            let l:cmd .= a:command
        endif
        call BeginTerminal(0, 'cd ~/dotfiles && ' . l:cmd)
    else
        echo 'VimrcGit: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! -nargs=1 VimrcGit call VimrcGit(<f-args>)
command! Vimrc e ~/dotfiles/nvim


fun! Pyform()
    if &filetype ==# 'python'
        if executable('yapf')
            let l:pos = getpos('.')
            exe '0, $!yapf'
            call setpos('.', l:pos)
        else
            echo 'Pyform: [error] yapf command not found.'
            echo '                installing yapf...'
            if !executable('pip')
                echoerr 'You have to install pip!'
                exe 'q!'
            endif
            silent exe '!pip install git+https://github.com/google/yapf'
            echo ''
            let l:pos = getpos('.')
            exe '0, $!yapf'
            call setpos('.', l:pos)
        endif
    else
        echo 'Pyform: [error] invalid file type. this is "' . &filetype. '" file.'
    endif
endf
command! Pyform call Pyform()
