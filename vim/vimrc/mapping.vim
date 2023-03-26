scriptencoding utf-8
"*****************************************************************************
"" Key-Mappings
"*****************************************************************************
let g:mapleader = "\<Space>"

" general
ino <silent> <C-s>   <ESC>:w<CR>a
nno <silent> <C-s>   :<C-u>w<CR>
nno <silent> q       :<C-u>CloseBufferTab<CR>
nno <silent> <S-q>   :<C-u>qall<CR>
" ino <silent> <C-w>   <ESC><C-w>
" nno          /       /\v
tno <silent> <C-[>   <C-\><C-n>
tno <silent> <ESC>   <C-\><C-n>

" for edit
vno <silent> >       >gv
vno <silent> <       <gv
nno <expr>   <C-d>   ReplaceWordText()  !=# '' ? ':<C-u>'. ReplaceWordText().'<Left><Left><Left>' : '<ESC>'
vno <expr>   <C-d>   VReplaceWordText() !=# '' ? ':<C-u>'.VReplaceWordText().'<Left><Left><Left>' : '<ESC>'

" tab/window
nno <silent> <Right> :<C-u>ChangeBuffer next<CR>
nno <silent> <Left>  :<C-u>ChangeBuffer previous<CR>
nno <silent> +       :<C-u>ResizeWindow +1<CR>
nno <silent> -       :<C-u>ResizeWindow -1<CR>
nno <silent> <Up>    :<C-u>ResizeWindow +1<CR>
nno <silent> <Down>  :<C-u>ResizeWindow -1<CR>
" nno <silent> <Tab>   :<C-u>NewTabPage<CR>

" for yank/delete/paste
nno <silent> c       "_c
vno <silent> c       "_c
nno <silent> C       "_C
vno <silent> C       "_C
nno <silent> s       "_s
vno <silent> s       "_s
nno <silent> S       "_S
vno <silent> S       "_S
nno <silent> x       "_x
vno <silent> x       "_x
vno <silent> p       "_dP
nno <silent> D       "_D
nno <silent> de      "_de
nno <silent> dw      b"_de

" cursor move
nno <silent> j       gj
nno <silent> k       gk
ino <silent> <C-h>   <Left>
ino <silent> <C-l>   <Right>
nno <silent> <S-h>   10h
nno <silent> <S-j>   5gj
nno <silent> <S-k>   5gk
nno <silent> <S-l>   10l
vno <silent> <S-h>   10h
vno <silent> <S-j>   5gj
vno <silent> <S-k>   5gk
vno <silent> <S-l>   10l
if has('mac')
    ino <silent> ˙ <Left>
    ino <silent> ∆ <Down>
    ino <silent> ˚ <Up>
    ino <silent> ¬ <Right>
elseif system('uname') ==# "Linux\n"
    ino <silent> <A-h> <Left>
    ino <silent> <A-j> <Down>
    ino <silent> <A-k> <Up>
    ino <silent> <A-l> <Right>
endif
cno          <C-a> <Home>
cno          <C-e> <End>

" for IME
nno <silent> あ      a
nno <silent> い      i
nno <silent> う      u
nno <silent> お      o
nno <silent> ｒ      r
nno <silent> ｊ      gj
nno <silent> ｋ      gj
nno <silent> ｌ      l
nno <silent> ｈ      h
nno <silent> ｐ      p
nno <silent> ｄｄ    dd
nno <silent> ｙｙ    yy

"" Mapping for Plugins
if has('mac')
    nno <silent> _     :<C-u>TComment<CR>
    vno <silent> _     :<C-u>TComment<CR>
else
    nno <silent> \     :<C-u>TComment<CR>
    vno <silent> \     :<C-u>TComment<CR>
endif
nno <silent> <C-b> :<C-u>Buffers<CR>
nno <silent> <C-p> :<C-u>Files<CR>
nno <silent> <C-f> :<C-u>call VimGrepWord()<CR>
vno <silent> <C-f> :<C-u>call VVimGrepWord()<CR>
nno <silent> <C-g> :<C-u>call AgWord()<CR>
vno <silent> <C-g> :<C-u>call VAgWord()<CR>
nno <silent> <C-h> :<C-u>call OpenRanger()<CR>
nno <silent> <C-n> :<C-u>NERDTreeToggle<CR>
nno <silent> <C-t> :<C-u>TagbarToggle<CR>
nno <silent> [a    :<C-u>ALENextWrap<CR>
nno <silent> ]a    :<C-u>ALEPreviousWrap<CR>
" NOTE: プラグインのマッピングはnoremapではなくmapにすること
imap <C-k>       <Plug>(neosnippet_expand_or_jump)
smap <C-k>       <Plug>(neosnippet_expand_or_jump)
xmap <C-k>       <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable()?
                 \"\<Plug>(neosnippet_expand_or_jump)" :<C-u> "\<TAB>"

"" mapping for My Commands
if has('mac')
    ino <silent> …       <ESC>:<C-u>Appendchar ;<CR>a
    no  <silent> …            :<C-u>Appendchar ;<CR>
else
    ino <silent> <A-;>    <ESC>:<C-u>Appendchar ;<CR>a
    no  <silent> <A-;>         :<C-u>Appendchar ;<CR>
endif
nno <silent> ?          :<C-u>SetHlSearch<CR>
nno <silent> t          :<C-u>bo terminal ++rows=12<CR>
" nno <silent> <leader>ma :<C-u>Make<CR>
" nno <silent> <leader>mr :<C-u>Make build run<CR>
" nno <silent> <leader>cm :<C-u>CMake<CR>
" nno <silent> <leader>cr :<C-u>CMake run<CR>
" nno <silent> <leader>sq :<C-u>SQL<CR>i
" vno <silent> <leader>t  :<C-u>Trans<CR>
