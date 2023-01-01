scriptencoding utf-8
"*****************************************************************************
"" Plugin Configuration
"*****************************************************************************

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  'find * -path "*/\.*" -prune -o -path "node_modules/**" -prune -o -path "target/**" -prune -o -path "dist/**" -prune -o  -type f -print -o -type l -print 2> /dev/null'
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up"
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_preview_window = ['right,50%,<70(down,60%)', 'ctrl-/']
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


"" vim-lsp
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_insert_mode_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_prefix = " » "
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_inlay_hints_delay                = 0
let g:lsp_diagnostics_echo_delay           = 0
let g:lsp_diagnostics_signs_delay          = 0
let g:lsp_diagnostics_float_delay          = 0
let g:lsp_document_highlight_delay         = 0
let g:lsp_diagnostics_virtual_text_delay   = 0
let g:lsp_document_code_action_signs_delay = 0
let g:lsp_diagnostics_signs_priority = 20
let g:lsp_diagnostics_signs_priority_map = {
    \ 'LspError': 20,
    \ 'LspWarning': 15,
    \ 'LspHint': 10,
    \ 'LspInformation': 5,
    \ }
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': ''}
let g:lsp_diagnostics_signs_hint = {'text': '?'}
" let g:lsp_diagnostics_signs_error = {'text': '❌'}
" let g:lsp_diagnostics_signs_warning = {'text': '⚠️'}
" let g:lsp_diagnostics_signs_hint = {'text': '💡'}
let g:lsp_diagnostics_signs_information = {'text': 'i'}
let g:lsp_document_code_action_signs_hint = {'text': '💡'}
hi LspErrorText              gui=bold        guifg=#ff0000
hi LspWarningText            gui=bold        guifg=#ffff00
hi LspInformationText        gui=bold        guifg=#ffffff
hi LspHintText               gui=bold        guifg=#ffffff
hi LspErrorVirtualText       gui=bold,italic guifg=#ff0000
hi LspWarningVirtualText     gui=bold,italic guifg=#ffff00
hi LspInformationVirtualText gui=bold,italic guifg=#ffffff
hi LspHintVirtualText        gui=bold,italic guifg=#ffffff


"" ddc.vim + pum.vim
set shortmess+=c
set wildoptions+=pum
hi PmenuSel gui=bold guifg=#000000 guibg=#55ddff
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('autoCompleteEvents', [
    \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
    \ 'CmdlineEnter', 'CmdlineChanged',
    \ ])
call ddc#custom#patch_global('sources', [
 \ 'around',
 \ 'vim-lsp',
 \ 'file',
 \ 'skkeleton',
 \ ])
call ddc#custom#patch_global('sourceOptions', #{
 \ _: #{
 \   matchers: ['matcher_head'],
 \   sorters: ['sorter_rank'],
 \   converters: ['converter_remove_overlap'],
 \   minAutoCompleteLength: 1,
 \ },
 \ around: #{
 \   mark: '[AROUND]',
 \   maxSize: 1000,
 \ },
 \ vim-lsp: #{
 \   mark: '[LSP]', 
 \   matchers: ['matcher_head'],
 \   forceCompletionPattern: '\.|:|->|"\w+/*',
 \ },
 \ file: #{
 \   mark: '[FILE]',
 \   isVolatile: v:true, 
 \   forceCompletionPattern: '\S/\S*',
 \ },
 \ skkeleton: #{
 \   mark: 'skkeleton',
 \   matchers: ['skkeleton'],
 \   sorters: [],
 \   minAutoCompleteLength: 1,
 \   isVolatile: v:true,
 \ },
 \ })
