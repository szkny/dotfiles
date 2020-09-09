scriptencoding utf-8
"*****************************************************************************
"" Key-Mappings
"*****************************************************************************
let g:mapleader = "\<Space>"

" general
tno <silent> <C-[>      <C-\><C-n>
ino <silent> <C-s>      <ESC>:w<CR>a
nno <silent> <C-s>      :w<CR>
" nno <silent> q          :CloseBufferTab<CR>
nno <silent> <leader>bq :Bclose<CR>
nno <silent> q          :q<CR>
nno <silent> <S-q>      :qall<CR>
tno <silent> <C-w>      <C-\><C-n><C-w>
ino <silent> <C-w>      <ESC><C-w>

" for edit
vno <silent> >       >gv
vno <silent> <       <gv

" for tab/window
nno <silent> <Right> :ChangeBuffer next<CR>
nno <silent> <Left>  :ChangeBuffer previous<CR>
" nno <silent> +       :ResizeWindow +1<CR>
" nno <silent> -       :ResizeWindow -1<CR>
nno <silent> <Up>    :ResizeWindow +1<CR>
nno <silent> <Down>  :ResizeWindow -1<CR>
" nno <silent><Tab>    :NewTabPage<CR>

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
map <silent> p     <Plug>(miniyank-autoput)
map <silent> P     <Plug>(miniyank-autoPut)
nno <silent> <C-b> :<C-u>Buffers<CR>
" nno <silent> <C-f> :<C-u>call AgWord()<CR>
nno <silent> <C-f> :<C-u>Ag<CR>
vno <silent> <C-f> :<C-u>call VAgWord()<CR>
nno <silent> <C-h> :<C-u>call Ranger()<CR>
nno <silent> <C-n> :<C-u>NERDTreeToggle<CR>
" nno <silent> <C-t> :<C-u>TagbarToggle<CR>
nno <silent> <C-t> :<C-u>Vista!!<CR>
nno <silent> [a    :<C-u>ALENextWrap<CR>
nno <silent> ]a    :<C-u>ALEPreviousWrap<CR>
" vim-lsp
nno <silent> <C-]>     :<C-u>LspDefinition<CR>
nno <silent> <leader>k :<C-u>LspHover<CR>
nno <silent> <leader>r :<C-u>LspRename<CR>
nno <silent> <leader>n :<C-u>LspReferences<CR>
nno <silent> <leader>f :<C-u>LspDocumentDiagnostics<CR>
nno <silent> <leader>s :<C-u>LspDocumentFormat<CR>
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
nno <silent> ?          :<C-u>SetHlSearch<CR>
" nno <silent> t          :<C-u>SplitTerm<CR>i
nno <silent> t          :<C-u>call splitterm#open_width(10)<CR>i
nno <silent> <leader>ma :<C-u>Make<CR>
nno <silent> <leader>mr :<C-u>Make build run<CR>
nno <silent> <leader>cm :<C-u>CMake<CR>
nno <silent> <leader>cr :<C-u>CMake run<CR>
nno <silent> <leader>sq :<C-u>SQL<CR>i
vno <silent> <leader>t  :<C-u>Trans<CR>

" nnoremap <leader>f :MyLineSearch<Space>
" nnoremap <leader>F :MyLineBackSearch<Space>
" nnoremap <leader>; :MyLineSameSearch<CR>
" nnoremap <leader>, :MyLineBackSameSearch<CR>
