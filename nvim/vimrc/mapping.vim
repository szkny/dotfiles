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

" for edit
vno <silent> >       >gv
vno <silent> <       <gv
nno <expr>   <C-d>   ':<C-u>'.ReplaceWordText().'<Left><Left><Left>'
vno <expr>   <C-d>   ':<C-u>'.VReplaceWordText().'<Left><Left><Left>'

" for tab/window
nno <silent> <Right> :ChangeBuffer next<CR>
nno <silent> <Left>  :ChangeBuffer previous<CR>
nno <silent> <Up>    :ResizeWindow +1<CR>
nno <silent> <Down>  :ResizeWindow -1<CR>
" nno <silent><Tab>    :NewTabPage<CR>

" for yank/delete/paste
nno <silent> x       "_x
vno <silent> x       "_x
vno <silent> p       "_dP
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
    nno <silent> <C-/>   :TComment<CR>
    vno <silent> <C-/>   :TComment<CR>
else
    nno <silent> <C-/>   :TComment<CR>
    vno <silent> <C-/>   :TComment<CR>
endif
nno <silent> <C-b> :<C-u>Buffers<CR>
nno <silent> <C-p> :<C-u>Files<CR>
nno <silent> <C-f> :<C-u>Ag<CR>
vno <silent> <C-f> :<C-u>call VAgWord()<CR>
nno <silent> <C-h> :<C-u>call Ranger()<CR>
"" fern.vim
nno <silent> <C-n> :<C-u>Fern . -reveal=% -toggle -keep -drawer -width=25<CR>
"" vista.vim
nno <silent> <C-t> :<C-u>Vista!!<CR>
nno <silent> <C-g> :<C-u>Vista finder<CR>
nno <silent> <C-k> :<C-u>MinimapToggle<CR>
"" git-gutter
nno <silent><nowait> <leader>gn :<C-u>GitGutterNextHunk<CR>
nno <silent><nowait> <leader>gp :<C-u>GitGutterPrevHunk<CR>
nno <silent><nowait> <leader>gh :<C-u>GitGutterLineHighlightsToggle<CR>
"" ddc.vim (with pum.vim)
ino <silent> <C-n> <Cmd>call pum#map#select_relative(+1)<CR>
ino <silent> <C-p> <Cmd>call pum#map#select_relative(-1)<CR>
"" vim-lsp
nno <silent><nowait> <C-]>     :<C-u>LspDefinition<CR>
nno <silent><nowait> <leader>] :<C-u>LspDefinition<CR>
nno <silent><nowait> <leader>[ :<C-u>LspReferences<CR>
nno <silent><nowait> <leader>k :<C-u>LspHover<CR>
nno <silent><nowait> <leader>n :<C-u>LspNextDiagnostic<CR>
nno <silent><nowait> <leader>p :<C-u>LspPreviousDiagnostic<CR>
" nno <silent><nowait> <leader>r :<C-u>LspRename<CR>
nno <silent><nowait> <leader>l :<C-u>LspDocumentDiagnostics<CR>
" nno <silent><nowait> <leader>s :<C-u>LspDocumentFormat<CR>
nno <silent><nowait> <leader>h :<C-u>LspCodeAction<CR>
"" neosnippet
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
nno <silent> t          :<C-u>12SplitTerm<CR>i
