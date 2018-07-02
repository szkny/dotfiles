scriptencoding utf-8
"*****************************************************************************
"" Key-Mappings
"*****************************************************************************
let g:mapleader = "\<Space>"

tno <silent><C-[> <C-\><C-n>

nno ; :
nno <silent>q :CloseBufferTab<CR>
nno <silent>Q :qall<CR>
tno <C-w> <C-\><C-n><C-w>

nno <silent>> :bn<CR>
nno <silent>< :bp<CR>
nno <silent>+ :ResizeWindow +1<CR>
nno <silent>- :ResizeWindow -1<CR>

nno <silent>j gj
nno <silent>k gk
ino <C-h> <Left>
ino <C-l> <Right>

nno <CR> o<ESC>
nno x "_x
vno x "_x

nno <S-h> ^
nno <S-j> 5j
nno <S-k> 5k
nno <S-l> $
vno <S-h> ^
vno <S-j> 5j
vno <S-k> 5k
vno <S-l> $

ino {<Enter> {}<Left><CR><Up><ESC>$i<Right>
" ino {<Enter> {}<Left><CR><ESC>O

if system('uname') ==# "Linux\n"
    ino <silent><A-[> <ESC>
    vno <silent><A-[> <ESC>
    tno <silent><A-[> <C-\><C-n>
    nno <silent><A-w> <C-w>
    ino <A-h> <Left>
    ino <A-j> <Down>
    ino <A-k> <Up>
    ino <A-l> <Right>
endif


"" Mapping for Plugins
if has('mac')
    nno <silent>gi <Plug>(nyaovim-popup-tooltip-open)
    ino …       <ESC>:AppendChar ;<CR>i<Right>
    nno …            :AppendChar ;<CR>
    nno <silent>_     :TComment<CR>
    vno <silent>_     :TComment<CR>
else
    ino <A-;>    <ESC>:AppendChar ;<CR>i<Right>
    nno <A-;>         :AppendChar ;<CR>
    nno <silent>\     :TComment<CR>
    vno <silent>\     :TComment<CR>
endif
if &filetype ==# 'python'
    nno <silent><C-s> :ALEFix autopep8<CR>
endif
nno <silent><C-f> :Files<CR>
nno <silent><C-h> :Ranger<CR>
nno <silent><C-n> :NERDTreeToggle<CR>
nno <silent><C-t> :TagbarToggle<CR>
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>       <Plug>(neosnippet_expand_or_jump)
smap <C-k>       <Plug>(neosnippet_expand_or_jump)
xmap <C-k>       <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable()?
                 \"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"" mapping for My Commands
nno <silent>?          :call SetHlsearch()<CR>
nno <silent>t          :BeginTerminal<CR>
nno <silent><leader>ma :Make<CR>
nno <silent><leader>mr :Make build run<CR>
nno <silent><leader>cm :CMake<CR>
nno <silent><leader>cr :CMake run<CR>
nno <silent><leader>py :Python<CR>
nno <silent><leader>ip :Ipython<CR>
nno <silent><leader>sq :SQL<CR>
nno <silent><leader>sp :SQLplot<CR>
nno <silent><leader>pp :Pyplot<CR>
nno <silent><leader>gp :Gnuplot<CR>
