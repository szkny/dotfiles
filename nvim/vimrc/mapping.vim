scriptencoding utf-8
"*****************************************************************************
"" Key-Mappings
"*****************************************************************************

let g:mapleader = "\<Space>"

tno <silent><C-[> <C-\><C-n>

nno <silent>q :CloseBufferTab<CR>
tno <C-w> <C-\><C-n><C-w>

nno <silent>> :bn<CR>
nno <silent>< :bp<CR>
nno <silent>+ :res +1<CR>
nno <silent>- :res -1<CR>

nno <silent>j gj
nno <silent>k gk
ino <C-h> <Left>
ino <C-j> <Down>
ino <C-k> <Up>
ino <C-l> <Right>

nno x "_x
vno x "_x

nno <S-h> ^
nno <S-j> 10j
nno <S-k> 10k
nno <S-l> $
vno <S-h> ^
vno <S-j> }
vno <S-k> {
vno <S-l> $

ino {<Enter> {}<Left><CR><Up><ESC>$i<Right>
" ino {<Enter> {}<Left><CR><ESC>O

if system('uname') ==# 'Linux'
    ino <silent><A-[> <ESC>
    vno <silent><A-[> <ESC>
    nno <silent><A-w> <C-w>
endif


"" Mapping for Plugins
if has('mac')
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
nno <silent><C-s> :ALEToggle<CR>
nno <silent><C-n> :NERDTreeToggle<CR>
nno <silent><C-t> :TagbarToggle<CR>
" nno <silent><C-o> :Unite outline<CR>
" nno <silent><C-i> :IndentGuidesToggle<CR>

"" mapping for My Commands
nno <silent>?     :call SetHlsearch()<CR>
nno <silent>t     :BeginTerminal12<CR>
nno <silent><leader>ma :Make12<CR>
nno <silent><leader>mr :Make12 build run<CR>
nno <silent><leader>cm :CMake12<CR>
nno <silent><leader>cr :CMake12 run<CR>
nno <silent><leader>py :Python12<CR>
nno <silent><leader>pp :Pyplot<CR>
nno <silent><leader>gp :Gnuplot<CR>


