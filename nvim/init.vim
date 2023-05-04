scriptencoding utf-8

"*****************************************************************************
"" Vim-Jetpack core
"*****************************************************************************
"neovim + vim
let s:jetpackfile = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif
packadd vim-jetpack

"*****************************************************************************
"" Jetpack install packages
"*****************************************************************************
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1}

" general plugins
Jetpack 'tomtom/tcomment_vim'
Jetpack 'kevinhwang91/rnvimr'
Jetpack 'tpope/vim-fugitive'
Jetpack 'lewis6991/gitsigns.nvim'
Jetpack 'rbong/vim-flog'
Jetpack 'Raimondi/delimitMate'
Jetpack 'szkny/SplitTerm'
Jetpack 'junegunn/vim-easy-align'
Jetpack 'kevinhwang91/nvim-hlslens'
Jetpack 'liuchengxu/vista.vim'
" Jetpack 'mg979/vim-visual-multi', {'branch': 'master'}
Jetpack 'nvim-tree/nvim-tree.lua'
Jetpack 'dstein64/vim-startuptime'

" visual plugins
Jetpack 'nvim-tree/nvim-web-devicons'
Jetpack 'nvim-lualine/lualine.nvim'
Jetpack 'wfxr/minimap.vim',  {'on': 'MinimapToggle'}
Jetpack 'petertriho/nvim-scrollbar'
Jetpack 'akinsho/bufferline.nvim'
Jetpack 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}
Jetpack 'nvim-treesitter/nvim-treesitter', {'do': 'TSInstall'}
if has('wsl')
    Jetpack 'lukas-reineke/indent-blankline.nvim'
else
    Jetpack 'yggdroot/indentline'
endif

" color scheme
Jetpack 'tomasiser/vim-code-dark'
" Jetpack 'tomasr/molokai'
" Jetpack 'jacoborus/tender.vim'

" nvim-notify / noice.nvim
Jetpack 'MunifTanjim/nui.nvim'
Jetpack 'rcarriga/nvim-notify'
Jetpack 'folke/noice.nvim'

" fzf.vim
if isdirectory('/usr/local/opt/fzf')
    Jetpack '/usr/local/opt/fzf' | Jetpack 'junegunn/fzf.vim'
else
    Jetpack 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Jetpack 'junegunn/fzf.vim'
endif

" denops plugins
Jetpack 'vim-denops/denops.vim'
Jetpack 'vim-skk/skkeleton', { 'frozen': 1 }

" LSP
let g:use_coc_nvim = 1
let g:use_mason_nvim = 0
if get(g:, 'use_coc_nvim', 0) == 1
    " coc.nvim
    Jetpack 'neoclide/coc.nvim', {'branch': 'release'}
    Jetpack 'antoinemadec/coc-fzf', {'branch': 'release'}
elseif get(g:, 'use_mason_nvim', 0) == 1
    " mason.nvim
    Jetpack 'williamboman/mason.nvim'
    Jetpack 'williamboman/mason-lspconfig.nvim'
    Jetpack 'neovim/nvim-lspconfig'
else
    " vim-lsp
    Jetpack 'prabirshrestha/vim-lsp'
    Jetpack 'mattn/vim-lsp-settings'
    Jetpack 'shun/ddc-source-vim-lsp'
    Jetpack 'matsui54/denops-popup-preview.vim'
    Jetpack 'matsui54/denops-signature_help'
endif

" for ddc settings
" ddc core
Jetpack 'Shougo/ddc.vim'
" ddc UIs
Jetpack 'szkny/pum.vim'
Jetpack 'Shougo/ddc-ui-pum'
" Jetpack 'Shougo/ddc-ui-native'
" ddc sources
Jetpack 'Shougo/ddc-source-around'
Jetpack 'LumaKernel/ddc-source-file'
Jetpack 'Shougo/ddc-source-mocword'
Jetpack 'Shougo/ddc-source-cmdline'
Jetpack 'Shougo/ddc-source-cmdline-history'
Jetpack 'Shougo/neco-vim'
" ddc filters
Jetpack 'Shougo/ddc-matcher_head'
Jetpack 'Shougo/ddc-converter_remove_overlap'
Jetpack 'tani/ddc-fuzzy'
" " ddc etc.
" Jetpack 'hrsh7th/vim-vsnip'
" Jetpack 'hrsh7th/vim-vsnip-integ'

" c/c++
" Jetpack 'vim-jp/cpp-vim',                 {'for': 'cpp'}
"
" python
" Jetpack 'tweekmonster/braceless.vim',     {'for': 'python'}
Jetpack 'szkny/Ipython',                  {'for': 'python'}
" Jetpack 'szkny/IpdbDebugger',             {'for': 'python'}
" Jetpack 'szkny/jupyter-vim',              {'for': 'python'}
"
" " golang
" Jetpack 'fatih/vim-go',                   {'for': 'go'}
"
" " julia
" Jetpack 'JuliaEditorSupport/julia-vim',   {'for': 'julia'}
"
" " javascript
" " Jetpack 'prettier/vim-prettier',  { 'for': ['javascript', 'typescript', 'css', 'json', 'markdown', 'vue', 'yaml', 'html'] }
"
" " misc
Jetpack 'elzr/vim-json',                  {'for': 'json'}
Jetpack 'raimon49/requirements.txt.vim',  {'for': 'requirements'}
Jetpack 'cespare/vim-toml',               {'for': 'toml'}
" Jetpack 'kannokanno/previm',              {'for': 'markdown'}
" Jetpack 'godlygeek/tabular',              {'for': 'markdown'}
" Jetpack 'preservim/vim-markdown',         {'for': 'markdown'}
" Jetpack 'yaasita/ore_markdown',           {'for': 'markdown'}
" Jetpack 'vim-scripts/applescript.vim',    {'for': 'applescript'}
" Jetpack 'aklt/plantuml-syntax',           {'for': 'plantuml'}
Jetpack 'posva/vim-vue',                  {'for': 'vue'}
" Jetpack 'digitaltoad/vim-pug',            {'for': 'pug'}
Jetpack 'hashivim/vim-terraform',         {'for': 'terraform'}
Jetpack 'pearofducks/ansible-vim'
" Jetpack 'mechatroner/rainbow_csv',        {'for': ['csv', 'tsv']}
call jetpack#end()

" Required: ftpluginディレクトリをロードする
filetype plugin indent on

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
set fillchars=vert:│,eob:\ 
set signcolumn=yes
set nocursorcolumn
set cursorline

aug transparencyBG
    au!
    " au ColorScheme * hi EndOfBuffer              guifg=bg
    " au ColorScheme * hi NonText                  guifg=#404040
    " au ColorScheme * hi SpecialKey               guifg=#404040
    " au ColorScheme * hi LineNr                   guifg=#555555 guibg=#202020
    " au ColorScheme * hi SignColumn                             guibg=#202020
    " au ColorScheme * hi VertSplit   gui=none     guifg=#444444 guibg=#202020

    au Colorscheme * hi Normal                                 guibg=none
    au Colorscheme * hi NonText                                guibg=none
    au ColorScheme * hi EndOfBuffer              guifg=#252525 guibg=none
    au Colorscheme * hi LineNr                   guifg=#666666 guibg=none
    au Colorscheme * hi SignColumn                             guibg=none
    au Colorscheme * hi Folded                                 guibg=none
    au ColorScheme * hi VertSplit                guifg=#555555 guibg=none

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
