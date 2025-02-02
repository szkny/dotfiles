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
keymap("t", "<C-[>", "<C-\\><C-n>", opts)
keymap("t", "<ESC>", "<C-\\><C-n><Plug>(esc)", opts)
keymap("n", "<Plug>(esc)<ESC>", "i<ESC>", opts)
keymap("i", "<C-s>", function()
  Try({
    function()
      vim.cmd("w!")
    end,
    Catch({
      function(err)
        print("caught error: " .. err)
      end,
    }),
  })
end, opts)
keymap("n", "<C-s>", function()
  Try({
    function()
      vim.cmd("w!")
    end,
    Catch({
      function(err)
        print("caught error: " .. err)
      end,
    }),
  })
end, opts)
keymap("n", "q", function()
  Try({
    function()
      local tabs = vim.api.nvim_list_tabpages()
      if #tabs == 1 then
        vim.cmd("q")
        return
      else
        vim.cmd("tabclose")
      end
    end,
    Catch({
      function(error)
        print("caught error: " .. error)
        -- print('E173: some files to edit')
      end,
    }),
  })
end, opts)
keymap("n", "<S-q>", function()
  vim.cmd("qall!")
end, opts)

-- for edit
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
keymap("n", "<leader>d", [["+y/\V<C-r><C-w><CR>cgn]], opts)
keymap("v", "<leader>d", [["vy/\V<C-r>"<CR>Ncgn]], opts)

-- -- for tab/window
-- keymap("n", "<Right>", ":ChangeBuffer next<CR>",     opts)
-- keymap("n", "<Left>",  ":ChangeBuffer previous<CR>", opts)
-- keymap("n", "<Right>", ":BufferLineCycleNext<CR>",   opts)
-- keymap("n", "<Left>",  ":BufferLineCyclePrev<CR>",   opts)
-- keymap("n", "<M-l>",   ":BufferLineCycleNext<CR>",   opts)
-- keymap("n", "<M-h>",   ":BufferLineCyclePrev<CR>",   opts)
keymap("n", "<TAB>", ":buffer#<CR>", opts)
keymap("n", "<Up>", ":ResizeWindow +1<CR>", opts)
keymap("n", "<Down>", ":ResizeWindow -1<CR>", opts)
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
keymap("n", "c", '"_c', opts)
keymap("v", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("v", "C", '"_C', opts)
-- keymap("n", "s",  "\"_s",   opts)
-- keymap("v", "s",  "\"_s",   opts)
-- keymap("n", "S",  "\"_S",   opts)
-- keymap("v", "S",  "\"_S",   opts)
keymap("n", "x", '"_x', opts)
keymap("v", "x", '"_x', opts)
keymap("v", "p", '"_dP', opts)
keymap("n", "D", '"_D', opts)
keymap("n", "de", '"_de', opts)
keymap("n", "dw", 'b"_de', opts)

-- for cursor move
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "<C-e>", "<C-e>gj", opts)
keymap("n", "<C-y>", "<C-y>gk", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("n", "<S-h>", "10h", opts)
keymap("n", "<S-l>", "10l", opts)
keymap("v", "<S-h>", "10h", opts)
keymap("v", "<S-l>", "10l", opts)
keymap("n", "<S-j>", "5gj", opts)
keymap("n", "<S-k>", "5gk", opts)
keymap("v", "<S-j>", "5gj", opts)
keymap("v", "<S-k>", "5gk", opts)
-- keymap("n", "<S-j>", "<C-e>",      opts)
-- keymap("n", "<S-k>", "<C-y>",      opts)
-- keymap("v", "<S-j>", "<C-e>",      opts)
-- keymap("v", "<S-k>", "<C-y>",      opts)
keymap("i", "<M-h>", "<Left>", opts)
keymap("i", "<M-j>", "<Down>", opts)
keymap("i", "<M-k>", "<Up>", opts)
keymap("i", "<M-l>", "<Right>", opts)
keymap("t", "<M-h>", "<Left>", opts)
keymap("t", "<M-j>", "<Down>", opts)
keymap("t", "<M-k>", "<Up>", opts)
keymap("t", "<M-l>", "<Right>", opts)
keymap("n", "<M-u>", "<PageUp>", opts)
keymap("n", "<M-d>", "<PageDown>", opts)
keymap("i", "<C-a>", "<Home>", opts)
keymap("i", "<C-e>", "<End>", opts)
keymap("c", "<C-a>", "<Home>", opts)
keymap("c", "<C-e>", "<End>", opts)

-- for IME
keymap("n", "あ", "a", opts)
keymap("n", "い", "i", opts)
keymap("n", "う", "u", opts)
keymap("n", "お", "o", opts)
keymap("n", "ｒ", "r", opts)
keymap("n", "ｊ", "gj", opts)
keymap("n", "ｋ", "gj", opts)
keymap("n", "ｌ", "l", opts)
keymap("n", "ｈ", "h", opts)
keymap("n", "ｐ", "p", opts)
keymap("n", "ｄｄ", "dd", opts)
keymap("n", "ｙｙ", "yy", opts)

-- for My Commands
keymap("n", "<leader>t", "<CMD>Term<CR>i", opts)
