scriptencoding utf-8

"*****************************************************************************
"" Vim-Plug core
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
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'rbong/vim-flog'
Plug 'Raimondi/delimitMate'
Plug 'szkny/SplitTerm'
Plug 'junegunn/vim-easy-align'
Plug 'kevinhwang91/nvim-hlslens'
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
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
if has('wsl')
    Plug 'lukas-reineke/indent-blankline.nvim'
else
    Plug 'yggdroot/indentline'
endif

" color scheme
Plug 'tomasiser/vim-code-dark'
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
    Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
elseif get(g:, 'use_mason_nvim', 0) == 1
    " mason.nvim
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
else
    " vim-lsp
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'shun/ddc-source-vim-lsp'
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
" Plug 'kannokanno/previm',              {'for': 'markdown'}
" Plug 'godlygeek/tabular',              {'for': 'markdown'}
" Plug 'preservim/vim-markdown',         {'for': 'markdown'}
" Plug 'yaasita/ore_markdown',           {'for': 'markdown'}
" Plug 'vim-scripts/applescript.vim',    {'for': 'applescript'}
" Plug 'aklt/plantuml-syntax',           {'for': 'plantuml'}
Plug 'posva/vim-vue',                  {'for': 'vue'}
" Plug 'digitaltoad/vim-pug',            {'for': 'pug'}
Plug 'hashivim/vim-terraform',         {'for': 'terraform'}
Plug 'pearofducks/ansible-vim'
" Plug 'mechatroner/rainbow_csv',        {'for': ['csv', 'tsv']}

call plug#end()

" Required: ftpluginディレクトリをロードする
filetype plugin indent on

"*****************************************************************************
"" Ignore default plugins
"*****************************************************************************
lua vim.api.nvim_set_var('did_install_default_menus' , 1)
lua vim.api.nvim_set_var('did_install_syntax_menu'   , 1)
lua vim.api.nvim_set_var('did_indent_on'             , 1)
lua vim.api.nvim_set_var('did_load_filetypes'        , 1)
lua vim.api.nvim_set_var('did_load_ftplugin'         , 1)
lua vim.api.nvim_set_var('loaded_2html_plugin'       , 1)
lua vim.api.nvim_set_var('loaded_gzip'               , 1)
lua vim.api.nvim_set_var('loaded_man'                , 1)
lua vim.api.nvim_set_var('loaded_matchit'            , 1)
lua vim.api.nvim_set_var('loaded_matchparen'         , 1)
lua vim.api.nvim_set_var('loaded_netrwPlugin'        , 1)
lua vim.api.nvim_set_var('loaded_remote_plugins'     , 1)
lua vim.api.nvim_set_var('loaded_shada_plugin'       , 1)
lua vim.api.nvim_set_var('loaded_spellfile_plugin'   , 1)
lua vim.api.nvim_set_var('loaded_tarPlugin'          , 1)
lua vim.api.nvim_set_var('loaded_tutor_mode_plugin'  , 1)
lua vim.api.nvim_set_var('loaded_zipPlugin'          , 1)
lua vim.api.nvim_set_var('skip_loading_mswin'        , 1)

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
lua vim.opt.fileencoding = 'utf-8'
lua vim.opt.fileencodings = 'utf-8'
lua vim.opt.fileformats = 'unix,dos,mac'
lua vim.opt.bomb = true
lua vim.opt.binary = true

"" Fix backspace indent
" lua vim.opt.backspace = 'indent', 'eol', 'start'
lua vim.opt.backspace = 'indent,eol,start'

"" Tabs. May be overriten by autocmd rules
lua vim.opt.tabstop = 4
lua vim.opt.softtabstop = 0
lua vim.opt.shiftwidth = 4
lua vim.opt.expandtab = true

"" Enable hidden buffers
lua vim.opt.hidden = true

"" Searching
lua vim.opt.hlsearch = ture
lua vim.opt.incsearch = ture
lua vim.opt.ignorecase = ture
lua vim.opt.smartcase = ture
lua vim.opt.inccommand = 'nosplit'

"" completion
lua vim.opt.complete:remove('t')

"" Copy/Paste/Cut
lua if vim.fn.has('wsl') == 1 then
  \     vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  \       pattern = '*',
  \       command = ":call system('clip.exe', @\")",
  \     })
  \ else
  \     vim.opt.clipboard:append({unnamedplus = true})
  \ end

"" Directories for swp files
lua vim.opt.backup = false
lua vim.opt.swapfile = false

"" Time (msec)
lua vim.opt.ttimeoutlen = 0
lua vim.opt.updatetime = 500

"" etc..
lua vim.opt.shell = os.getenv('SHELL') or '/bin/sh'
lua vim.opt.autoread = true
lua vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'
lua vim.opt.mouse = 'a'
lua vim.opt.smartindent = true
lua vim.opt.wildmenu = true
lua vim.opt.splitbelow = true
lua vim.opt.splitright = true
lua vim.opt.virtualedit = 'onemore'
lua vim.opt.foldmethod = 'manual'
lua vim.opt.lazyredraw = false

"" netrw
lua vim.api.nvim_set_var('netrw_liststyle' , 3)
lua vim.api.nvim_set_var('netrw_banner'    , 0)
lua vim.api.nvim_set_var('netrw_sizestyle' , 'H')
lua vim.api.nvim_set_var('netrw_timefmt'   , '%Y/%m/%d(%a) %H:%M:%S')

