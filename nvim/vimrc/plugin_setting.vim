scriptencoding utf-8
"*****************************************************************************
"" Plugin Configuration
"*****************************************************************************

" "" nvim-notify (neovim0.9.0-devではluajitのbitが使えないのでエラー)
" lua require("notify").setup({
"   \   stages = "fade_in_slide_out",
"   \   on_open = nil,
"   \   on_close = nil,
"   \   render = "default",
"   \   timeout = 3000,
"   \   background_colour = "Normal",
"   \   minimum_width = 50,
"   \   icons = {
"   \     ERROR = "",
"   \     WARN = "",
"   \     INFO = "",
"   \     DEBUG = "",
"   \     TRACE = "✎",
"   \   },
"   \ })


" "" noice.nvim (neovim0.9.0-devではluajitのjitが使えないのでエラー)
" lua  require("noice").setup({
"   \   lsp = {
"   \     override = {
"   \       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
"   \       ["vim.lsp.util.stylize_markdown"] = true,
"   \       ["cmp.entry.get_documentation"] = true,
"   \     },
"   \   },
"   \   presets = {
"   \     bottom_search = true,
"   \     command_palette = true,
"   \     long_message_to_split = true,
"   \     inc_rename = false,
"   \     lsp_doc_border = false,
"   \   },
"   \ })


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
" let g:lsp_diagnostics_virtual_text_prefix = " » "
let g:lsp_diagnostics_virtual_text_prefix = "■ "
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
" let g:lsp_diagnostics_signs_hint = {'text': '？'}
let g:lsp_diagnostics_signs_information = {'text': 'i'}
let g:lsp_document_code_action_signs_hint = {'text': '💡'}
hi LspErrorText              gui=bold guifg=#ff0000
hi LspWarningText            gui=bold guifg=#ffff00
hi LspInformationText        gui=bold guifg=#ffffff
hi LspHintText               gui=bold guifg=#00ff00
hi LspErrorVirtualText       gui=bold,underline guifg=#ff0000
hi LspWarningVirtualText     gui=bold,underline guifg=#ffff00
hi LspInformationVirtualText gui=bold,underline guifg=#ffffff
hi LspHintVirtualText        gui=bold,underline guifg=#00ff00


"" ddc.vim + pum.vim
set shortmess+=c
set wildoptions+=pum
hi PumNormalMenu gui=none guifg=#dddddd guibg=#2a2a2a
hi PumColumnKind gui=none guifg=#888888 guibg=#2a2a2a
hi PumColumnMenu gui=none guifg=#888888 guibg=#2a2a2a
hi PumSelected gui=bold guifg=#000000 guibg=#55ddff
hi PumScrollBar guibg=#dddddd
hi PumMatches guifg=#ffaa00
call pum#set_option(#{
  \   auto_select: v:true,
  \   max_height: 8,
  \   offset_row: 1,
  \   scrollbar_char: '',
  \   padding: v:false,
  \   use_complete: v:false,
  \   border: 'rounded',
  \   highlight_normal_menu: 'PumNormalMenu',
  \   highlight_matches: 'PumMatches',
  \   highlight_scrollbar: 'PumScrollBar',
  \   highlight_selected: 'PumSelected',
  \   highlight_columns: #{
  \     abbr: 'PumNormalMenu',
  \     kind: 'PumColumnKind',
  \     menu: 'PumColumnMenu',
  \   },
  \ })
" call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('autoCompleteEvents', [
  \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
  \ 'CmdlineEnter', 'CmdlineChanged',
  \ ])
call ddc#custom#patch_global('sources', [
  \ 'vim-lsp',
  \ 'around',
  \ 'file',
  \ 'skkeleton',
  \ ])
call ddc#custom#patch_global('sourceOptions', #{
  \ _: #{
  \   ignoreCase: v:true,
  \   minAutoCompleteLength: 1,
  \   isVolatile: v:true,
  \   matchers: ['matcher_head'],
  \   sorters: ['sorter_rank'],
  \   converters: ['converter_remove_overlap'],
  \ },
  \ vim-lsp: #{
  \   mark: '[LSP]', 
  \   matchers: ['matcher_head'],
  \   forceCompletionPattern: '\.|:|->|"\w+/*',
  \ },
  \ around: #{
  \   mark: '[AROUND]',
  \   maxSize: 200,
  \ },
  \ file: #{
  \   mark: '[FILE]',
  \   forceCompletionPattern: '\S/\S*',
  \ },
  \ skkeleton: #{
  \   mark: '[SKK]',
  \   matchers: ['skkeleton'],
  \   sorters: [],
  \ },
  \ })
"" ddc.vim cmdline completion setup
call ddc#custom#patch_global('cmdlineSources', {
  \ ':': [
  \   'cmdline',
  \   'necovim',
  \   'cmdline-history',
  \   'file',
  \   'skkeleton',
  \ ],
  \ '/': [
  \   'around',
  \   'file',
  \   'skkeleton',
  \ ],
  \ })
