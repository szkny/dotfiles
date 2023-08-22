-- *****************************************************************************
--   Key-Mappings
-- *****************************************************************************
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- general
keymap("n", "<leader><leader>", "<CMD>Reload<CR>", opts)
keymap("t", "<C-[>", "<C-\\><C-n>", opts)
keymap("t", "<ESC>", "<C-\\><C-n><Plug>(esc)", { noremap = true })
keymap("n", "<Plug>(esc)<ESC>", "i<ESC>", opts)
keymap("i", "<C-s>", function() vim.cmd('w!') end, opts)
keymap("n", "<C-s>", function() vim.cmd('w!') end, opts)
keymap("n", "q",
    function()
        try {
            function()
                vim.cmd('q')
            end,
            catch {
                function(error)
                    print('caught error: ' .. error)
                    -- print('E173: some files to edit')
                end
            }
        }
    end,
    opts)
keymap("n", "<S-q>", function() vim.cmd('qall') end, opts)
keymap("n", "<Leader>q",  ":bnext    |try|bdelete#|catch|bdelete|endtry|redraw!<CR>", opts)
keymap("n", "<Leader>bq", ":bnext    |try|bdelete#|catch|bdelete|endtry|redraw!<CR>", opts)
keymap("n", "<Leader>pq", ":bprevious|try|bdelete#|catch|bdelete|endtry|redraw!<CR>", opts)

-- for edit
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("n", "<C-d>", "ReplaceWordText()  !=# '' ? ':<C-u>'.  ReplaceWordText().'<Left><Left><Left>' : '<ESC>'", { expr = true })
vim.api.nvim_set_keymap("v", "<C-d>", "VReplaceWordText() !=# '' ? ':<C-u>'. VReplaceWordText().'<Left><Left><Left>' : '<ESC>'", { expr = true })
vim.cmd([[
    fun! s:get_vselect_txt()
        if mode()=="v"
            let [line_start, column_start] = getpos("v")[1:2]
            let [line_end, column_end] = getpos(".")[1:2]
        else
            let [line_start, column_start] = getpos("'<")[1:2]
            let [line_end, column_end] = getpos("'>")[1:2]
        end
        if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
            let [line_start, column_start, line_end, column_end] =
            \   [line_end, column_end, line_start, column_start]
        end
        let lines = getline(line_start, line_end)
        if len(lines) == 0
                return ''
        endif
        let lines[-1] = lines[-1][: column_end - 1]
        let lines[0] = lines[0][column_start - 1:]
        return join(lines, "\n")
    endf
    fun! ReplaceWordText() abort
        let l:target = expand('<cword>')
        if l:target !=# ''
            return line('.').',$s/'.l:target.'//gc'
        else
            return ''
        endif
    endf
    fun! VReplaceWordText() abort range
        let l:target = s:get_vselect_txt()
        if l:target !=# ''
            return line('.').',$s/'.l:target.'//gc'
        else
            return ''
        endif
    endf
]])
keymap("n", "<leader>r",
    function ()
        vim.cmd([[
            fun! Rg_to_qf(line)
                let parts = split(a:line, ':')
                return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
                      \ 'text': join(parts[3:], ':')}
            endf

            fun! RgToQF(query)
              call setqflist(map(systemlist('rg --column '.a:query), 'Rg_to_qf(v:val)'))
            endf

            let wordUnderCursor = expand("<cword>")
            call inputsave()
            let wordToReplace = input("Replace : ", wordUnderCursor)
            call inputrestore()
            call inputsave()
            let replacement = input("Replace \"" . wordToReplace . "\" with: ")
            call inputrestore()
            call RgToQF(wordUnderCursor)
            let numqf = len(getqflist())
            let choice = confirm(
                \ "Will you replace ".numqf." of '".wordToReplace."' with '".replacement."' ?",
                \ "&Yes\n&No\n&Check")
            if choice == 1
                exe "cdo s/" . wordToReplace . "/" . replacement ."/g | w"
            elseif choice == 3
                exe "cdo s/" . wordToReplace . "/" . replacement ."/gc | w"
            endif
        ]])
        -- local qflist = vim.fn.getqflist()
        -- if #qflist > 0 then
        --     local targetword = vim.fn.input("Target Word: ")
        --     local replaceword = vim.fn.input("New Word: ")
        --     local numreplace = 0
        --     for i = 1,#qflist do
        --         if string.find(qflist[i]["text"], targetword) then
        --             numreplace = numreplace + 1
        --         end
        --     end
        --     if numreplace > 0 then
        --         local choice = vim.fn.confirm(
        --             "Will you replace "..numreplace.." of '"..targetword.."' with '"..replaceword.."' ?",
        --             "&Yes\n&No"
        --         )
        --         if choice == 1 then
        --             vim.cmd("cdo s/"..targetword.."/"..replaceword.."/g | :w!")
        --         end
        --     else
        --         print("not found: '"..targetword.."'")
        --     end
        -- end
    end,
    opts
)

