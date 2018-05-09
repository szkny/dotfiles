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
        call BeginTerminal(a:width, l:command)
    elseif findfile('GNUmakefile',getcwd().'/../') !=# '' || findfile('Makefile',getcwd().'/../') !=# ''
        cd ../
        call BeginTerminal(a:width, l:command)
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
        let l:command = 'python '.expand('%')
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


fun! Pyplot(...)
    if &filetype ==# 'text'
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
        call BeginTerminal(5, l:command)
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


fun! RangeChooser()
    let l:tmp = tmpname()
    " The option '--choosefiles' was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(l:tmp)
    if has('gui_running')
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(l:tmp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(l:tmp)
    endif
    if !filereadable(l:tmp)
        redraw!
        " Nothing to read.
        return
    endif
    let l:names = readfile(l:tmp)
    if empty(l:names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(l:names[0])
    " Add any remaning items to the arg list/buffer list.
    for l:name in l:names[1:]
        exec 'argadd ' . fnameescape(l:name)
    endfor
    redraw!
endf
command! -bar RangerChooser call RangeChooser()


fun! SetHlsearch()
    if &hlsearch
        set nohlsearch
    else
        set hlsearch
    endif
endf


fun! BeginTerminal(width, ...)
    " create split window
    let l:cmd1 = 'new'
    let l:cmd1 = a:width ? a:width.l:cmd1 : l:cmd1
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
    " call indent_guides#disable()
    startinsert
endf
command! -count -nargs=* BeginTerminal call BeginTerminal(<count>, <f-args>)


fun! EndTerminal()
    " call indent_guides#enable()
    startinsert
endf


fun! Google(...)
    let l:cmd = '!open -a Google\ Chrome "http://www.google.co.jp/'
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
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif
  let bufnrs = tabpagebuflist(a:n)
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let fname = pathshorten(bufname(curbufnr))
  let label = no . mod . sp . fname
  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction
function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let info = ''  " 好きな情報を入れる
  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction
set tabline=%!MakeTabLine()