" "" ddc.vim extensions: cmdline, cmdline-history
" call ddc#custom#patch_global('cmdlineSources', {
"   \ ':': ['cmdline-history', 'cmdline', 'around'],
"   \ '@': ['cmdline-history', 'input', 'file', 'around'],
"   \ '>': ['cmdline-history', 'input', 'file', 'around'],
"   \ '/': ['around', 'line'],
"   \ '?': ['around', 'line'],
"   \ '-': ['around', 'line'],
"   \ '=': ['input'],
"   \ })
" fun! DdcCommandlinePre() abort
"   " Note: It disables default command line completion!
"   cno <C-n> <Cmd>call pum#map#select_relative(+1)<CR>
"   " cno <expr> <C-n>
"   "   \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : ddc#manual_complete()
"   cno <C-p> <Cmd>call pum#map#select_relative(-1)<CR>
"   cno <C-y> <Cmd>call pum#map#confirm()<CR>
"   cno <C-e> <Cmd>call pum#map#cancel()<CR>
"   " Overwrite sources
"   if !exists('b:prev_buffer_config')
"     let b:prev_buffer_config = ddc#custom#get_buffer()
"   endif
"   call ddc#custom#patch_buffer('sources', [
"     \ 'cmdline',
"     \ 'cmdline-history',
"     \ 'necovim',
"     \ 'around',
"     \ ])
"   call ddc#custom#patch_buffer('sourceOptions', #{
"     \ cmdline: #{
"     \   mark: '[CMDLINE]',
"     \ },
"     \ cmdline-history: #{
"     \   mark: '[HISTORY]',
"     \ },
"     \ necovim: #{
"     \   mark: '[VIM]',
"     \ },
"     \ })
"   au User DDCCmdlineLeave ++once call DdcCommandlinePost()
"   au InsertEnter <buffer> ++once call DdcCommandlinePost()
"   " Enable command line completion
"   call ddc#enable_cmdline_completion()
" endf
" fun! DdcCommandlinePost() abort
"   cunmap <C-n>
"   cunmap <C-p>
"   cunmap <C-y>
"   cunmap <C-e>
"   " Restore sources
"   if exists('b:prev_buffer_config')
"     call ddc#custom#set_buffer(b:prev_buffer_config)
"     unlet b:prev_buffer_config
"   else
"     call ddc#custom#set_buffer({})
"   endif
" endf
" "" ddc.vim extensions: neco-vim
" if !exists('g:necovim#complete_functions')
"   let g:necovim#complete_functions = {}
" endif
" let g:necovim#complete_functions.Ref = 'ref#complete'
call ddc#enable()


