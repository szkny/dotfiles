
function! Make(...)
	let l:command = "make"
	if a:0 > 0
		for i in a:000
			let l:tmp     = " ".i
			let l:command = l:command.l:tmp
		endfor
	endif
	if findfile("GNUmakefile",getcwd()) != "" || findfile("Makefile",getcwd()) != ""
		exe l:command
	elseif findfile("GNUmakefile",getcwd()."/../") != "" || findfile("Makefile",getcwd()."/../") != ""
		cd ../
		exe l:command
		cd -
	else
		echo "Makefileが存在しません."
	endif
endfunction
command! -nargs=* Make call Make(<f-args>)


function! AppendChar(arg)
	let l:text = a:arg
	if text == ""
		let text = ";"
	endif
	let l:pos = getpos(".")
	exe ":normal A".text
	call setpos('.', pos)
endfunction
command! -nargs=+ AppendChar call AppendChar(<f-args>)


function! PyPlot(...)
	if expand("%:e") == "txt"
		if a:0 == 0
			let l:column = " -u1"
		elseif a:0 == 1
			let l:column = " -u".a:1
		elseif a:0 >= 2
			let l:column = " -n".a:0
			for i in a:000
				let l:tmp  = " -u".i
				let l:column = l:column.l:tmp
			endfor
		endif
		exe ":!pyplot %".l:column
	endif
endfunction
command! -nargs=* PyPlot call PyPlot(<f-args>)


function! GnuPlot(arg1)
	if expand(a:arg1.":e") == "gp" || expand(a:arg1.":e") == "gpi"
		let l:command = ":!gnuplot ".a:arg1
		exe command
	else
		echo "invalid file type."
	endif
endfunction
command! -nargs=+ GnuPlot call GnuPlot(<f-args>)


if executable('pdftotext')
    command! -complete=file -nargs=1 Pdf :r !pdftotext -nopgbrk -layout <q-args> -
endif


function! Tex()
	if expand("%:e") == "tex"
		let l:command = ":!platex ".expand("%")
		let command = command.">& /dev/null && "
		let l:dvi = expand("%:r").".dvi"
		if findfile(dvi,getcwd()) != ""
			let command = command."open -a Skim "
			exe command.dvi
		endif
		let l:aux = expand("%:r").".aux"
		let l:log = expand("%:r").".log"
		if findfile(aux,getcwd()) != ""
			call delete(aux)
		endif
		if findfile(log,getcwd()) != ""
			call delete(log)
		endif
	else
		echo "invalid file type."
	endif
endfunction
command! Tex call Tex()


function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()


function! SetHlsearch()
	if &hlsearch
		set nohlsearch
	else
		set hlsearch
	endif
endfunction

