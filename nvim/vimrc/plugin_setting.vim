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


if get(g:, 'use_coc_nvim', 0) == 0
    "" vim-lsp
    let g:lsp_diagnostics_enabled                          = 1
    let g:lsp_diagnostics_signs_enabled                    = 1
    let g:lsp_diagnostics_signs_insert_mode_enabled        = 1
    let g:lsp_diagnostics_echo_cursor                      = 1
    let g:lsp_diagnostics_float_cursor                     = 1
    let g:lsp_diagnostics_highlights_enabled               = 1
    let g:lsp_diagnostics_virtual_text_enabled             = 1
    let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
    " let g:lsp_diagnostics_virtual_text_prefix              = "   ■ "
    let g:lsp_diagnostics_virtual_text_prefix              = "    "
    let g:lsp_document_code_action_signs_enabled           = 1
    let g:lsp_inlay_hints_delay                            = 0
    let g:lsp_diagnostics_echo_delay                       = 0
    let g:lsp_diagnostics_signs_delay                      = 0
    let g:lsp_diagnostics_float_delay                      = 0
    let g:lsp_document_highlight_delay                     = 0
    let g:lsp_diagnostics_virtual_text_delay               = 0
    let g:lsp_document_code_action_signs_delay             = 0
    let g:lsp_diagnostics_signs_priority                   = 20
    let g:lsp_diagnostics_signs_priority_map = {
        \ 'LspError': 20,
        \ 'LspWarning': 15,
        \ 'LspHint': 10,
        \ 'LspInformation': 5,
        \ }
    " let g:lsp_diagnostics_signs_error = {'text': '✗'}
    " let g:lsp_diagnostics_signs_error = {'text': '❌'}
    let g:lsp_diagnostics_signs_error = {'text': ''}
    let g:lsp_diagnostics_signs_warning = {'text': ''}
    let g:lsp_diagnostics_signs_hint = {'text': ''}
    let g:lsp_diagnostics_signs_information = {'text': ''}
    let g:lsp_document_code_action_signs_hint = {'text': '💡'}
    hi LspErrorText              gui=bold guifg=#ff0000 guibg=#202020
    hi LspWarningText            gui=bold guifg=#ffff00 guibg=#202020
    hi LspInformationText        gui=bold guifg=#ffffff guibg=#202020
    hi LspHintText               gui=bold guifg=#5599dd guibg=#202020
    hi LspErrorVirtualText       gui=bold guifg=#ff0000
    hi LspWarningVirtualText     gui=bold guifg=#ffff00
    hi LspInformationVirtualText gui=bold guifg=#ffffff
    hi LspHintVirtualText        gui=bold guifg=#5599dd
    hi link NormalFloat PumNormalMenu


    " "" lsp_signature (for vim-lsp)
    " lua require("lsp_signature").setup({
    "   \   bind = true,
    "   \   handler_opts = {
    "   \     border = "rounded"
    "   \   }
    "   \ })


    "" signature_help (for vim-lsp)
    call signature_help#enable()
    let g:lsp_signature_help_enabled = 0  " disable vim-lsp's signature help
    let g:signature_help_config = #{
      \ maxWidth: 80,
      \ maxHeight: 30,
      \ border: v:true,
      \ fallbackToBelow: v:true,
      \ winblend: 'pumblend',
      \ contentsStyle: 'labels',
      \ viewStyle: 'floating',
      \ }
      " \ contentsStyle: 'remainingLabels',
      " \ viewStyle: 'virtual',
    hi link SignatureHelpDocument PumNormalMenu
    hi link SignatureHelpBorder   FloatBorder
    hi SignatureHelpVirtual   gui=bold,underline,reverse guifg=#aaddff
    hi SignatureHelpGhostText guifg=#88bbff guibg=#303030


    "" denops-popup-preview (for vim-lsp, pum.vim)
    call popup_preview#enable()
    let g:popup_preview_config = #{
      \ maxWidth: 80,
      \ maxHeight: 30,
      \ border: v:true,
      \ winblend: 'pumblend',
      \ supportVsnip: v:false,
      \ supportUltisnips: v:false,
      \ }
    hi link PopupPreviewDocument PumNormalMenu
    hi link PopupPreviewBorder   FloatBorder


    "" pum.vim
    set shortmess+=c
    set wildoptions+=pum
    hi PumNormalMenu gui=none guifg=#dddddd guibg=#202020
    hi PumColumnKind gui=none guifg=#888888 guibg=#202020
    hi PumColumnMenu gui=none guifg=#888888 guibg=#202020
    hi PumSelected  gui=bold guibg=#3388bb
    hi PumMatches   guifg=#ff8800
    hi PmenuSBar    guifg=#666666 guibg=#cccccc
    hi FloatBorder  gui=bold guibg=#202020
    call pum#set_option(#{
      \   auto_select: v:true,
      \   max_height: 8,
      \   max_width: 0,
      \   offset_row: 1,
      \   scrollbar_char: ' ',
      \   padding: v:true,
      \   use_complete: v:true,
      \   border: 'rounded',
      \   highlight_normal_menu: 'PumNormalMenu',
      \   highlight_matches: '',
      \   highlight_scrollbar: 'PmenuSBar',
      \   highlight_selected: 'PumSelected',
      \   highlight_columns: #{
      \     abbr: 'PumNormalMenu',
      \     kind: 'PumColumnKind',
      \     menu: 'PumColumnMenu',
      \   },
      \ })


    "" ddc.vim
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
      \   matchers: ['matcher_fuzzy'],
      \   sorters: ['sorter_fuzzy'],
      \   converters: ['converter_fuzzy', 'converter_remove_overlap'],
      \   ignoreCase: v:true,
      \   minAutoCompleteLength: 1,
      \ },
      \ vim-lsp: #{
      \   mark: '[LSP]',
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
      \   isVolatile: v:true,
      \ },
      \ })
    call ddc#custom#patch_global('filterParams', #{
      \   matcher_fuzzy: #{
      \     splitMode: 'word'
      \   },
      \   converter_fuzzy: #{
      \     hlGroup: 'PumMatches'
      \   }
      \ })
    "" ddc.vim cmdline completion setup
    call ddc#custom#patch_global('cmdlineSources', {
      \ ':': [
      \   'cmdline',
      \   'cmdline-history',
      \   'necovim',
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
      if !exists('b:prev_buffer_config')
        let b:prev_buffer_config = ddc#custom#get_buffer()
      endif
      call ddc#custom#patch_buffer('ui', 'pum')
      call ddc#custom#patch_buffer('sourceOptions', #{
        \ _: #{
        \   matchers: ['matcher_head'],
        \ },
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
    " " vsnip for ddc.vim
    " au User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)


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
        call skkeleton#register_keymap('input', '<Up>', '')
        call skkeleton#register_keymap('input', '<Down>', '')
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
endif


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
  \     adaptive_size = true,
  \     width = 25,
  \     hide_root_folder = false,
  \     signcolumn = "no",
  \     preserve_window_proportions = true,
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
  \     highlight_modified = "name",
  \     full_name = false,
  \     root_folder_label = ":t:gs?\\l?\\U\\0?",
  \     indent_width = 1,
  \     indent_markers = {
  \       enable = true,
  \       inline_arrows = true,
  \       icons = {
  \         corner = "└",
  \         edge = "│",
  \         item = "├",
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
  \         git = {
  \           unstaged = "M",
  \           staged = "✓ ",
  \           unmerged = "✗ ",
  \           renamed = "R",
  \           untracked = "U",
  \           deleted = "D",
  \           ignored = "◌",
  \         },
  \       },
  \     },
  \     special_files = { "Makefile", "README.md", "package.json" },
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
  \       hint = "",
  \       info = "",
  \       warning = "",
  \       error = "",
  \     },
  \   },
  \   filters = {
  \     dotfiles = true,
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
" hi NvimTreeNormal             gui=none guibg=#202020
" hi NvimTreeEndOfBuffer        gui=none guifg=#202020 guibg=#202020
hi NvimTreeRootFolder         gui=bold guifg=#999999
hi NvimTreeFolderName         gui=bold guifg=#77aadd
hi NvimTreeOpenedFolderName   gui=bold guifg=#77aadd
hi NvimTreeSpecialFile        gui=bold,underline guifg=#aaaa00
hi NvimTreeGitDirty           gui=bold guifg=#ccaa55
hi NvimTreeGitStaged          gui=bold guifg=#44cc44
hi NvimTreeGitNew             gui=bold guifg=#44cc44
hi NvimTreeModifiedFile       gui=bold guifg=#ffaa00


""vista.vim
let g:vista_no_mappings = 0
let g:vista_echo_cursor = 1
let g:vista_echo_cursor_strategy = 'scroll'
let g:vista_blink = [3, 200]
let g:vista_top_level_blink = [3, 200]
let g:vista_highlight_whole_line = 1
let g:vista_update_on_text_changed = 1
let g:vista_sidebar_width = 25
let g:vista_icon_indent = ['└ ', '│ ']
let g:vista#renderer#enable_icon = 1
let g:vista_fzf_preview = ['right,50%,<70(down,60%)']
let g:vista_fzf_opt = ['--bind=ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up']
"" TODO: vim-lspを使った時にもvistaウィンドウでハイライトさせる
" let g:vista_default_executive = 'vim_lsp'
" let g:vista_executive_for = {
"     \ 'c': 'vim_lsp',
"     \ 'go': 'vim_lsp',
"     \ 'python': 'vim_lsp',
"     \ 'javascript': 'vim_lsp',
"     \ 'typescript': 'vim_lsp',
"     \ }
fun! AirlineVistaNearestMethodOrFunction() abort
  try
    let l:funcname_text = get(b:, 'vista_nearest_method_or_function', '')
    if l:funcname_text == ''
      return ''
    endif
    return ' '.l:funcname_text
  endtry
endf
fun! VistaInit() abort
  try
    if &filetype != ''
      call vista#RunForNearestMethodOrFunction()
    endif
  endtry
endf
au VimEnter * call VistaInit()
hi link VistaFloat Pmenu
" hi VistaKind   guifg=
" hi VistaTag    guifg=
" hi VistaPublic guifg=
hi VistaLineNr guifg=#777777


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
hi MyMinimapSearch      guifg=#ffffff guibg=#bbbb00
hi MyMinimapDiffLine    guifg=#bbbb00
hi MyMinimapDiffAdded   guifg=#00aa77
hi MyMinimapDiffRemoved guifg=#bb0000


" "" visual-multi
" let g:VM_default_mappings = 0
" let g:VM_maps = {}
" let g:VM_maps['Find Under']         = '<C-d>'      " replace C-n
" let g:VM_maps['Find Subword Under'] = '<C-d>'      " replace visual C-n
" let g:VM_maps["Select Cursor Down"] = '<M-C-Down>' " start selecting down
" let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'   " start selecting up


"" tcomment_vim
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif


"" nvim-treesitter
lua require('nvim-treesitter.configs').setup {
    \   ensure_installed = {
    \     "vim",
    \     "help",
    \     "json",
    \     "markdown",
    \     "c",
    \     "cpp",
    \     "python",
    \     "go",
    \     "javascript",
    \     "typescript",
    \     "vue",
    \   },
    \   sync_install = false,
    \   auto_install = true,
    \   ignore_install = { "haskell" },
    \   highlight = {
    \     enable = true,
    \     disable = {
    \       "haskell",
    \       "markdown",
    \       "vim",
    \       "terraform",
    \       "terraform-vars",
    \   },
    \     additional_vim_regex_highlighting = false,
    \   },
    \   indent = {
    \     enable = true
    \   },
    \ }
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set nofoldenable  " Disable folding at startup.


if has('wsl')
    "" indent-blankline.nvim
    let g:indent_blankline_char                       = '│'
    let g:indent_blankline_context_char               = '┃'
    let g:indent_blankline_space_char_blankline       = ' '
    let g:indent_blankline_use_treesitter             = v:true
    let g:indent_blankline_indent_level               = 10
    let g:indent_blankline_max_indent_increase        = g:indent_blankline_indent_level
    let g:indent_blankline_show_first_indent_level    = v:true
    let g:indent_blankline_show_current_context_start = v:true
    let g:indent_blankline_filetype_exclude           = ['terminal', 'help', 'fzf', 'vista_kind', 'NvimTree']
    let g:indent_blankline_bufname_exclude            = ['README.md']
    let g:indent_blankline_disable_with_nolist        = v:true
    lua require("indent_blankline").setup {
        \   show_current_context = true,
        \   show_current_context_start = true,
        \ }
    hi IndentBlanklineChar               gui=nocombine guifg=#3a3a3a
    hi IndentBlanklineContextChar        gui=bold      guifg=#606060
    " hi IndentBlanklineContextStart       gui=bold
    hi IndentBlanklineSpaceChar          gui=nocombine guifg=#3a3a3a
    hi IndentBlanklineSpaceCharBlankline gui=nocombine guifg=#3a3a3a
else
    "" indentline
    let g:indentLine_enabled         = 1
    let g:indentLine_char            = '│'
    let g:indentLine_concealcursor   = 'inc'
    let g:indentLine_conceallevel    = 2
    let g:indentLine_fileTypeExclude = ['json', 'terminal', 'help', 'fzf', 'vista_kind', 'NvimTree']
endif


"" vim-hexokinase
let g:Hexokinase_highlighters = [ 'backgroundfull' ]


"" vim-airline
if g:colors_name == 'codedark'
    let g:airline_theme = 'codedark'
elseif g:colors_name == 'tender'
    let g:airline_theme = 'tender'
else
    let g:airline_theme = 'kalisi'
endif
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
let g:airline#extensions#branch#enabled          = 1
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_splits     = 1
let g:airline#extensions#tabline#show_buffers    = 1
let g:airline#extensions#wordcount#enabled       = 0
let g:airline#extensions#vista#enabled           = 0
fun! ALtextapprove()
  let l:min_width = 100
  if winwidth(0) >= l:min_width
    return v:true
  endif
  return v:false
endf
if g:use_coc_nvim == 0
    let g:airline#extensions#default#layout = [
        \ ['a', 'b', 'c', 'vista_info'],
        \ ['lsp_err', 'lsp_warn', 'lsp_hint', 'x', 'y', 'z']]
    let g:airline_section_a = airline#section#create(['mode', '%{Airline_skkeleton_mode()}'])
    let g:airline_section_c = '%t'
    let g:airline_section_vista_info = '%{ALtextapprove() ? AirlineVistaNearestMethodOrFunction():""}'
    let g:airline_section_lsp_err  = '%{lsp#get_buffer_diagnostics_counts().error>0 ?'
                \ .'g:lsp_diagnostics_signs_error.text." ".lsp#get_buffer_diagnostics_counts().error : ""}'
    let g:airline_section_lsp_warn = '%{lsp#get_buffer_diagnostics_counts().warning>0 ?'
                \ .'g:lsp_diagnostics_signs_warning.text." ".lsp#get_buffer_diagnostics_counts().warning : ""}'
    let g:airline_section_lsp_hint = '%{lsp#get_buffer_diagnostics_counts().hint>0 ?'
                \ .'g:lsp_diagnostics_signs_hint.text." ".lsp#get_buffer_diagnostics_counts().hint : ""}'
    let g:airline_section_x = ''
    let g:airline_section_y = '%{&filetype} %{&fileencodings}'
    let g:airline_section_z = '%3l/%L,%2c'