"" skkeleton
fun! s:skkeleton_init() abort
    call skkeleton#config(#{
      \ globalJisyo: '~/.skk/SKK-JISYO.L',
      \ kanaTable: 'rom',
      \ eggLikeNewline: v:true,
      \ usePopup: v:false,
      \ registerConvertResult: v:true,
      \ acceptIllegalResult: v:true,
      \ keepState: v:false,
      \ })
    call skkeleton#register_kanatable('rom', {
      \ "\<Space>": ["\u3000", ''],
      \ })
    call add(g:skkeleton#mapped_keys, '<C-h>')
    call add(g:skkeleton#mapped_keys, '<F6>')
    call add(g:skkeleton#mapped_keys, '<F7>')
    call add(g:skkeleton#mapped_keys, '<F8>')
    call add(g:skkeleton#mapped_keys, '<F9>')
    call add(g:skkeleton#mapped_keys, '<F10>')
    call add(g:skkeleton#mapped_keys, '<C-k>')
    call add(g:skkeleton#mapped_keys, '<C-q>')
    call add(g:skkeleton#mapped_keys, '<C-a>')
    call skkeleton#register_keymap('input', '<C-h>', '')
    call skkeleton#register_keymap('input', '<F6>',  'katakana')
    call skkeleton#register_keymap('input', '<F7>',  'katakana')
    call skkeleton#register_keymap('input', '<F8>',  'hankatakana')
    call skkeleton#register_keymap('input', '<F9>',  'zenkaku')
    call skkeleton#register_keymap('input', '<F10>', 'disable')
    call skkeleton#register_keymap('input', '<C-k>', 'katakana')
    call skkeleton#register_keymap('input', '<C-q>', 'hankatakana')
    call skkeleton#register_keymap('input', '<C-a>', 'zenkaku')
endf
aug skkeleton-initialize-pre
  au!
  au User skkeleton-initialize-pre call s:skkeleton_init()
aug END
aug skkeleton-mode-changed
  au!
  au User skkeleton-mode-changed redrawstatus
aug END
fun! Airline_skkeleton_mode() abort
    let l:current_mode = mode()
    if (l:current_mode=='i' || l:current_mode=='c') && skkeleton#is_enabled()
        let l:mode_dict = #{
          \ hira:    'あ',
          \ kata:    'ア',
          \ hankata: '_ｱ',
          \ zenkaku: 'Ａ',
          \ abbrev:  'abbr',
          \ }
        let l:mode = mode_dict[skkeleton#mode()]
        return '  IME:'.l:mode
    else
        return ''
    endif
endf


"" neosnippet
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/neosnippet-snippets/neosnippets'
if finddir('dotfiles/nvim/snippets', $HOME) !=# ''
    let g:neosnippet#snippets_directory.=', ~/dotfiles/nvim/snippets'
endif


"" fern.vim
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden = 1
let g:fern#hide_cursor = 0
let g:fern#disable_default_mappings = 0
let g:fern#disable_viewer_smart_cursor = 0
fun! s:init_fern() abort
    setlocal filetype=fern
    setlocal nonumber
    setlocal signcolumn=no
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nolist
    setlocal nospell
    setlocal lazyredraw
    nno <silent><buffer> I             <Plug>(fern-action-hidden)
    nno <silent><buffer> <BS>          <Plug>(fern-action-hidden)
    nno <silent><buffer> r             <Plug>(fern-action-reload:all)
    nno <silent><buffer> h             <Plug>(fern-action-collapse)
    nno <silent><buffer> l             <Plug>(fern-action-open-or-expand)
    nno <silent><buffer> o             <Plug>(fern-action-open-or-expand)
    nno <silent><buffer> <CR>          <Plug>(fern-action-open-or-expand-or-collapse)
    nno <silent><buffer> <2-LeftMouse> <Plug>(fern-action-open-or-expand-or-collapse)
    nno <silent><buffer><expr>         <Plug>(fern-action-open-or-expand-or-collapse)
          \ fern#smart#leaf(
          \   "<Plug>(fern-action-open)",
          \   "<Plug>(fern-action-expand)",
          \   "<Plug>(fern-action-collapse)",
          \ )
    nno <silent><buffer> <C-h>         <Plug>(fern-action-leave)
    nno <silent><buffer> <C-l>         <Plug>(fern-action-enter)
    nno <silent><buffer> -             <Plug>(fern-action-mark):setlocal signcolumn=yes<CR>
    nno <silent><buffer> p             <Plug>(fern-action-preview:auto:toggle)
    hi FernBranchText guifg=#88ccff
endf
aug fern-custom
    au! *
    au FileType fern call s:init_fern()
aug END


""vista.vim
let g:vista_no_mappings = 0
let g:vista_echo_cursor = 0
let g:vista_blink = [3, 200]
let g:vista_top_level_blink = [3, 200]
let g:vista_highlight_whole_line = 1
let g:vista_update_on_text_changed = 1
let g:vista_sidebar_width = 25
let g:vista_icon_indent = ['└ ', '│ ']
let g:vista_default_executive = 'ctags'
let g:vista#renderer#enable_icon = 1
let g:vista_fzf_preview = ['right,50%,<70(down,60%)']
let g:vista_fzf_opt = ['--bind=ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up']
let g:vista_default_executive = 'vim_lsp'
let g:vista_executive_for = {
    \ 'c': 'vim_lsp',
    \ 'go': 'vim_lsp',
    \ 'python': 'vim_lsp',
    \ 'javascript': 'vim_lsp',
    \ 'typescript': 'vim_lsp',
    \ }
fun! VistaNearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endf


"" minimap.vim
let g:minimap_auto_start                        = 0
let g:minimap_auto_start_win_enter              = 0
let g:minimap_width                             = 10
let g:minimap_window_width_override_for_scaling = 2147483647
let g:minimap_block_filetypes                   = ['terminal', 'fern', 'fzf', 'vista_kind']
" let g:minimap_close_buftypes                   = ['nofile', 'startify', 'netrw', 'vim-plug', 'terminal']
let g:minimap_enable_highlight_colorgroup = 0
let g:minimap_highlight_range             = 1
let g:minimap_highlight_search            = 1
let g:minimap_git_colors                  = 1
let g:minimap_cursor_color_priority       = 110
let g:minimap_search_color_priority       = 120
let g:minimap_base_highlight   = 'Normal'
let g:minimap_cursor_color     = 'MyMinimapCursor'
let g:minimap_range_color      = 'MyMinimapRange'
let g:minimap_search_color     = 'MyMinimapSearch'
let g:minimap_diff_color       = 'MyMinimapDiffLine'
let g:minimap_diffadd_color    = 'MyMinimapDiffAdded'
let g:minimap_diffremove_color = 'MyMinimapDiffRemoved'
hi MyMinimapCursor      guifg=#000000 guibg=#ffffff
hi MyMinimapRange       guifg=#ffffff guibg=#555555
hi MyMinimapSearch      guifg=#ffffff guibg=#aaaa00
hi MyMinimapDiffLine    guifg=#ffff00
hi MyMinimapDiffAdded   guifg=#00ff00
hi MyMinimapDiffRemoved guifg=#ff0000


"" tcomment_vim
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif


"" indentline
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['│']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1
let g:indentLine_fileTypeExclude = ['terminal', 'help', 'fern', 'fzf', 'vista_kind']


"" indent_guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['terminal', 'help', 'fern', 'fzf', 'vista_kind']
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
au VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#252525
au VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#303030


"" vim-airline
" let g:airline_theme = 'kalisi'
let g:airline_theme = 'codedark'
let g:airline_mode_map = {
  \ '__' : '------',
  \ 'n' : 'NORMAL',
  \ 'no' : 'OP PENDING',
  \ 'nov' : 'OP PENDING CHAR',
  \ 'noV' : 'OP PENDING LINE',
  \ 'no' : 'OP PENDING BLOCK',
  \ 'niI' : 'INSERT (NORMAL)',
  \ 'niR' : 'REPLACE (NORMAL)',
  \ 'niV' : 'V REPLACE (NORMAL)',
  \ 'v' : 'VISUAL',
  \ 'V' : 'V-LINE',
  \ '' : 'V-BLOCK',
  \ 's' : 'SELECT',
  \ 'S' : 'S-LINE',
  \ '' : 'S-BLOCK',
  \ 'i' : 'INSERT',
  \ 'ic' : 'INSERT',
  \ 'ix' : 'INSERT',
  \ 'R' : 'REPLACE',
  \ 'Rc' : 'REPLACE C',
  \ 'Rv' : 'V REPLACE',
  \ 'Rx' : 'REPLACE X',
  \ 'c'  : 'COMMAND',
  \ 'cv'  : 'VIM EX',
  \ 'ce'  : 'EX',
  \ 'r'  : 'PROMPT',
  \ 'rm'  : 'MORE PROMPT',
  \ 'r?'  : 'CONFIRM',
  \ '!'  : 'SHELL',
  \ 't'  : 'TERMINAL',
  \ 'multi' : 'MULTI',
  \ }
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [
    \ ['a', 'b', 'c', 'd'],
    \ ['lsp_info', 'x', 'y', 'z']]
let g:airline_section_a = airline#section#create(['mode', '%{Airline_skkeleton_mode()}'])
let g:airline_section_c = '%t'
let g:airline_section_d = '%{VistaNearestMethodOrFunction()}'
let g:airline_section_lsp_info = '%{g:lsp_diagnostics_signs_error.text}:'
let g:airline_section_lsp_info.= '%{lsp#get_buffer_diagnostics_counts().error} '
let g:airline_section_lsp_info.= '%{g:lsp_diagnostics_signs_warning.text}:'
let g:airline_section_lsp_info.= '%{lsp#get_buffer_diagnostics_counts().warning} '
let g:airline_section_lsp_info.= '%{g:lsp_diagnostics_signs_hint.text}:'
let g:airline_section_lsp_info.= '%{lsp#get_buffer_diagnostics_counts().hint}'
let g:airline_section_x = '%3l/%L :%2c'
let g:airline_section_y = '%{&filetype}'
let g:airline_section_z = '%{&fileencodings}, %{&fileformat}'
let g:airline#extensions#default#section_truncate_width = {}
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
let g:gitgutter_sign_priority = 5
let g:gitgutter_map_keys = 0


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
