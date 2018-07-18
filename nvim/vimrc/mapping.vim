scriptencoding utf-8
"*****************************************************************************
"" Key-Mappings
"*****************************************************************************
let g:mapleader = "\<Space>"

tno <silent><C-[> <C-\><C-n>

nno ; :
ino <C-s>           <ESC>:w<CR>a
nno <C-s>           :w<CR>
nno <silent>q       :CloseBufferTab<CR>
nno <silent><S-q>   :qall<CR>
tno <C-w>           <C-\><C-n><C-w>

nno <silent><Tab>   :ChangeBuffer next<CR>
nno <silent><S-Tab> :ChangeBuffer previous<CR>
nno <silent>>       :ChangeBuffer next<CR>
nno <silent><       :ChangeBuffer previous<CR>
nno <silent>+       :ResizeWindow +1<CR>
nno <silent>-       :ResizeWindow -1<CR>

nno <silent>j gj
nno <silent>k gk
ino <C-h> <Left>
ino <C-l> <Right>

nno x "_x
vno x "_x

nno <S-h> 10h
nno <S-j> 5gj
nno <S-k> 5gk
nno <S-l> 10l
vno <S-h> 10h
vno <S-j> 5gj
vno <S-k> 5gk
vno <S-l> 10l

ino {<Enter> {}<Left><CR><Up><ESC>$a
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
    nno <silent>_     :TComment<CR>
    vno <silent>_     :TComment<CR>
else
    nno <silent>\     :TComment<CR>
    vno <silent>\     :TComment<CR>
endif
nno <silent><C-b> :Buffers<CR>
nno <silent><C-f> :Files<CR>
nno <silent><C-h> :call Ranger()<CR>
nno <silent><C-n> :NERDTreeToggle<CR>
nno <silent><C-t> :TagbarToggle<CR>
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>       <Plug>(neosnippet_expand_or_jump)
smap <C-k>       <Plug>(neosnippet_expand_or_jump)
xmap <C-k>       <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable()?
                 \"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"" mapping for My Commands
if has('mac')
    ino …       <ESC>:AppendChar ;<CR>a
    nno …            :AppendChar ;<CR>
else
    ino <A-;>    <ESC>:AppendChar ;<CR>a
    nno <A-;>         :AppendChar ;<CR>
endif
nno <silent>?  :call SetHlsearch()<CR>
nno <silent>t  :SplitTerm<CR>
nno <leader>ma :Make<CR>
nno <leader>mr :Make build run<CR>
nno <leader>cm :CMake<CR>
nno <leader>cr :CMake run<CR>
nno <leader>py :Python<CR>
nno <leader>ip :Ipython<CR>
nno <leader>pd :Ipdb<CR>
nno <leader>sq :SQL<CR>
nno <leader>sp :SQLplot<CR>

"" Markdown Mapping
aug MyMarkdownSetting
    au BufEnter *.{md,mdwn,mkd,mkdn,mark*} call MyMdMap()
aug END

fun! MyMdMap()
    ino <buffer><A-;> <ESC>:AppendChar \ \ <CR>a
    nno <buffer><A-;>      :AppendChar \ \ <CR>
endf
