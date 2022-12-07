scriptencoding utf-8

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let g:vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(g:vimplug_exists)
    if !executable('curl')
        echoerr 'You have to install curl or first install vim-plug yourself!'
        execute 'q!'
    endif
    echo 'Installing Vim-Plug...'
    echo ''
    silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:not_finish_vimplug = 'yes'
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'lighttiger2505/deoplete-vim-lsp'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mattn/vim-lsp-settings'
Plug 'w0rp/ale'
" Plug 'bronson/vim-trailing-whitespace'
" Plug 'majutsushi/tagbar'
" Plug 'hushicai/tagbar-javascript.vim'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'  " for ranger.vim
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
Plug 'koron/codic-vim'
" Plug 'bfredl/nvim-miniyank'
Plug 'szkny/SplitTerm'
" Plug 'liuchengxu/vista.vim'
Plug 'wfxr/minimap.vim'
Plug 'lambdalisue/vim-quickrun-neovim-job' | Plug 'thinca/vim-quickrun'
Plug 'glacambre/firenvim', { 'do': function('firenvim#install') }
if has('mac') == 0
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}
endif
Plug 'scrooloose/nerdtree',                     {'on': 'NERDTreeToggle'}
Plug 'jistr/vim-nerdtree-tabs',                 {'on': 'NERDTreeToggle'}
Plug 'willelz/badapple.nvim'