-- -- for tab/window
-- keymap("n", "<Right>", ":ChangeBuffer next<CR>",     opts)
-- keymap("n", "<Left>",  ":ChangeBuffer previous<CR>", opts)
keymap("n", "<Right>", ":BufferLineCycleNext<CR>",   opts)
keymap("n", "<Left>",  ":BufferLineCyclePrev<CR>",   opts)
keymap("n", "<M-l>",   ":BufferLineCycleNext<CR>",   opts)
keymap("n", "<M-h>",   ":BufferLineCyclePrev<CR>",   opts)
keymap("n", "<TAB>",   ":buffer#<CR>",               opts)
keymap("n", "<Up>",    ":ResizeWindow +1<CR>",       opts)
keymap("n", "<Down>",  ":ResizeWindow -1<CR>",       opts)
vim.cmd([[
    fun! s:changebuffer(direction) abort
        " バッファタブを切り替える関数
        " directionにはnextかpreviousを指定する
        if tabpagenr('$') == 1
            if &buflisted
                if a:direction ==? 'next' || a:direction ==? 'n'
                    let l:cmd = 'bnext'
                elseif a:direction ==? 'previous' || a:direction ==? 'p'
                    let l:cmd = 'bprevious'
                else
                    return
                endif
                exe l:cmd
                if &buftype ==? 'terminal'
                    setlocal nonumber
                else
                    setlocal number
                endif
            endif
        else
            if a:direction ==? 'next' || a:direction ==? 'n'
                let l:cmd = 'tabnext'
            elseif a:direction ==? 'previous' || a:direction ==? 'p'
                let l:cmd = 'tabprevious'
            else
                return
            endif
            exe l:cmd
        endif
    endf
    command! -nargs=1 ChangeBuffer call s:changebuffer(<f-args>)
    fun! s:resizewindow(size) abort
        " 分割ウィンドウの高さと幅を調節する関数
        "      :ResizeWindow + でカレントウィンドウを広くする
        "      :ResizeWindow - でカレントウィンドウを狭くする
        "      以下のマッピングがおすすめ
        "      nno +  :ResizeWindow +<CR>
        "      nno -  :ResizeWindow -<CR>
        if a:size ==# ''
            echon '[warning] the args "size" is empty.'
            return
        endif
        if winwidth(0) >= winheight(0)*3
            exe 'res '.a:size
        else
            exe 'vertical res '.a:size
        endif
    endf
    command! -nargs=1 ResizeWindow call s:resizewindow(<f-args>)
]])

-- for yank/delete/paste
keymap("n", "c",  "\"_c",   opts)
keymap("v", "c",  "\"_c",   opts)
keymap("n", "C",  "\"_C",   opts)
keymap("v", "C",  "\"_C",   opts)
keymap("n", "s",  "\"_s",   opts)
keymap("v", "s",  "\"_s",   opts)
keymap("n", "S",  "\"_S",   opts)
keymap("v", "S",  "\"_S",   opts)
keymap("n", "x",  "\"_x",   opts)
keymap("v", "x",  "\"_x",   opts)
keymap("v", "p",  "\"_dP",  opts)
keymap("n", "D",  "\"_D",   opts)
keymap("n", "de", "\"_de",  opts)
keymap("n", "dw", "b\"_de", opts)

