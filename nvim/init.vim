scriptencoding utf-8

"*****************************************************************************
"" Ignore default plugins
"*****************************************************************************
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:did_indent_on             = 1
let g:did_load_filetypes        = 1
let g:did_load_ftplugin         = 1
let g:loaded_2html_plugin       = 1
let g:loaded_gzip               = 1
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_remote_plugins     = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tarPlugin          = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_zipPlugin          = 1
let g:skip_loading_mswin        = 1

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
" general plugins
Plug 'tomtom/tcomment_vim'
Plug 'kevinhwang91/rnvimr'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
Plug 'szkny/SplitTerm'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vista.vim'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'nvim-tree/nvim-tree.lua',     {'on': 'NvimTreeToggle'}
Plug 'dstein64/vim-startuptime'

" visual plugins
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'wfxr/minimap.vim',  {'on': 'MinimapToggle'}
Plug 'petertriho/nvim-scrollbar'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
" Plug 'norcalli/nvim-colorizer.lua'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
if has('wsl')
    Plug 'lukas-reineke/indent-blankline.nvim'
else
    Plug 'yggdroot/indentline'
endif

" color scheme
Plug 'tomasiser/vim-code-dark'
" Plug 'Mofiqul/vscode.nvim'  " TODO
" Plug 'tomasr/molokai'
" Plug 'jacoborus/tender.vim'

" nvim-notify / noice.nvim
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'

" fzf.vim
if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
endif

" denops plugins
Plug 'vim-denops/denops.vim'
Plug 'vim-skk/skkeleton', { 'frozen': 1 }

" LSP
let g:use_coc_nvim = 1
let g:use_mason_nvim = 0
if get(g:, 'use_coc_nvim', 0) == 1
    " coc.nvim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
elseif get(g:, 'use_mason_nvim', 0) == 1
    " mason.nvim
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
else
    " vim-lsp
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'matsui54/denops-popup-preview.vim'
    Plug 'matsui54/denops-signature_help'
endif

" for ddc settings
" ddc core
Plug 'Shougo/ddc.vim'
" ddc UIs
Plug 'szkny/pum.vim'
Plug 'Shougo/ddc-ui-pum'
" Plug 'Shougo/ddc-ui-native'
" ddc sources
Plug 'Shougo/ddc-source-around'
Plug 'shun/ddc-source-vim-lsp'
Plug 'LumaKernel/ddc-source-file'
Plug 'Shougo/ddc-source-mocword'
Plug 'Shougo/ddc-source-cmdline'
Plug 'Shougo/ddc-source-cmdline-history'
Plug 'Shougo/neco-vim'
" ddc filters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-converter_remove_overlap'
Plug 'tani/ddc-fuzzy'
" " ddc etc.
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'

" c/c++
" Plug 'vim-jp/cpp-vim',                 {'for': 'cpp'}
"
" python
" Plug 'tweekmonster/braceless.vim',     {'for': 'python'}
Plug 'szkny/Ipython',                  {'for': 'python'}
" Plug 'szkny/IpdbDebugger',             {'for': 'python'}
" Plug 'szkny/jupyter-vim',              {'for': 'python'}
"
" " golang
" Plug 'fatih/vim-go',                   {'for': 'go'}
"
" " julia
" Plug 'JuliaEditorSupport/julia-vim',   {'for': 'julia'}
"
" " javascript
" " Plug 'prettier/vim-prettier',  { 'for': ['javascript', 'typescript', 'css', 'json', 'markdown', 'vue', 'yaml', 'html'] }
"
" " misc
Plug 'elzr/vim-json',                  {'for': 'json'}
Plug 'raimon49/requirements.txt.vim',  {'for': 'requirements'}
Plug 'cespare/vim-toml',               {'for': 'toml'}
Plug 'kannokanno/previm',              {'for': 'markdown'}
Plug 'godlygeek/tabular',              {'for': 'markdown'}
Plug 'preservim/vim-markdown',         {'for': 'markdown'}
Plug 'yaasita/ore_markdown',           {'for': 'markdown'}
" Plug 'vim-scripts/applescript.vim',    {'for': 'applescript'}
" Plug 'aklt/plantuml-syntax',           {'for': 'plantuml'}
Plug 'posva/vim-vue',                  {'for': 'vue'}
" Plug 'digitaltoad/vim-pug',            {'for': 'pug'}
Plug 'hashivim/vim-terraform',         {'for': 'terraform'}
" Plug 'mechatroner/rainbow_csv',        {'for': ['csv', 'tsv']}

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
set inccommand=nosplit

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
set ttimeoutlen=0  " keyboard timeout
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
set nolazyredraw

"" netrw
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"

"" Session Management
let g:session_directory = '~/.config/nvim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

"" Python Host Program
let g:python_host_prog  = expand('~/.pyenv/shims/python2')
let g:python3_host_prog = expand('~/.pyenv/shims/python3')

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set background=dark

set ruler
set number
set nowrap
set pumblend=20
set winblend=20

" set ambiwidth=double
let g:no_buffers_menu=1

set mousemodel=popup
set t_Co=256
set termguicolors
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

let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:cpp_class_scope_highlight = 1

set list
set listchars=tab:¦\ ,trail:-,eol:↲
set fillchars=vert:│
set signcolumn=yes
set nocursorcolumn
set cursorline

aug transparencyBG
    au!
    au ColorScheme * hi EndOfBuffer              guifg=bg
    au ColorScheme * hi NonText                  guifg=#404040
    au ColorScheme * hi SpecialKey               guifg=#404040
    au ColorScheme * hi LineNr                   guifg=#555555 guibg=#202020
    au ColorScheme * hi SignColumn                             guibg=#202020
    au ColorScheme * hi VertSplit   gui=none     guifg=#444444 guibg=#202020

    " au Colorscheme * hi Normal                                 guibg=none
    " au Colorscheme * hi NonText                                guibg=none
    " au ColorScheme * hi EndOfBuffer              guifg=#252525 guibg=none
    " au Colorscheme * hi LineNr                   guifg=#666666 guibg=none
    " au Colorscheme * hi SignColumn                             guibg=none
    " au Colorscheme * hi Folded                                 guibg=none
    " au ColorScheme * hi VertSplit                guifg=#444444 guibg=none

    au ColorScheme * hi CursorLine                             guibg=#303030
    au ColorScheme * hi Cursor      gui=reverse
aug END

colorscheme codedark
" colorscheme molokai
" colorscheme tender


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

"*****************************************************************************
"" Include user's local vim config
"*****************************************************************************
set runtimepath+=~/.config/nvim
ru! vimrc/*.vim
command! Vimrc silent e ~/dotfiles/nvim
command! Reload silent source ~/.config/nvim/init.vim

"*****************************************************************************
"" for denops testbench
"*****************************************************************************
" set runtimepath^=~/.config/nvim/tmp
" let g:denops#debug = 1