fun! DdcCommandlinePre() abort
  " Note: It disables default command line completion!
  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  call ddc#custom#patch_buffer('ui', 'pum')
  call ddc#custom#patch_buffer('sourceOptions', #{
    \ cmdline: #{
    \   mark: '[COMMAND]',
    \   forceCompletionPattern: '\ |:|->|"\w+/*',
    \ },
    \ cmdline-history: #{
    \   mark: '[HISTORY]',
    \ },
    \ necovim: #{
    \   mark: '[ARGS]',
    \   forceCompletionPattern: '\ |:|->|"\w+/*',
    \ },
    \ })
  au User DDCCmdlineLeave ++once call DdcCommandlinePost()
  au InsertEnter <buffer> ++once call DdcCommandlinePost()
  " Enable command line completion
  call ddc#enable_cmdline_completion()
endf
fun! DdcCommandlinePost() abort
  " Restore sources
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif
endf
if !exists('g:necovim#complete_functions')
  let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref = 'ref#complete'
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
      \ "z\<Space>": ["\u3000", ''],
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
    try
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
    catch
        return ''
    endtry
endf


"" neosnippet
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/neosnippet-snippets/neosnippets'
if finddir('dotfiles/nvim/snippets', $HOME) !=# ''
    let g:neosnippet#snippets_directory.=', ~/dotfiles/nvim/snippets'
endif


"" nvim-tree
"" disable netrw at the very start of your init.lua (strongly advised)
lua vim.g.loaded_netrw = 1
lua vim.g.loaded_netrwPlugin = 1
"" setup with some options
lua require("nvim-tree").setup({
  \   auto_reload_on_write = true,
  \   disable_netrw = true,
  \   hijack_cursor = true,
  \   hijack_netrw = true,
  \   sort_by = "case_sensitive",
  \   view = {
  \     adaptive_size = false,
  \     width = 25,
  \     hide_root_folder = false,
  \     signcolumn = "no",
  \     mappings = {
  \       custom_only = false,
  \       list = {
  \         { key = "?",     action = "toggle_help" },
  \         { key = "I",     action = "toggle_dotfiles" },
  \         { key = "<BS>",  action = "toggle_dotfiles" },
  \         { key = "<C-h>", action = "dir_up" },
  \         { key = "<C-l>", action = "cd" },
  \         { key = "<Tab>", action = "preview" },
  \         { key = "<C-p>", action = "preview" },
  \         { key = "<C-f>", action = "live_filter" },
  \         { key = "o",     action = "expand" },
  \         { key = "O",     action = "expand_all" },
  \         { key = "W",     action = "collapse_all" },
  \         { key = "<2-LeftMouse>", action = "edit" },
  \       },
  \     },
  \   },
  \   renderer = {
  \     group_empty = true,
  \     highlight_git = true,
  \     full_name = false,
  \     root_folder_label = ":t:gs?\\l?\\U\\0?",
  \     indent_width = 1,
  \     indent_markers = {
  \       enable = false,
  \       inline_arrows = true,
  \       icons = {
  \         corner = "└",
  \         edge = "│",
  \         item = "│",
  \         bottom = "─",
  \         none = " ",
  \       },
  \     },
  \     icons = {
  \       git_placement = "before",
  \       modified_placement = "after",
  \       padding = " ",
  \       symlink_arrow = " → ",
  \       glyphs = {
  \         default = "",
  \         symlink = "",
  \         bookmark = "",
  \         modified = "●",
  \         git = {
  \           unstaged = "M",
  \           staged = "✓",
  \           unmerged = "✗",
  \           renamed = "R",
  \           untracked = "U",
  \           deleted = "D",
  \           ignored = "◌",
  \         },
  \       },
  \     },
  \     special_files = { "Makefile", "README.md" },
  \   },
  \   update_focused_file = {
  \     enable = true,
  \   },
  \   diagnostics = {
  \     enable = true,
  \     show_on_dirs = true,
  \     show_on_open_dirs = false,
  \     debounce_delay = 50,
  \     severity = {
  \       min = vim.diagnostic.severity.WARNING,
  \       max = vim.diagnostic.severity.ERROR,
  \     },
  \     icons = {
  \       hint = "?",
  \       info = "i",
  \       warning = "",
  \       error = "✗",
  \     },
  \   },
  \   filters = {
  \     dotfiles = false,
  \   },
  \   git = {
  \     enable = true,
  \     ignore = false,
  \     show_on_dirs = true,
  \     show_on_open_dirs = false,
  \   },
  \   modified = {
  \     enable = true,
  \     show_on_dirs = true,
  \     show_on_open_dirs = false,
  \   },
  \   trash = {
  \     cmd = "rip",
  \     require_confirm = true,
  \   },
  \ })
hi NvimTreeRootFolder   gui=bold guifg=#999999
hi NvimTreeSpecialFile  gui=underline guifg=#cccccc
hi NvimTreeGitDirty     gui=bold guifg=#ffaa00
hi NvimTreeGitStaged    gui=bold guifg=#44cc44
hi NvimTreeModifiedFile gui=bold guifg=#ffaa00


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
let g:minimap_block_filetypes                   = ['terminal', 'fzf', 'vista_kind', 'NvimTree']
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


"" visual-multi
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'      " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'      " replace visual C-n
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>' " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'   " start selecting up


"" tcomment_vim
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif


"" indentline
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['│']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1
let g:indentLine_fileTypeExclude = ['terminal', 'help', 'fzf', 'vista_kind', 'NvimTree']


"" vim-hexokinase
let g:Hexokinase_highlighters = [ 'virtual' ]


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
let g:airline_exclude_filetypes = ['NvimTree', 'vista_kind', 'minimap']


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