-- for cursor move
keymap("n", "j",     "gj",         opts)
keymap("n", "k",     "gk",         opts)
keymap("i", "<C-h>", "<Left>",     opts)
keymap("i", "<C-l>", "<Right>",    opts)
keymap("n", "<S-h>", "10h",        opts)
keymap("n", "<S-j>", "5gj",        opts)
keymap("n", "<S-k>", "5gk",        opts)
keymap("n", "<S-l>", "10l",        opts)
keymap("v", "<S-h>", "10h",        opts)
keymap("v", "<S-j>", "5gj",        opts)
keymap("v", "<S-k>", "5gk",        opts)
keymap("v", "<S-l>", "10l",        opts)
keymap("i", "<M-h>", "<Left>",     opts)
keymap("i", "<M-j>", "<Down>",     opts)
keymap("i", "<M-k>", "<Up>",       opts)
keymap("i", "<M-l>", "<Right>",    opts)
keymap("t", "<M-h>", "<Left>",     opts)
keymap("t", "<M-j>", "<Down>",     opts)
keymap("t", "<M-k>", "<Up>",       opts)
keymap("t", "<M-l>", "<Right>",    opts)
keymap("n", "<M-u>", "<PageUp>",   opts)
keymap("n", "<M-d>", "<PageDown>", opts)
keymap("c", "<C-a>", "<Home>",     opts)
keymap("c", "<C-e>", "<End>",      opts)

-- for IME
keymap("n", "あ",   "a",  opts)
keymap("n", "い",   "i",  opts)
keymap("n", "う",   "u",  opts)
keymap("n", "お",   "o",  opts)
keymap("n", "ｒ",   "r",  opts)
keymap("n", "ｊ",   "gj", opts)
keymap("n", "ｋ",   "gj", opts)
keymap("n", "ｌ",   "l",  opts)
keymap("n", "ｈ",   "h",  opts)
keymap("n", "ｐ",   "p",  opts)
keymap("n", "ｄｄ", "dd", opts)
keymap("n", "ｙｙ", "yy", opts)

-- for Plugins
-- -- vim-easy-align
keymap("v", "<Leader>=",  ":EasyAlign *=<CR>",        opts)
keymap("v", "<Enter>",    "<Plug>(EasyAlign)",        opts)
-- -- fuzzy-motion
keymap("n", "<Leader>/",  ":FuzzyMotion<CR>",         opts)
-- -- fzf.vim
keymap("n", "<C-b>",      ":<C-u>Buffers<CR>",        opts)
keymap("n", "<C-p>",      ":<C-u>Files<CR>",          opts)
keymap("n", "<Leader>f",  ":<C-u>Lines<CR>",          opts)
keymap("n", "<C-f>",      ":<C-u>Rg<CR>",             opts)
keymap("v", "<C-f>",      ":<C-u>call VRgWord()<CR>", opts)
vim.cmd([[
fun! VRgWord() abort range
    let @@ = ''
    exe 'silent normal gvy'
    if @@ !=# ''
        let l:text = join(split(@@,'\n'))
        silent exe 'Rg '.l:text
    endif
endf
]])
-- -- ranger.vim
keymap("n", "<C-h>",      ":<C-u>RnvimrToggle<CR>",   opts)
-- -- nvim-tree
keymap("n", "<C-n>",      ":<C-u>NvimTreeToggle<CR>", opts)
-- -- oil.nvim
keymap("n", "<Leader>o",  require('oil').open_float, opts)
keymap("n", "<Leader>t",
    function()
        local fname = vim.fn.expand("%:p")
        local protocol, target, path = string.match(fname, "^(.+)://(.-)%/(.+)")
        if protocol ~= "oil-ssh" then
            path = fname
        end
        local basepath = path:match("(.*".."/"..")")
        if basepath == nil then
            basepath = vim.fn.expand("%:p:h")
        end
        local command
        if protocol == "oil-ssh" then
            command = "ssh "..target.." -t 'cd \\'"..basepath.."\\' && $SHELL'"
        else
            command = "cd \\'"..basepath.."\\' && $SHELL"
        end
        vim.cmd('call splitterm#open_width(18, "'..command..'")')
        vim.cmd("startinsert")
    end,
    opts
)
-- -- SplitTerm
keymap("n", "t",          ":<C-u>18SplitTerm<CR>i",                     opts )
-- -- vista.vim
keymap("n", "<C-t>",      ":<C-u>Vista!!<CR>",                          opts )
keymap("n", "<C-g>",      ":<C-u>Vista finder<CR>",                     opts )
-- -- minimap.vim
keymap("n", "<C-k>",      ":<C-u>MinimapToggle<CR>:MinimapRefresh<CR>", opts )
-- -- fugitive
keymap("n", "<Leader>gg", ":<C-u>G<CR>",                                opts )
keymap("n", "<Leader>gd", ":<C-u>Gvdiffsplit<CR>",                      opts )
-- -- lazygit
keymap("n", "<Leader>lg", ":<C-u>100SplitTerm lazygit<CR>i",            opts )
-- -- gitsigns.nvim
keymap("n", "<Leader>gb", require("gitsigns").toggle_current_line_blame, opts )