else
    let g:airline#extensions#default#layout = [
        \ ['a', 'b', 'c', 'vista_info'],
        \ ['x', 'y', 'z']]
    let g:airline_section_c = '%t'
    let g:airline_section_vista_info = '%{ALtextapprove() ? AirlineVistaNearestMethodOrFunction():""}'
    let g:airline_section_x = ''
    let g:airline_section_y = '%{&filetype} %{&fileencodings}'
    let g:airline_section_z = '%3l/%L,%2c'
endif
let g:airline#extensions#default#section_truncate_width = {}
"" vim-airline separator
let g:airline#extensions#tabline#right_sep = '  '
let g:airline#extensions#tabline#left_sep  = '  '
let g:airline#extensions#tabline#right_alt_sep = '│'
let g:airline#extensions#tabline#left_alt_sep  = '│'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_exclude_filetypes = ['NvimTree', 'vista_kind', 'minimap']
hi airline_vista_info guifg=#55cc55
hi airline_lsp_err    guifg=#ff0000
hi airline_lsp_warn   guifg=#ffff00
hi airline_lsp_hint   guifg=#5599dd


"" delimitmate
let g:delimitMate_autoclose            = 1
let g:delimitMate_matchpairs           = "(:),[:],{:}"
let g:delimitMate_jump_expansion       = 1
let g:delimitMate_expand_space         = 1
let g:delimitMate_expand_cr            = 2
let g:delimitMate_expand_inside_quotes = 1
let g:delimitMate_balance_matchpairs   = 1
ino {<CR> {<CR>} <C-o>O


"" fugitive
if exists('*fugitive#statusline')
    set statusline+=%{fugitive#statusline()}
endif
fun! s:fugitive_init() abort
    setlocal nonumber
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal nolist
    setlocal nospell
    setlocal noequalalways
    resize 10
endf
au User Fugitive GitGutterAll
au FileType fugitive call s:fugitive_init()


"" vim-gitgutter
let g:gitgutter_enabled                      = 1
let g:gitgutter_async                        = 1
let g:gitgutter_sign_priority                = 5
let g:gitgutter_map_keys                     = 0
let g:gitgutter_sign_added                   = '│'
let g:gitgutter_sign_modified                = '│'
let g:gitgutter_sign_removed                 = '_'
let g:gitgutter_sign_removed_first_line      = '‾'
let g:gitgutter_sign_removed_above_and_below = '_¯'
let g:gitgutter_sign_modified_removed        = '│'
hi GitGutterAdd    gui=bold guifg=#00bb00
hi GitGutterChange gui=bold guifg=#cccc00
hi GitGutterDelete gui=bold guifg=#ff2222


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
