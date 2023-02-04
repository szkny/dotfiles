scriptencoding utf-8
"*****************************************************************************
"" Key-Mappings
"*****************************************************************************
let g:mapleader = "\<Space>"

" general
nno <silent><nowait> <leader><leader> :<C-u>Reload<CR>:AirlineToggle<CR>:AirlineToggle<CR>
tno <silent> <ESC>      <C-\><C-n>
tno <silent> <C-[>      <C-\><C-n>
ino <silent> <C-s>      <ESC>:w<CR>a
nno <silent> <C-s>      :w<CR>
" nno <silent> q          :CloseBufferTab<CR>
nno <silent><nowait> <leader>q  :Bclose<CR>
nno <silent><nowait> <leader>bq :Bclose<CR>
nno <silent> q          :q<CR>
nno <silent> <S-q>      :qall<CR>
tno <silent> <C-w>      <C-\><C-n><C-w>
ino <silent> <C-w>      <ESC><C-w>
" nno          /          /\v
nno <silent> *          *N

" for edit
vno <silent> >       >gv
vno <silent> <       <gv
nno <expr>   <C-d>   ':<C-u>'.ReplaceWordText().'<Left><Left><Left>'
vno <expr>   <C-d>   ':<C-u>'.VReplaceWordText().'<Left><Left><Left>'

" for tab/window
nno <silent> <Right> :ChangeBuffer next<CR>
nno <silent> <Left>  :ChangeBuffer previous<CR>
nno <silent> <M-l>   :ChangeBuffer next<CR>
nno <silent> <M-h>   :ChangeBuffer previous<CR>
nno <silent> <C-TAB> :buffer#<CR>
nno <silent> <Up>    :ResizeWindow +1<CR>
nno <silent> <Down>  :ResizeWindow -1<CR>
" nno <silent><Tab>    :NewTabPage<CR>

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
ino <silent> <M-h> <Left>
ino <silent> <M-j> <Down>
ino <silent> <M-k> <Up>
ino <silent> <M-l> <Right>
tno <silent> <M-h> <Left>
tno <silent> <M-j> <Down>
tno <silent> <M-k> <Up>
tno <silent> <M-l> <Right>
nno <silent> <M-u> <PageUp>
nno <silent> <M-d> <PageDown>
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

"" for Plugins
"" tcomment
nno <silent> <C-/> :TComment<CR>
vno <silent> <C-/> :TComment<CR>
"" vim-easy-align
vno <silent> <leader>= :EasyAlign *=<CR>
"" fzf.vim
nno <silent> <C-b> :<C-u>Buffers<CR>
nno <silent> <C-p> :<C-u>Files<CR>
nno <silent> <C-f> :<C-u>Ag<CR>
vno <silent> <C-f> :<C-u>call VAgWord()<CR>
"" ranger.vim
nno <silent> <C-h> :<C-u>SelectByRanger<CR>
"" nvim-tree
nno <silent> <C-n> :<C-u>NvimTreeToggle<CR>
"" vista.vim
nno <silent> <C-t> :<C-u>Vista!!<CR>
nno <silent> <C-g> :<C-u>Vista finder<CR>
"" minimap.vim
nno <silent> <C-k> :<C-u>MinimapToggle<CR>:MinimapRefresh<CR>
"" fugitive
nno <silent><nowait> <leader>gg :<C-u>G<CR>
nno <silent><nowait> <leader>gd :<C-u>Gvdiffsplit<CR>
"" git-gutter
nno <silent><nowait> <leader>gn :<C-u>GitGutterNextHunk<CR>
nno <silent><nowait> <leader>gp :<C-u>GitGutterPrevHunk<CR>
nno <silent><nowait> <leader>gh :<C-u>GitGutterLineHighlightsToggle<CR>

if get(g:, 'use_coc_nvim', 0) == 0 && get(g:, 'use_mason_nvim', 0) == 0
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
    "" skkeleton
    ino <C-j> <Plug>(skkeleton-enable)
    cno <C-j> <Plug>(skkeleton-enable)
    ino <C-l> <Plug>(skkeleton-disable)
    cno <C-l> <Plug>(skkeleton-disable)
    "" vim-lsp
    nno <silent><nowait> <C-]>     :<C-u>LspDefinition<CR>
    nno <silent><nowait> <leader>] :<C-u>LspDefinition<CR>
    nno <silent><nowait> <leader>[ :<C-u>LspReferences<CR>
    nno <silent><nowait> <leader>k :<C-u>LspHover<CR>
    nno <silent><nowait> <leader>n :<C-u>LspNextDiagnostic<CR>
    nno <silent><nowait> <leader>p :<C-u>LspPreviousDiagnostic<CR>
    " nno <silent><nowait> <leader>r :<C-u>LspRename<CR>
    nno <silent><nowait> <leader>l :<C-u>LspDocumentDiagnostics<CR>
    nno <silent><nowait> <leader>h :<C-u>LspCodeAction<CR>
endif

"" neosnippet
" NOTE: プラグインのマッピングはnoremapではなくmapにすること
imap <C-k>       <Plug>(neosnippet_expand_or_jump)
smap <C-k>       <Plug>(neosnippet_expand_or_jump)
xmap <C-k>       <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable()?
                 \"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"" for My Commands
ino <silent> <M-;>    <ESC>:Appendchar ;<CR>a
no  <silent> <M-;>         :Appendchar ;<CR>
" nno <silent> ?          :<C-u>SetHlSearch<CR>
nno <silent><expr> ?
  \ exists(":MinimapRefresh") ?
  \ ':<C-u>SetHlSearch<CR>:MinimapRefresh<CR>' :
  \ ':<C-u>SetHlSearch<CR>'
nno <silent> t          :<C-u>12SplitTerm<CR>i
vno <silent> <leader>t  :Trans<CR>