vim.cmd([[
fun DdcMapping() abort
    "" ddc.vim (with pum.vim)
    ino <silent> <C-n> <Cmd>call pum#map#select_relative(+1)<CR>
    ino <silent> <C-p> <Cmd>call pum#map#select_relative(-1)<CR>
    ino <silent> <expr> <CR>
      \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
    ino <silent> <expr> <C-e>
      \ pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'
    ino <silent> <expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<TAB>'
    ino <silent> <expr> <S-TAB>
      \ pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<S-TAB>'
    ino <silent> <expr> <DOWN>
      \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<DOWN>'
    ino <silent> <expr> <UP>
      \ pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<UP>'
    " if get(g:, 'use_coc_nvim', 0) == 0 && get(g:, 'use_mason_nvim', 0) == 0
    "     "" vim-lsp
    "     nno <silent><nowait> <C-]>     :<C-u>LspDefinition<CR>
    "     nno <silent><nowait> <leader>] :<C-u>LspDefinition<CR>
    "     nno <silent><nowait> <leader>[ :<C-u>LspReferences<CR>
    "     nno <silent><nowait> <leader>k :<C-u>LspHover<CR>
    "     nno <silent><nowait> <leader>n :<C-u>LspNextDiagnostic<CR>
    "     nno <silent><nowait> <leader>p :<C-u>LspPreviousDiagnostic<CR>
    "     " nno <silent><nowait> <leader>r :<C-u>LspRename<CR>
    "     nno <silent><nowait> <leader>l :<C-u>LspDocumentDiagnostics<CR>
    "     nno <silent><nowait> <leader>h :<C-u>LspCodeAction<CR>
    " endif
endf
if get(g:, 'use_coc_nvim', 0) == 0 && get(g:, 'use_mason_nvim', 0) == 0
    call DdcMapping()
endif
nno          :     <Cmd>call DdcCommandlinePre()<CR>:
nno          /     <Cmd>call DdcCommandlinePre()<CR>/
cno <expr> <C-n>
  \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<DOWN>'
cno <expr> <C-p>
  \ pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<UP>'
cno <expr> <CR>
  \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
cno <expr> <C-e>
  \ pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'
cno <expr> <TAB>
  \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : ''
cno <expr> <S-TAB>
  \ pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : ''
cno <expr> <DOWN>
  \ pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<DOWN>'
cno <expr> <UP>
  \ pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<UP>'
]])

-- -- skkeleton
keymap("i", "<C-j>", "<Plug>(skkeleton-enable)",  opts)
keymap("c", "<C-j>", "<Plug>(skkeleton-enable)",  opts)
keymap("i", "<C-l>", "<Plug>(skkeleton-disable)", opts)
keymap("c", "<C-l>", "<Plug>(skkeleton-disable)", opts)

-- for My Commands
keymap("i", "<M-;>", "<ESC>:Appendchar ;<Cr>a",      opts)
keymap("n", "<M-;>",      ":Appendchar ;<Cr>",       opts)
keymap("v", "<M-;>",      ":Appendchar ;<Cr>",       opts)
keymap("v", "<Leader>t",  ":Trans<CR>",              opts)
keymap("v", "<Leader>gf", ":Fshow<CR>",              opts)
keymap("n", "<Leader>l", "exists(':MinimapRefresh') ? ':<C-u>set hlsearch!<CR>:MinimapRefresh<CR>' : ':<C-u>set hlsearch!<CR>'", { silent = true, expr = true })

