scriptencoding utf-8
"*****************************************************************************
"" markdown ftplugin
"*****************************************************************************

" plugin setting

"" plasticboy/vim-markdown
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 1
let g:vim_markdown_folding_style_pythonic = 1

"" delimitMate
aug delimitMate
    if exists('delimitMate_version')
        au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
    endif
aug END

" "" previm
" let g:previm_show_header = 0
" let g:previm_enable_realtime = 1
" if has('mac')
"     let g:previm_open_cmd = 'open -a Google\ Chrome'
" elseif system('uname') ==# 'Linux\n'
"     let g:previm_open_cmd = 'open'
" endif
" aug PrevimSettings
"     au!
"     au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
"     au BufWritePost *.{md,mdwn,mkd,mkdn,mark*} call previm#refresh()
" aug END

"" nyaovim-popup-tooltip

"" nyaovim-markdown-preview
if exists('g:nyaovim_version')
    let g:markdown_preview_auto = 1
    let g:markdown_preview_eager = 1
    let g:markdown_preview_no_default_mapping = 0
endif


" mapping
if has('mac')
    ino <silent><buffer> …     <ESC>:Appendchar \ \ <CR>a
    no  <silent><buffer> …          :Appendchar \ \ <CR>
elseif system('uname') ==# "Linux\n"
    ino <silent><buffer> <A-;> <ESC>:Appendchar \ \ <CR>a
    no  <silent><buffer> <A-;>      :Appendchar \ \ <CR>
endif
"" bold (強調表示)
" nno <silent><nowait> <leader>m :call <SID>surround('$')<CR>
" vno <silent><nowait> <leader>m :call <SID>vsurround('$')<CR>
" nno <silent><nowait> <leader>b :call <SID>surround('**')<CR>
" " nno <silent><nowait> <leader>b :call <SID>surround('\*\*')<CR>
" vno <silent><nowait> <leader>b :call <SID>vsurround('\*\*')<CR>
" "" line (打ち消し線)
" vno <silent><nowait> <leader>l :call <SID>vsurround('\~\~')<CR>
" "" under line (下線)
vno <silent><nowait> <leader>u :call <SID>vunderline()<CR>


" function
fun!  s:surround(char) abort
    " カーソル下の単語をa:charで囲む関数
    let l:line = getline('.')
    if l:line !=# ''
        if len(a:char) == 1
            call feedkeys('ciw'.a:char.a:char."\<ESC>P")
        else
            let l:move_left = ''
            for l:i in range(len(a:char)-1)
                let l:move_left .= 'h'
            endfor
            call feedkeys('ciw'.a:char.a:char."\<ESC>".l:move_left.'P')
        endif
    endif
endf

" fun!  s:surround(char) abort
"     " カーソル下の単語をa:charで囲む関数
"     let l:line = getline('.')
"     if l:line !=# ''
"         let l:pos = getpos('.')
"         let l:word = expand('<cword>')
"         let l:formed_word = a:char.l:word.a:char
"         echo l:line l:formed_word
"         if match(l:line, l:formed_word) == -1
"             exe line('.').'s/'.l:word.'/'.l:formed_word
"         else
"             exe line('.').'s/'.l:formed_word.'/'.l:word
"         endif
"         call setpos('.', l:pos)
"     endif
" endf

fun!  s:vsurround(char) abort range
    " 選択範囲をa:charで囲む関数
    let l:line = getline('.')
    if l:line !=# ''
        let l:pos = getpos('.')
        let @@ = ''
        exe 'silent normal gvy'
        if @@ !=# ''
            let l:word = join(split(@@,'\n'))
        else
            let l:word = expand('<cword>')
        endif
        let l:formed_word = a:char.l:word.a:char
        if match(l:line, l:formed_word) == -1
            exe line('.').'s/'.l:word.'/'.l:formed_word
        else
            exe line('.').'s/'.l:formed_word.'/'.l:word
        endif
        call setpos('.', l:pos)
    endif
endf

fun!  s:vunderline() abort range
    " 選択範囲を<u>...</u>で囲む関数
    if getline('.') !=# ''
        let l:pos = getpos('.')
        let @@ = ''
        exe 'silent normal gvy'
        if @@ !=# ''
            let l:word = join(split(@@,'\n'))
        else
            let l:word = expand('<cword>')
        endif
        exe line('.').'s/'.l:word.'/'.'<u>'.l:word.'<\/u>'
        call setpos('.', l:pos)
    endif
endf