"" Session Management
lua vim.api.nvim_set_var('session_directory'       , '~/.config/nvim/session')
lua vim.api.nvim_set_var('session_autoload'        , 'no')
lua vim.api.nvim_set_var('session_autosave'        , 'no')
lua vim.api.nvim_set_var('session_command_aliases' , 1)

"" Python Host Program
lua vim.api.nvim_set_var('python_host_prog'  , '~/.pyenv/shims/python2')
lua vim.api.nvim_set_var('python3_host_prog' , '~/.pyenv/shims/python3')

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
lua vim.opt.ruler = true
lua vim.opt.number = true
lua vim.opt.wrap = false
lua vim.opt.pumblend = 20
lua vim.opt.winblend = 20

lua vim.api.nvim_set_var('no_buffers_menu', 1)

lua vim.opt.mousemodel = 'popup'
" set t_Co=256
lua vim.opt.termguicolors = true
lua vim.opt.background = 'dark'

"" Change cursor by mode
lua vim.opt.guicursor = 'n-v-c:block-Cursor,i:ver100-iCursor,n-v-c:blinkon0,i:blinkwait10'
" if &term =~ '^xterm'
"     " normal mode
"     let &t_EI .= "\<Esc>[0 q"
"     " insert mode
"     let &t_SI .= "\<Esc>[6 q"
" endif

lua vim.opt.scrolloff = 3

"" Status bar
lua vim.opt.laststatus = 2
lua vim.opt.showtabline = 1
lua vim.opt.showmode = false

"" Use modeline overrides
lua vim.opt.modeline = true
lua vim.opt.modelines = 10

lua vim.api.nvim_set_var('enable_bold_font' , 1)
lua vim.api.nvim_set_var('enable_italic_font' , 1)
lua vim.api.nvim_set_var('cpp_class_scope_highlight' , 1)

lua vim.opt.list = true
lua vim.opt.listchars = 'tab:¦ ,trail:-,eol:↲'
lua vim.opt.fillchars = 'vert:│,eob: '
lua vim.opt.signcolumn = 'yes'
lua vim.opt.cursorcolumn = false
lua vim.opt.cursorline = true

aug transparencyBG
    au!
    " au ColorScheme * hi EndOfBuffer              guifg=bg
    " au ColorScheme * hi NonText                  guifg=#404040
    " au ColorScheme * hi SpecialKey               guifg=#404040
    " au ColorScheme * hi LineNr                   guifg=#555555 guibg=#202020
    " au ColorScheme * hi SignColumn                             guibg=#202020
    " au ColorScheme * hi VertSplit   gui=none     guifg=#444444 guibg=#202020

    au ColorScheme * hi Normal                                 guibg=none
    au ColorScheme * hi NonText                                guibg=none
    au ColorScheme * hi EndOfBuffer              guifg=#252525 guibg=none
    au ColorScheme * hi LineNr                   guifg=#666666 guibg=none
    au ColorScheme * hi SignColumn                             guibg=none
    au ColorScheme * hi Folded                                 guibg=none
    au ColorScheme * hi VertSplit                guifg=#555555 guibg=none

    au ColorScheme * hi CursorLine                             guibg=#303030
    au ColorScheme * hi Cursor      gui=reverse
aug END
" lua vim.cmd([[
"   \     augroup transparencyBG
"   \         autocmd!
"   \         " autocmd ColorScheme * hi EndOfBuffer              guifg=bg
"   \         " autocmd ColorScheme * hi NonText                  guifg=#404040
"   \         " autocmd ColorScheme * hi SpecialKey               guifg=#404040
"   \         " autocmd ColorScheme * hi LineNr                   guifg=#555555 guibg=#202020
"   \         " autocmd ColorScheme * hi SignColumn                             guibg=#202020
"   \         " autocmd ColorScheme * hi VertSplit   gui=none     guifg=#444444 guibg=#202020
"   \
"   \         autocmd ColorScheme * hi Normal                                 guibg=none
"   \         autocmd ColorScheme * hi NonText                                guibg=none
"   \         autocmd ColorScheme * hi EndOfBuffer              guifg=#252525 guibg=none
"   \         autocmd ColorScheme * hi LineNr                   guifg=#666666 guibg=none
"   \         autocmd ColorScheme * hi SignColumn                             guibg=none
"   \         autocmd ColorScheme * hi Folded                                 guibg=none
"   \         autocmd ColorScheme * hi VertSplit                guifg=#555555 guibg=none
"   \
"   \         autocmd ColorScheme * hi CursorLine                             guibg=#303030
"   \         autocmd ColorScheme * hi Cursor      gui=reverse
"   \     aug END
"   \ ]])

lua vim.cmd('colorscheme codedark')


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
lua vim.api.nvim_command('set runtimepath+=~/.config/nvim')
lua vim.api.nvim_command('ru! vimrc/*.vim')
command! Vimrc silent e ~/dotfiles/nvim
command! Reload silent source ~/.config/nvim/init.vim

"*****************************************************************************
"" for denops testbench
"*****************************************************************************
" set runtimepath^=~/.config/nvim/tmp
" let g:denops#debug = 1
