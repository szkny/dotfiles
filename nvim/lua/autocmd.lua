-- *****************************************************************************
--   Autocmd Rules
-- *****************************************************************************

-- txt
vim.cmd([[
    aug vimrc_wrapping
        au!
        au BufRead,BufNewFile *.txt setlocal wrap wrapmargin=2 textwidth=1000
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

-- vimscript/lua
vim.cmd([[
    aug vimrc_vimscript_lua
        au!
        au FileType vim,lua setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    aug END
]])

-- javascript/typescript
vim.cmd([[
    aug vimrc_js_ts
        au!
        au BufNewFile,BufRead *.js,*.cjs,*.mjs setfiletype javascript
        au BufNewFile,BufRead *.ts,*.tsx setfiletype typescript
        au FileType javascript,typescript,vue,html,css,json,yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    aug END
]])

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "bun.lockb",
  callback = function()
    local path = vim.fn.expand("%:p")
    local output = vim.fn.systemlist("bun " .. path)
    if output then
      vim.api.nvim_buf_set_lines(0, 0, -1, true, output)
    end
    vim.opt_local.filetype = "conf"
    vim.opt_local.readonly = true
    vim.opt_local.modifiable = false
  end,
})

-- python
vim.cmd([[
    aug vimrc_python
        au!
        au FileType python call My_init_python()
    aug END

    fun! My_init_python ()
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
    endf
]])
