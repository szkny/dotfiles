scriptencoding utf-8
"*****************************************************************************
"" Key-Mappings
"*****************************************************************************
let g:mapleader = "\<Space>"

" general
tno <silent> <C-[>     <C-\><C-n>
ino <silent> <C-s>     <ESC>:w<CR>a
nno <silent> <C-s>     :w<CR>
" nno <silent> q         :CloseBufferTab<CR>
nno <silent> q         :q<CR>
nno <silent> <S-q>     :qall<CR>
tno <silent> <C-w>     <C-\><C-n><C-w>
ino <silent> <C-w>     <ESC><C-w>

" for edit
vno <silent> >       >gv
vno <silent> <       <gv

" for tab/window
nno <silent> <Right> :ChangeBuffer next<CR>
nno <silent> <Left>  :ChangeBuffer previous<CR>
nno <silent> <C-]>   :ChangeBuffer next<CR>
nno <silent> <C-[>   :ChangeBuffer previous<CR>
nno <silent> +       :ResizeWindow +1<CR>
nno <silent> -       :ResizeWindow -1<CR>
nno <silent> <Up>    :ResizeWindow +1<CR>
nno <silent> <Down>  :ResizeWindow -1<CR>
nno <silent><Tab>    :NewTabPage<CR>

" for yank/delete/paste
nno <silent> x       "_x
vno <silent> x       "_x
nno <silent> D       "_D
nno <silent> de      "_de

" for cursor move
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
    tno <silent> ˙ <Left>
    tno <silent> ∆ <Down>
    tno <silent> ˚ <Up>
    tno <silent> ¬ <Right>
elseif system('uname') ==# "Linux\n"
    ino <silent> <A-h> <Left>
    ino <silent> <A-j> <Down>
    ino <silent> <A-k> <Up>
    ino <silent> <A-l> <Right>
    tno <silent> <A-h> <Left>
    tno <silent> <A-j> <Down>
    tno <silent> <A-k> <Up>
    tno <silent> <A-l> <Right>
endif

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

"" for Plugins
if has('mac')
    nno <silent> _     :TComment<CR>
    vno <silent> _     :TComment<CR>
else
    nno <silent> \     :TComment<CR>
    vno <silent> \     :TComment<CR>
endif
nno <silent> <C-b> :Buffers<CR>
nno <silent> <C-f> :Find<CR>
nno <silent> <C-g> :call AgWord()<CR>
vno <silent> <C-g> :call VAgWord()<CR>
nno <silent> <C-h> :call Ranger()<CR>
nno <silent> <C-n> :NERDTreeToggle<CR>
nno <silent> <C-t> :TagbarToggle<CR>
nno <silent> [a    :ALENextWrap<CR>
nno <silent> ]a    :ALEPreviousWrap<CR>
" NOTE: プラグインのマッピングはnoremapではなくmapにすること
imap <C-k>       <Plug>(neosnippet_expand_or_jump)
smap <C-k>       <Plug>(neosnippet_expand_or_jump)
xmap <C-k>       <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable()?
                 \"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"" for My Commands
if has('mac')
    ino <silent> …       <ESC>:Appendchar ;<CR>a
    no  <silent> …            :Appendchar ;<CR>
else
    ino <silent> <A-;>    <ESC>:Appendchar ;<CR>a
    no  <silent> <A-;>         :Appendchar ;<CR>
endif
nno <silent> ?          :SetHlSearch<CR>
nno <silent> t          :SplitTerm<CR>i
nno <silent> <leader>ma :Make<CR>
nno <silent> <leader>mr :Make build run<CR>
nno <silent> <leader>cm :CMake<CR>
nno <silent> <leader>cr :CMake run<CR>
nno <silent> <leader>sq :SQL<CR>i
vno <silent> <leader>t  :Trans<CR>
