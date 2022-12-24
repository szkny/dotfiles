scriptencoding utf-8
"*****************************************************************************
"" Plugin Configuration
"*****************************************************************************

"" fzf.vim
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_preview_window = ['hidden,right,50%,<70(down,40%)', 'ctrl-/']
let g:fzf_preview_window = ['right,50%,<70(down,60%)', 'ctrl-/']
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up"

" vim-lsp
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_insert_mode_enabled = 1
let g:lsp_diagnostics_signs_delay = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 0
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': ''}
let g:lsp_diagnostics_signs_information = {'text': 'ｉ'}
let g:lsp_diagnostics_signs_hint = {'text': '？'}
let g:lsp_document_code_action_signs_hint = {'text': ''}
" hi link LspErrorText GruvboxRedSign  " requires gruvbox
" hi PopupWindow ctermbg=lightblue guifg=#ff0000 guibg=lightblue
hi LspErrorText gui=bold guifg=#ff0000 guibg=#222222
hi LspWarningText gui=bold guifg=#ffff00 guibg=#222222
hi LspInformationText gui=bold guifg=#ffffff guibg=#222222
hi LspHintText gui=bold guifg=#ffffff guibg=#222222
hi clear LspWarningLine

" ddc.vim
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sources', [
 \ 'around',
 \ 'vim-lsp',
 \ 'file'
 \ ])
call ddc#custom#patch_global('sourceOptions', {
 \ '_': {
 \   'matchers': ['matcher_head'],
 \   'sorters': ['sorter_rank'],
 \   'converters': ['converter_remove_overlap'],
 \ },
 \ 'around': {'mark': 'Around'},
 \ 'vim-lsp': {
 \   'mark': 'lsp', 
 \   'matchers': ['matcher_head'],
 \   'forceCompletionPattern': '\.|:|->|"\w+/*'
 \ },
 \ 'file': {
 \   'mark': 'file',
 \   'isVolatile': v:true, 
 \   'forceCompletionPattern': '\S/\S*'
 \ }
 \ })
call ddc#enable()

"" neosnippet
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/neosnippet-snippets/neosnippets'
if finddir('dotfiles/nvim/snippets', $HOME) !=# ''
    let g:neosnippet#snippets_directory.=', ~/dotfiles/nvim/snippets'
endif


"" NERDTree
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 25
let g:NERDTreeShowHidden=1


"" fern.vim
let g:fern#renderer = 'nerdfont'
let g:fern#disable_default_mappings = 0


"" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_width = 25
let g:tagbar_sort = 0


""vista.vim
let g:vista_echo_cursor = 0
let g:vista_sidebar_width = 25
" let g:vista_icon_indent = ['└ ', '├ ']
let g:vista_icon_indent = ['└ ', '│ ']
let g:vista_default_executive = 'ctags'
let g:vista#renderer#enable_icon = 1
let g:vista_executive_for = {
    \ 'c': 'vim_lsp',
    \ 'go': 'vim_lsp',
    \ 'python': 'vim_lsp',
    \ 'javascript': 'vim_lsp',
    \ 'typescript': 'vim_lsp',
    \ }

"" tcomment_vim
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif
" let g:tcomment_types.SOME_LANG = '// %s'


"" jedi-vim
let g:jedi#auto_initialization = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#completions_enabled = 1
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#show_call_signatures = "0"
" let g:jedi#completions_command = "<C-Space>"


"" ale (Asynchronous Lint Engine)
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 0
let g:ale_change_sign_column_color = 0
let g:ale_completion_enabled = 1
if has('mac')
    " let g:ale_sign_error = '❌'
    " let g:ale_sign_warning = '⚠️'
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '⚠'
elseif system('uname') ==# "Linux\n"
    " let g:ale_sign_error = '❌'
    " let g:ale_sign_warning = '⚠️'
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = ''
    " let g:ale_sign_warning = '△'
    " let g:ale_sign_warning = '⚠'
endif
let g:ale_set_highlights = 1
let g:ale_c_clang_executable = 'clang++'
let g:ale_c_clang_options = '-std=c++11 -Wall'
let g:ale_c_clangtidy_checks = ['*']
let g:ale_c_clangtidy_executable = 'clang-tidy'
let g:ale_c_clangtidy_options = '-I../include'
let g:ale_c_cppcheck_executable = 'cppcheck'
let g:ale_c_cppcheck_options = '--enable=style'
let g:ale_c_gcc_executable = 'g++'
let g:ale_c_gcc_options = '-std=c++11 -Wall'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
let g:ale_statusline_format = [g:ale_sign_error.'%d', g:ale_sign_warning.'%d', '⬥ ok']
let g:ale_echo_msg_error_str = g:ale_sign_error
let g:ale_echo_msg_warning_str = g:ale_sign_warning
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
hi ALEErrorSign   gui=bold guifg=#ff0000 guibg=#222222
hi ALEWarningSign gui=None guifg=#ffff00 guibg=#222222


"" indent_guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['terminal', 'help', 'nerdtree', 'fzf']
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 4
let g:indent_guides_auto_colors = 0
au VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#303030 ctermbg=gray
au VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#222222 ctermbg=darkgray


"" indentLine
let g:indentLine_enabled = 0
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1


"" vim-airline
" let g:airline_theme = 'kalisi'
let g:airline_theme = 'codedark'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [['a', 'b', 'c', 'd'], ['x', 'y', 'z']]
let g:airline_section_c = '%t'
let g:airline_section_d = '%{airline#extensions#ale#get_error()}  '
let g:airline_section_d.= '%{airline#extensions#ale#get_warning()}'
let g:airline_section_x = 'LOW:%3l/%L  COL:%3c'
let g:airline_section_y = '%{&filetype}'
if &fileformat ==# 'unix'
    let g:airline_section_z = '%{&fileencodings}, LN'
else
    let g:airline_section_z = '%{&fileencodings}, %{&fileformat}'
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

"" vim-nerdtree-syntax-highlight
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb


"" fugitive
if exists('*fugitive#statusline')
    set statusline+=%{fugitive#statusline()}
endif


"" vim-gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_async = 1


"" ranger
let g:ranger_map_keys = 0
let g:NERDTreeHijackNetrw = 0  " add this line if you use NERDTree
" aug ReplaceNetrwByRangerVim
"     " open ranger when vim open a director
"     au!
"     au VimEnter * silent! au! FileExplorer
"     au BufEnter * if isdirectory(expand("%"))
"                \|     call OpenRangerOnVimLoadDir('%')
"                \|     file ranger
"                \|     setlocal filetype=terminal
"                \|     setlocal nonumber
"                \|     setlocal nobuflisted
"                \| endif
" aug END


"" open-browser
let g:netrw_nogx = 1
nmap <leader>w <Plug>(openbrowser-smart-search)
vmap <leader>w <Plug>(openbrowser-smart-search)


"" vim-devicons
" if has('mac')
"     let g:webdevicons_conceal_nerdtree_brackets = 1
"     let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
"     "" dir-icons
"     let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"     let g:DevIconsEnableFoldersOpenClose = 1
"     let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
"     let g:DevIconsDefaultFolderOpenSymbol = ''
"     "" file-icons
"     let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
"     let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
"     let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
"     let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
"     let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
"     "" installed-font
"     set guifont=Ricty\ Discord\ Regular\ Nerd\ Font\ Plus\ Font\ Awesome\ Plus\ Octicons\ Plus\ Pomicons\ Plus\ Font\ Linux:h14
" endif
