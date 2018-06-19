scriptencoding utf-8
"*****************************************************************************
"" My-Functions
"*****************************************************************************

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


fun! Make(width, ...)
    let l:command = 'make'
    if a:0 > 0
        for l:i in a:000
            let l:tmp     = ' '.l:i
            let l:command = l:command.l:tmp
        endfor
    endif
    if findfile('GNUmakefile',getcwd()) !=# '' || findfile('Makefile',getcwd()) !=# ''
        call BeginTerminal(a:width, 'sp', l:command)
    elseif findfile('GNUmakefile',getcwd().'/../') !=# '' || findfile('Makefile',getcwd().'/../') !=# ''
        cd ../
        call BeginTerminal(a:width, 'sp', l:command)
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
            let l:command = l:command.' && ./'.l:exename
        endif
    endif
    if findfile(l:cmakelists_txt,getcwd()) !=# ''
        if finddir(l:builddir,getcwd()) ==# ''
            call mkdir(l:builddir)
        endif
        cd ./build
        call BeginTerminal(a:width, 'sp', l:command)
        cd ..
    elseif findfile(l:cmakelists_txt,getcwd().'/../') !=# ''
        cd ../
        if finddir(l:builddir,getcwd()) ==# ''
            call mkdir(l:builddir)
        endif
        cd ./build
        call BeginTerminal(a:width, 'sp', l:command)
        cd ..
    else
        echo 'not found: '.l:cmakelists_txt
    endif
endf
command! -count -nargs=* CMake call CMake(<count>, <f-args>)


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
    if &filetype ==# 'python'
        if findfile('Pipfile',getcwd()) !=# ''
            let l:command = 'pipenv run python '.expand('%')
        else
            let l:command = 'python '.expand('%')
        endif
        for l:i in a:000
            let l:command = l:command.' '
            let l:command = l:command.l:i
        endfor
        call BeginTerminal(a:width, l:command)
    else
        echo 'invalid file type.'
    endif
endf
command! -count -nargs=* Python call Python(<count>, <f-args>)


fun! Ipython(width, ...)
    if executable('ipython')
        call BeginTerminal(a:width, 'ipython')
    else
        echo 'ipython does not exist.'
    endif
endf
command! -count -nargs=* Ipython call Ipython(<count>, <f-args>)


fun! SQL(width)
    if &filetype ==# 'sql'
        let l:command = 'mysql < '.expand('%')
    else
        let l:command = 'mysql'
    endif
    call BeginTerminal(a:width, 'sp', l:command)
endf
command! -count SQL call SQL(<count>)


fun! SQLplot(width, ...)
    if &filetype ==# 'sql' && executable('sqlplot')
        let l:command = 'sqlplot '.expand('%')
        call BeginTerminal(a:width, 'sp', l:command)
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
                let l:column = l:column.l:tmp
            endfor
        endif
        exe ':!pyplot %'.l:column
    endif
endf
command! -nargs=* Pyplot call Pyplot(<f-args>)


fun! Gnuplot()
    if expand('%:e') ==# 'gp' || expand('%:e') ==# 'gpi'
        let l:command = 'gnuplot '.expand('%')
        call BeginTerminal(5, 'sp', l:command)
        starti
    else
        echo 'invalid file type.'
    endif
endf
command! -nargs=* Gnuplot call Gnuplot(<f-args>)


if executable('pdftotext')
    command! -complete=file -nargs=1 Pdf :r !pdftotext -nopgbrk -layout <q-args> -
endif


fun! Tex()
    if expand('%:e') ==# 'tex'
        let l:command = ':!platex '.expand('%')
        let l:command = l:command.'>& /dev/null && '
        let l:dvi = expand('%:r').'.dvi'
        if findfile(l:dvi,getcwd()) !=# ''
            let l:command = l:command.'open -a Skim '
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
        echo 'invalid file type.'
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


let g:terminal_window_columns = 180
fun! BeginTerminal(width, ...)
    " create split window
    if &columns >= g:terminal_window_columns
        let l:split = 'vnew'
    else
        let l:split = 'new'
    endif
    let l:cmd1 = a:width ? a:width.l:split : l:split
    exe l:cmd1
    " execute command
    let l:cmd2 = 'terminal'
    if a:0 > 0
        for l:i in a:000
            let l:tmp = ' '.l:i
            let l:cmd2 = l:cmd2.l:tmp
        endfor
    endif
    exe l:cmd2
    set nonumber
    startinsert
endf
command! -count -nargs=* BeginTerminal call BeginTerminal(<count>, <f-args>)


fun! ResizeWindow(size)
    if a:size ==# ''
        echo '[warning] the args "size" is empty.'
        return
    endif
    if &columns >= g:terminal_window_columns
        exe 'vertical res '.a:size
    else
        exe 'res '.a:size
    endif
endf
command! -nargs=1 ResizeWindow call ResizeWindow(<f-args>)


fun! Google(...)
    let l:cmd = ''
    if has('mac')
        let l:cmd = '!open -a Google\ Chrome'
    elseif system('uname') ==# "Linux\n"
        let l:cmd = '!chrome'
    endif
    let l:cmd = l:cmd.' "http://www.google.co.jp/'
    let l:opt = 'search?num=100'
    let l:wrd = ''
    if a:0 >= 1
        for l:i in a:000
            if l:i == a:1
                let l:wrd = l:i
            else
                let l:wrd = l:wrd.'+'.l:i
            endif
        endfor
        let l:opt = l:opt.'&q='.l:wrd
        let l:cmd = l:cmd.l:opt
    endif
    let l:cmd = l:cmd.'"'
    exe l:cmd
endf
command! -nargs=* Google call Google(<f-args>)


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

" 各タブページのカレントバッファ名+αを表示
function! s:tabpage_label(n)
    let l:title = gettabvar(a:n, 'title')
    if l:title !=# ''
        return l:title
    endif
    let l:bufnrs = tabpagebuflist(a:n)
    let l:hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let l:no = len(l:bufnrs)
    if l:no is 1
        let l:no = ''
    endif
    " let l:mod = len(filter(copy(l:bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
    let l:mod = len(filter(copy(l:bufnrs), 'getbufvar(v:val, &modified)')) ? '+' : ''
    let l:sp = (l:no . l:mod) ==# '' ? '' : ' '  " 隙間空ける
    let l:curbufnr = l:bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
    let l:fname = pathshorten(bufname(l:curbufnr))
    let l:label = l:no . l:mod . l:sp . l:fname
    return '%' . a:n . 'T' . l:hi . l:label . '%T%#TabLineFill#'
endfunction
function! MakeTabLine()
    let l:titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
    let l:sep = ' | '  " タブ間の区切り
    let l:tabpages = join(l:titles, l:sep) . l:sep . '%#TabLineFill#%T'
    let l:info = ''  " 好きな情報を入れる
    return l:tabpages . '%=' . l:info  " タブリストを左に、情報を右に表示
endfunction
set tabline=%!MakeTabLine()

