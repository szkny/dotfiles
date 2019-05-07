scriptencoding utf-8
" plugin settings

" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  'find * -path "*/\.*" -prune -o -path "node_modules/**" -prune -o -path "target/**" -prune -o -path "dist/**" -prune -o  -type f -print -o -type l -print 2> /dev/null'
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep(
                \'rg --column --line-number --no-heading --fixed-strings --ignore-case '
                \.'--hidden --follow --glob "!.git/*" --color "always" '
                \.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" ALE
let g:ale_linters_explicit = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
" let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 0
let g:ale_change_sign_column_color = 0
let g:ale_completion_enabled = 1
let g:ale_set_highlights = 1
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
let g:ale_statusline_format = [g:ale_sign_error.'%d', g:ale_sign_warning.'%d', '⬥ ok']
let g:ale_echo_msg_error_str = g:ale_sign_error
let g:ale_echo_msg_warning_str = g:ale_sign_warning
hi ALEErrorSign   gui=bold guifg=#ff0000 guibg=#222222
hi ALEWarningSign gui=None guifg=#ffff00 guibg=#222222

" PyFlake
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10

" indent guide
" let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
" hi IndentGuidesOdd  guibg=#113344
" hi IndentGuidesEven guibg=#223344
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#113344 ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#223344 ctermbg=darkgray

" NERDTree
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 25

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_width = 40
let g:tagbar_sort = 0


" tcomment_vim
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif

" vim-airline
" let g:airline_theme = 'powerlineish'
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
" let g:airline_skip_empty_sections = 1
" let g:airline#extensions#virtualenv#enabled = 1
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" if !exists('g:airline_powerline_fonts')
"     let g:airline#extensions#tabline#left_sep = ' '
"     let g:airline#extensions#tabline#left_alt_sep = '|'
"     let g:airline_left_sep          = '▶'
"     " let g:airline_left_sep          = ''
"     let g:airline_left_alt_sep      = '»'
"     let g:airline_right_sep         = '◀'
"     " let g:airline_right_sep         = ''
"     let g:airline_right_alt_sep     = '«'
"     let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
"     let g:airline#extensions#readonly#symbol   = '⊘'
"     let g:airline#extensions#linecolumn#prefix = '¶'
"     let g:airline#extensions#paste#symbol      = 'ρ'
"     let g:airline_symbols.linenr    = '␊'
"     let g:airline_symbols.branch    = '⎇'
"     let g:airline_symbols.paste     = 'ρ'
"     let g:airline_symbols.paste     = 'Þ'
"     let g:airline_symbols.paste     = '∥'
"     let g:airline_symbols.whitespace = 'Ξ'
" else
"     let g:airline#extensions#tabline#left_sep = ''
"     let g:airline#extensions#tabline#left_alt_sep = ''
"     " powerline symbols
"     let g:airline_left_sep = ''
"     let g:airline_left_alt_sep = ''
"     let g:airline_right_sep = ''
"     let g:airline_right_alt_sep = ''
"     let g:airline_symbols.branch = ''
"     let g:airline_symbols.readonly = ''
"     let g:airline_symbols.linenr = ''
" endif
"
let g:airline_theme = 'kalisi'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
let g:airline_section_b = '%{airline#extensions#ale#get_error()}  '
let g:airline_section_b.= '%{airline#extensions#ale#get_warning()}'
let g:airline_section_c = '%t'
let g:airline_section_x = 'LOW:%3l/%L  COL:%3c'
let g:airline_section_y = '%{&filetype}'
if &fileformat ==# 'unix'
    let g:airline_section_z = '%{&fileencoding}, LN'
else
    let g:airline_section_z = '%{&fileencoding}, %{&fileformat}'
endif
let g:airline#extensions#ale#error_symbol = g:ale_sign_error.'  '
let g:airline#extensions#ale#warning_symbol = g:ale_sign_warning.'  '
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#whitespace#enabled = 1
"" vim-airline separator
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#left_sep  = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline#extensions#tabline#left_alt_sep  = '|'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
