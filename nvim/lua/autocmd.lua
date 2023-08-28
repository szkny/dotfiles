-- *****************************************************************************
--   Autocmd Rules
-- *****************************************************************************
-- IME
if vim.fn.has('mac') then
  vim.api.nvim_set_var('imeoff', 'osascript -e "tell application \"System Events\" to key code 102"')
  vim.cmd([[
    aug MyIMEGroup
      au!
      au InsertLeave * :call system(g:imeoff)
    aug END
  ]])
end

-- The PC is fast enough, do syntax highlight syncing from start unless 200 lines
vim.cmd([[
    aug vimrc_sync_fromstart
        au!
        au BufEnter * :syntax sync maxlines=200
    aug END
]])

-- Remember cursor position
vim.cmd([[
    aug vimrc_remember_cursor_position
        au!
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    aug END
]])

-- txt
vim.cmd([[
    aug vimrc_wrapping
        au!
        au BufRead,BufNewFile *.txt setlocal wrap wrapmargin=2 textwidth=79
    aug END
]])

-- make/cmake
vim.cmd([[
    aug vimrc_make_cmake
        au!
        au FileType make setlocal noexpandtab
        au BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
    aug END
]])

-- Disable visualbell
vim.cmd([[
    set noerrorbells visualbell t_vb=
    aug visualbell
        au GUIEnter * set visualbell t_vb=
    aug END
]])

-- for CRLF
vim.cmd([[
    fun! s:Applycrlfff() abort
        try
            call execute("/\\v\r$")
            edit ++ff=dos
        catch
        endtry
    endf
    aug applycrlffileformat
        au!
        au BufReadPost * call s:Applycrlfff()
    aug END
]])

-- *****************************************************************************
--   Custom configs
-- *****************************************************************************
-- c/cpp
vim.cmd([[
    aug vimrc_c_cpp
        au!
        au FileType c,cpp setlocal tabstop=4 shiftwidth=4 expandtab
    aug END
]])

-- javascript/typescript
vim.cmd([[
    aug vimrc_js_ts
        au!
        au BufNewFile,BufRead *.js,*.cjs,*.mjs setfiletype javascript
        au BufNewFile,BufRead *.ts,*.tsx setfiletype typescript
        au FileType javascript,typescript,vue setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    aug END

    fun! s:prettier() abort
        let l:pos = getpos('.')
        silent exe "0, $!prettier --stdin-filepath ".expand("%")
        call setpos('.', l:pos)
        if v:shell_error != 0
            undo
            echoerr '[ERROR] prettier failed.'
            echoerr ''
        endif
    endf
    let g:prettier_on_save = 1
    fun! s:prettier_on_save()
        if get(g:, 'prettier_on_save')
            call s:prettier()
        endif
    endf
    command! Prettier call s:prettier()
    aug PrettierSettings
        au!
        au BufWritePre *.js,*.cjs,*.mjs,*.ts,*.tsx,*.json,*.yml,*.yaml call s:prettier_on_save()
    aug END
]])

-- python
vim.cmd([[
    aug vimrc_python
        au!
        au FileType python call My_init_python()
    aug END

    fun My_init_python ()
        setlocal tabstop=4
        setlocal shiftwidth=4
        setlocal expandtab

        " initial script
        if getline(0, '$') == ['']
            call append(0,'#!/usr/bin/env python')
            call append(1,'# -*- coding: utf-8 -*-')
            call append(2,'"""')
            call append(3,'Created on '.GetNow())
            call append(4,'   @file  : '.expand('%:t'))
            call append(5,'   @author: '.$USER)
            call append(6,'   @brief :')
            call append(7,'"""')
        endif

        " mapping
        nno <silent> <leader><CR> :Ipython<CR>
        vno <silent> <leader><CR> :VIpython<CR>

        " auto command
        aug vimrc_python
            au!
            au FileType python setlocal expandtab shiftwidth=4 tabstop=4
                        \ formatoptions+=croq softtabstop=4
                        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
                        " \|let &colorcolumn=join(range(s:pythonmaxlinelength(), 300), ',')
                        " \|hi  ColorColumn guibg=#0f0f0f
            au BufNewFile,BufRead Pipfile      setfiletype toml
            au BufNewFile,BufRead Pipfile.lock setfiletype json
        aug END
        aug delimitMate
            if exists('delimitMate_version')
                au FileType python   let b:delimitMate_nesting_quotes = ['"',"'"]
            endif
        aug END
        let g:pyform_on_save = 1
        fun! s:pyform_on_save()
            if get(g:, 'pyform_on_save')
                call s:pyform()
            endif
        endf
        aug pyformSettings
            au!
            au BufWritePre *.py call s:pyform_on_save()
        aug END

        " plugin setting
        "" Ipython
        let g:ipython_startup_options = [
                    \'--no-confirm-exit',
                    \'--colors=Linux',
                    \'--no-banner']
        let g:ipython_startup_command = [
                    \'from IPython import get_ipython',
                    \'mgc = get_ipython().run_line_magic',
                    \'mgc("load_ext", "autoreload")',
                    \'mgc("autoreload", "2")',
                    \'import pandas as pd',
                    \'pd.options.display.max_rows = 10',
                    \'pd.options.display.max_columns = 10',
                    \'import warnings',
                    \'warnings.filterwarnings(action="ignore",'
                    \.' module="sklearn", message="^internal gelsd")']
        let g:ipython_window_width = 10

        " function
        fun! s:pythonmaxlinelength() abort
            " flake8のconfigファイルからpythonスクリプトの文字数上限(max-line-length)を取得する関数
            "      以下のようにcolorcolumnを設定することでバッファに文字数の上限ラインが引かれる
            "      :set colorcolumn=s:pythonmaxlinelength()
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

        fun! s:pyform(...) abort
            " autopep8やyapfに利用して編集中のPythonスクリプトを自動整形する関数
            "      :Pyform [autopep8(デフォルト) もしくは yapf]
            if &filetype ==# 'python'
                let l:formatter = 'autopep8'
                if a:0 > 0
                    let l:formatter = a:1
                endif
                if l:formatter ==# 'autopep8'
                    if !executable('autopep8')
                        echon 'Pyform: [error] autopep8 command not found.'
                        echon '                installing autopep8...'
                        if !executable('pip')
                            echoerr 'You have to install pip!'
                            return
                        endif
                        call system('pip install autopep8')
                        echon
                    endif
                    let l:pos = getpos('.')
                    silent exe '%!autopep8 -'
                    call setpos('.', l:pos)
                elseif l:formatter ==# 'yapf'
                    if !executable('yapf')
                        echon 'Pyform: [error] yapf command not found.'
                        echon '                installing yapf...'
                        if !executable('pip')
                            echoerr 'You have to install pip!'
                            return
                        endif
                        call system('pip install git+https://github.com/google/yapf')
                        echon
                    endif
                    let l:pos = getpos('.')
                    silent exe '0, $!yapf'
                    call setpos('.', l:pos)
                else
                    echon 'Pyfrom: [error] you can use autopep8 or yapf.'
                endif
            else
                echon 'Pyform: [error] invalid file type. this is "' . &filetype. '".'
            endif
        endf
        fun! s:CompletionPyformCommands(ArgLead, CmdLine, CusorPos)
            return filter(['autopep8', 'yapf'], printf('v:val =~ "^%s"', a:ArgLead))
        endf
        command! -complete=customlist,s:CompletionPyformCommands -nargs=? Pyform call s:pyform(<f-args>)
    endf
]])

