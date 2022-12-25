scriptencoding utf-8
"*****************************************************************************
"" Plugin Configuration
"*****************************************************************************

"" fzf.vim
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_preview_window = ['right,50%,<70(down,60%)', 'ctrl-/']
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up"

" vim-lsp
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_insert_mode_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_inlay_hints_delay                = 0
let g:lsp_diagnostics_echo_delay           = 0
let g:lsp_diagnostics_signs_delay          = 0
let g:lsp_diagnostics_float_delay          = 0
let g:lsp_document_highlight_delay         = 0
let g:lsp_diagnostics_virtual_text_delay   = 0
let g:lsp_document_code_action_signs_delay = 0
let g:lsp_diagnostics_signs_priority = 20
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': ''}
let g:lsp_diagnostics_signs_hint = {'text': '？'}
let g:lsp_diagnostics_signs_information = {'text': 'ｉ'}
let g:lsp_document_code_action_signs_hint = {'text': ''}
" let g:lsp_diagnostics_signs_error = {'text': '❌'}
" let g:lsp_diagnostics_signs_warning = {'text': '⚠️'}
" let g:lsp_diagnostics_signs_hint = {'text': '💡'}
" let g:lsp_diagnostics_signs_information = {'text': 'ｉ'}
let g:lsp_document_code_action_signs_hint = {'text': '💡'}
hi LspErrorText gui=bold guifg=#ff0000 guibg=#1a1a1a
hi LspWarningText gui=bold guifg=#ffff00 guibg=#1a1a1a
hi LspInformationText gui=bold guifg=#ffffff guibg=#1a1a1a
hi LspHintText gui=bold guifg=#ffffff guibg=#1a1a1a
" hi clear LspWarningLine

" ddc.vim
hi PmenuSel guifg=#000000 guibg=#55ddff
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
let g:airline#extensions#default#layout = [
    \ ['a', 'b', 'c'],
    \ ['lsp_info', 'x', 'y', 'z']]
let g:airline_section_c = '%t'
let g:airline_section_lsp_info = '%{g:lsp_diagnostics_signs_error.text}:'
let g:airline_section_lsp_info.= '%{lsp#get_buffer_diagnostics_counts().error}  '
let g:airline_section_lsp_info.= '%{g:lsp_diagnostics_signs_warning.text}:'
let g:airline_section_lsp_info.= '%{lsp#get_buffer_diagnostics_counts().warning}  '
let g:airline_section_lsp_info.= '%{g:lsp_diagnostics_signs_hint.text}:'
let g:airline_section_lsp_info.= '%{lsp#get_buffer_diagnostics_counts().hint}  '
let g:airline_section_x = 'LOW:%3l/%L  COL:%3c'
let g:airline_section_y = '%{&filetype}'
if &fileformat ==# 'unix'
    let g:airline_section_z = '%{&fileencodings}, LN'
else
    let g:airline_section_z = '%{&fileencodings}, %{&fileformat}'
endif
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


"" fugitive
if exists('*fugitive#statusline')
    set statusline+=%{fugitive#statusline()}
endif


"" vim-gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_async = 1
let g:gitgutter_sign_priority = 10


"" ranger
let g:ranger_map_keys = 0
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