if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
endif
" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  'find * -path "*/\.*" -prune -o -path "node_modules/**" -prune -o -path "target/**" -prune -o -path "dist/**" -prune -o  -type f -print -o -type l -print 2> /dev/null'

let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" color scheme
Plug 'tomasr/molokai'
" Plug 'morhetz/gruvbox'
" Plug 'arcticicestudio/nord-vim'
" Plug 'altercation/vim-colors-solarized'

" c/c++
Plug 'vim-jp/cpp-vim',                 {'for': 'cpp'}
Plug 'vim-scripts/c.vim',              {'for': ['c', 'cpp']}
" Plug 'ludwig/split-manpage.vim'

" python
Plug 'davidhalter/jedi-vim',           {'for': 'python'}
Plug 'zchee/deoplete-jedi',            {'for': 'python'}
Plug 'tweekmonster/braceless.vim',     {'for': 'python'}
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'for': 'python',
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
Plug 'szkny/Ipython',                  {'for': 'python'}
Plug 'szkny/IpdbDebugger',             {'for': 'python'}
" Plug 'szkny/jupyter-vim',              {'for': 'python'}

" golang
Plug 'fatih/vim-go',                   {'for': 'go'}

" julia
Plug 'JuliaEditorSupport/julia-vim'

" javascript
Plug 'prettier/vim-prettier',  { 'for': ['javascript', 'typescript', 'css', 'json', 'markdown', 'vue', 'yaml', 'html'] }

" terraform
Plug 'hashivim/vim-terraform'

" nyaovim
if exists('g:nyaovim_version')
    Plug 'rhysd/nyaovim-mini-browser'
    Plug 'rhysd/nyaovim-popup-tooltip'
    Plug 'rhysd/nyaovim-markdown-preview', {'for': 'markdown'}
endif

" misc
Plug 'raimon49/requirements.txt.vim',  {'for': 'requirements'}
Plug 'cespare/vim-toml',               {'for': 'toml'}
Plug 'tyru/open-browser.vim',          {'for': 'markdown'}
Plug 'kannokanno/previm',              {'for': 'markdown'}
Plug 'godlygeek/tabular',              {'for': 'markdown'}
Plug 'plasticboy/vim-markdown',        {'for': 'markdown'}
Plug 'yaasita/ore_markdown',           {'for': 'markdown'}
" Plug 'lvht/tagbar-markdown',           {'for': 'markdown'}
Plug 'vim-scripts/applescript.vim',    {'for': 'applescript'}
Plug 'aklt/plantuml-syntax',           {'for': 'plantuml'}
Plug 'posva/vim-vue',                  {'for': 'vue'}
Plug 'digitaltoad/vim-pug',            {'for': 'pug'}

" icon
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Required: ftpluginディレクトリをロードする
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
" set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
set bomb
set binary

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set inccommand=split

"" completion
set complete-=t

"" Copy/Paste/Cut
if has('wsl')
    augroup Yank
      au!
      autocmd TextYankPost * :call system('clip.exe', @")
    augroup END
else
    set clipboard+=unnamedplus
endif

"" Directories for swp files
set nobackup
set noswapfile

"" Time (msec)
set ttimeoutlen=1  " keyboard timeout
set updatetime=250

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"" etc..
set autoread
set whichwrap=b,s,h,l,<,>,[,]
set mouse=a
set smartindent
set wildmenu
set splitbelow
set splitright
set virtualedit=onemore
set foldmethod=manual
set lazyredraw

"" netrw
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" let g:netrw_preview=1

"" Session Management
let g:session_directory = '~/.config/nvim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

"" Python Host Program
let g:python_host_prog  = expand('~/.pyenv/shims/python2')
let g:python3_host_prog = expand('~/.pyenv/shims/python3')
" let g:python_host_prog = ''
" let g:python3_host_prog = ''
" if has('mac')
"     let g:python_host_prog = expand('~/.pyenv/versions/2.7.15/bin/python2')
"     let g:python3_host_prog = expand('~/.pyenv/versions/3.6.5/bin/python3')
" elseif system('uname') ==# "Linux\n"
"     let g:python_host_prog = expand('~/.pyenv/versions/2.7.15/bin/python2')
"     let g:python3_host_prog = expand('~/.pyenv/versions/3.8.5/bin/python3')
" endif
" if findfile(g:python_host_prog) ==# ''
"     let g:python_host_prog = split(system('which python2'), "\n")[0]
" endif
" if findfile(g:python3_host_prog) ==# ''
"     let g:python3_host_prog = split(system('which python3'), "\n")[0]
" endif

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set nowrap
set pumblend=40
set winblend=30
set pumblend=30

" set ambiwidth=double
let g:no_buffers_menu=1

set mousemodel=popup
set t_Co=256
set termguicolors " for iTerm2
set guioptions=egmrti
set guifont=Monospace\ 10

if has('gui_running')
    if has('gui_mac') || has('gui_macvim')
        set guifont=Menlo:h12
        set transparency=7
    endif
else
    let g:CSApprox_loaded = 1
endif

"" Disable the blinking cursor
set guicursor=a:blinkon0

"" Change cursor by mode
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
if &term =~ '^xterm'
    " normal mode
    let &t_EI .= "\<Esc>[0 q"
    " insert mode
    let &t_SI .= "\<Esc>[6 q"
endif

set scrolloff=3

"" Status bar
set laststatus=2
set showtabline=1
set noshowmode

"" Use modeline overrides
set modeline
set modelines=10
" set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

set background=dark
colorscheme molokai
" colorscheme gruvbox

let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:cpp_class_scope_highlight = 1

set list
set listchars=tab:¦\ 
set fillchars=vert:\ 
set cursorline
" set cursorcolumn

hi EndOfBuffer guifg=bg
" hi matchparen ctermbg=236
" hi Normal ctermbg=NONE guibg=NONE
" hi NonText ctermbg=NONE guibg=NONE
" hi SpecialKey ctermbg=NONE guibg=NONE
" hi EndOfBuffer ctermbg=NONE guibg=NONE
" hi SpecialKey guifg=#555555
" hi Visual guifg=#000000 guibg=#cceeff
" hi LineNr guifg=#aabbcc guibg=#204056
hi VertSplit guibg=#222222
" hi CursorLine gui=underline
hi clear CursorLine
" hi CursorColumn guibg=#0c1820
hi clear Cursor
hi Cursor gui=reverse
" hi clear Visual
" hi Visual gui=reverse


"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" IME
if has('mac')
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  aug MyIMEGroup
    au!
    au InsertLeave * :call system(g:imeoff)
  aug END
endif

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
aug vimrc_sync_fromstart
    au!
    au BufEnter * :syntax sync maxlines=200
aug END

"" Remember cursor position
aug vimrc_remember_cursor_position
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
aug END

"" txt
aug vimrc_wrapping
    au!
    au BufRead,BufNewFile *.txt setlocal wrap wrapmargin=2 textwidth=79
aug END

"" make/cmake
aug vimrc_make_cmake
    au!
    au FileType make setlocal noexpandtab
    au BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
aug END

" The Silver Searcher
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
    set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep(
                \'rg --column --line-number --no-heading --fixed-strings --ignore-case '
                \.'--hidden --follow --glob "!.git/*" --color "always" '
                \.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" Disable visualbell
set noerrorbells visualbell t_vb=
aug visualbell
    au GUIEnter * set visualbell t_vb=
aug END

" for CRLF
fun! s:Applycrlfff() abort
    try 
        call execute("/\\v\r$")
        edit ++ff=dos
    catch
    endtry
endf
aug applycrlffileformat
    au!
    au BufReadPost * call s:Applycrlfff()
aug END

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" c/cpp
aug vimrc_c_cpp
    au!
    au FileType c,cpp setlocal tabstop=4 shiftwidth=4 expandtab
aug END

" javascript/typescript
aug vimrc_js_ts
    au!
    au BufNewFile,BufRead *.cjs,*.mjs setfiletype javascript
    au BufNewFile,BufRead *.tsx setfiletype typescript
    au FileType javascript,typescript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
aug END

" FixWhitespace
aug FixWhitespace
    au!
    au FileType text if exists(':FixWhitespace') | FixWhitespace
aug END

"*****************************************************************************
"" Include user's local vim config
"*****************************************************************************
" set path+=**
set runtimepath+=~/.config/nvim
ru! vimrc/*.vim
command! Vimrc silent e ~/dotfiles/nvim
command! Reload silent source ~/.config/nvim/init.vim
