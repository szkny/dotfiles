scriptencoding utf-8
"*****************************************************************************
"" My-Functions
"*****************************************************************************

fun! ChangeBuffer(direction)
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
        set nonumber
    else
        set number
    endif
endf
command! -nargs=1 ChangeBuffer call ChangeBuffer(<f-args>)


fun! BeginTerm(width, ...)
    let l:min_winwidth = 80
    let l:min_winheight = 30
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
command! -count -nargs=* BeginTerm call BeginTerm(<count>, <f-args>)


fun! NewTerm(...)
    let l:current_dir = expand('%:p:h')
    if l:current_dir[0] !=# '/'
        let l:current_dir = getcwd()
    endif
    "" execute command
    let l:cmd = 'terminal'
    if a:0 > 0
        for l:i in a:000
            let l:cmd .= ' '.l:i
        endfor
    endif
    exe 'enew'
    exe 'lcd ' . l:current_dir
    exe l:cmd
    "" change buffer name
    if a:0 == 0
        let l:bufname = GetNewBufName('bash')
    elseif a:0 > 0
        let l:bufname = GetNewBufName(a:1)
    endif
    exe 'file '.l:bufname
    "" visual settings & start terminal mode
    set nonumber
    startinsert
endf
command! -nargs=* NewTerm call NewTerm(<f-args>)


fun! SplitTerm(width, ...)
    let l:current_dir = expand('%:p:h')
    if l:current_dir[0] !=# '/'
        let l:current_dir = getcwd()
    endif
    "" create split window
    let l:width = Vsplitwidth()
    if l:width
        let l:width = a:width ? a:width : l:width
        let l:split = l:width.'vnew'
    else
        let l:height = Splitheight()
        let l:height = a:width ? a:width : l:height
        let l:split = l:height? l:height.'new' : '20new'
    endif
    exe l:split
    exe 'lcd ' . l:current_dir
    "" execute command
    let l:cmd2 = 'terminal'
    if a:0 > 0
        for l:i in a:000
            let l:cmd2 .= ' '.l:i
        endfor
    endif
    exe l:cmd2
    "" change buffer name
    if a:0 == 0
        let l:bufname = GetNewBufName('bash')
    elseif a:0 > 0
        let l:bufname = GetNewBufName(a:1)
    endif
    exe 'file '.l:bufname
    "" visual settings & start terminal mode
    set nonumber
    startinsert
endf
command! -count -nargs=* SplitTerm call SplitTerm(<count>, <f-args>)


fun! GetNewBufName(name)
    let l:num = 1
    let l:name = l:num.' '.a:name
    while bufexists(l:name)
        let l:num += 1
        let l:name = l:num.l:name[1:]
    endwhile
    return l:name
endf


fun! Splitheight()
    let l:min_winheight = 10
    let l:max_winheight = winheight(0)/2
    "" ## count max line length ##
    let l:height = winheight(0)-line('$')
    let l:height = l:height>l:min_winheight ? l:height : 0
    let l:height = l:height>l:max_winheight ? l:max_winheight : l:height
    return l:height
endf


fun! Vsplitwidth()
    let l:min_winwidth = 80
    let l:max_winwidth = winwidth(0)/2
    "" ## count max line length ##
    let l:all_lines = getline(0, '$')
    let l:max_line_len = 0
    for l:line in l:all_lines
        if len(l:line) > l:max_line_len
            let l:max_line_len = len(l:line)
        endif
    endfor
    let l:max_line_len += 1
    "" ## count line number width ##
    let l:linenumwidth = 0
    if &number
        "" add line number width
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
    "" add ale sign line width
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


fun! ResizeWindow(size)
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


fun! Make(width, ...)
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


fun! CMake(width, ...)
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
command! -count -nargs=* Python call Python(<count>, <f-args>)


fun! Ipython(width, ...)
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
command! -count -nargs=* Ipython call Ipython(<count>, <f-args>)


fun! InitIpython()
    let l:profile_name = 'neovim'
    let l:ipython_profile_dir = $HOME . '/.ipython/profile_' . l:profile_name
    let l:ipython_startup_dir = l:ipython_profile_dir . '/startup'
    if finddir(l:ipython_startup_dir) ==# ''
        call mkdir(l:ipython_startup_dir, 'p')
    endif
    let l:modulename = expand('%:t:r')
    let l:ipython_init_command = ['from ' . l:modulename . ' import *']
    let l:ipython_startup_file = l:ipython_startup_dir . '/startup.py'
    call writefile(l:ipython_init_command, l:ipython_startup_file)
    return l:profile_name
endf


fun! PythonMaxLineLength()
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


fun! Pyform(...)
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
command! -nargs=* Pyform call Pyform(<f-args>)


fun! Pudb()
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


fun! SQL(width)
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


fun! SQLplot(width, ...)
    if &filetype ==# 'sql' && executable('sqlplot')
        let l:command = 'sqlplot'
        let l:args = ' ' . expand('%')
        call BeginTerm(a:width, l:command, l:args)
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
        call BeginTerm(a:width, 'w3m -M', l:url)
    else
        echo 'W3m: [error] w3m command not found.'
    endif
endf
command! -count -nargs=* W3m call W3m(<count>, <f-args>)


fun! CloseBufferTab()
    if winnr() == 1
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
    else " split window exist
        exe 'quit'
    endif
endf
command! -nargs=* CloseBufferTab call CloseBufferTab(<f-args>)


fun! GetNow()
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


fun! Git(command)
    if a:command ==# 'diff'
        let l:cmd = 'git status -v -v'
    elseif a:command ==# 'routin'
        let l:cmd = 'git add . && git commit -m "`date`" && git push'
    else
        let l:cmd = 'git '.a:command
    endif
    call BeginTerm(0, l:cmd)
endf
command! -nargs=1 Git call Git(<f-args>)


fun! VimrcGit(command)
    let l:dotfiles_dir = $HOME.'/dotfiles'
    if split(expand('%:p:h'), '/')[:2] == split(l:dotfiles_dir, '/')
        if a:command ==# 'push'
            let l:cmd = './gitcommit.sh'
        elseif a:command ==# 'diff'
            let l:cmd = 'git status -v -v'
        else
            let l:cmd = 'git '.a:command
        endif
        let l:cmd = 'cd '.l:dotfiles_dir.' && '.l:cmd
        call BeginTerm(0, l:cmd)
    else
        echo 'VimrcGit: [error] "'.expand('%:t').'" is not under the control of git.'
    endif
endf
command! -nargs=1 VimrcGit call VimrcGit(<f-args>)
command! Vimrc e ~/dotfiles/nvim
