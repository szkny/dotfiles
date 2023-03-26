scriptencoding utf-8
"*****************************************************************************
"" Plugin Configuration
"*****************************************************************************

"" nvim-notify
  " \   stages = "fade_in_slide_out",
  " \   render = "compact",
lua require("notify").setup({
  \   stages = "fade",
  \   on_open = nil,
  \   on_close = nil,
  \   render = "compact",
  \   background_colour = "#333333",
  \   timeout = 3000,
  \   minimum_width = 50,
  \   fps = 30,
  \   icons = {
  \     ERROR = " ",
  \     WARN = " ",
  \     INFO = " ",
  \     DEBUG = " ",
  \     TRACE = "✎ ",
  \   },
  \ })
hi NotifyERRORBorder guifg=#8A1F1F guibg=none
hi NotifyWARNBorder  guifg=#79491D guibg=none
hi NotifyINFOBorder  guifg=#4F6752 guibg=none
hi NotifyDEBUGBorder guifg=#8B8B8B guibg=none
hi NotifyTRACEBorder guifg=#4F3552 guibg=none
hi NotifyERRORIcon   guifg=#F70067 guibg=none
hi NotifyWARNIcon    guifg=#F79000 guibg=none
hi NotifyINFOIcon    guifg=#A9FF68 guibg=none
hi NotifyDEBUGIcon   guifg=#8B8B8B guibg=none
hi NotifyTRACEIcon   guifg=#D484FF guibg=none
hi NotifyERRORTitle  guifg=#F70067 guibg=none
hi NotifyWARNTitle   guifg=#F79000 guibg=none
hi NotifyINFOTitle   guifg=#A9FF68 guibg=none
hi NotifyDEBUGTitle  guifg=#8B8B8B guibg=none
hi NotifyTRACETitle  guifg=#D484FF guibg=none
hi NotifyERRORBody   guibg=none
hi NotifyWARNBody    guibg=none
hi NotifyINFOBody    guibg=none
hi NotifyDEBUGBody   guibg=none
hi NotifyTRACEBody   guibg=none


"" noice.nvim
lua  require("noice").setup({
  \   messages = {
  \     enabled = true,
  \     view = "notify",
  \     view_error = "notify",
  \     view_warn = "notify",
  \     view_history = "messages",
  \     view_search = "mini",
  \   },
  \   cmdline = {
  \     enabled = true,
  \     view = "cmdline_popup",
  \     format = {
  \       cmdline = { pattern = "^:", icon = "", lang = "vim" },
  \       search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
  \       search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
  \       filter = { pattern = "^:%s*!", icon = "$", lang = "zsh" },
  \       lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
  \       help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
  \     },
  \   },
  \   presets = {
  \     bottom_search = false,
  \     command_palette = true,
  \     long_message_to_split = true,
  \   },
  \ })
hi NoiceMini guifg=#ffbb00 guibg=#000000
hi NoiceCmdlinePopup guibg=#333333


"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  'find * -path "*/\.*" -prune -o -path "node_modules/**" -prune -o -path "target/**" -prune -o -path "dist/**" -prune -o  -type f -print -o -type l -print 2> /dev/null'
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up"
" let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_preview_window = ['right,50%,<70(down,60%)', 'ctrl-/']
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
let g:fzf_colors =
\ { 'fg':      ['fg', 'FzfNormal'],
\   'bg':      ['bg', 'FzfNormal']}
hi link FzfNormal Normal
hi FzfNormal guibg=#333333 


"" mason.nvim
if get(g:, 'use_mason_nvim', 0) == 1
    " lua require("mason").setup()
    " lua require("mason-lspconfig").setup()
    lua local on_attach = function(client, bufnr)
      \  client.server_capabilities.documentFormattingProvider = false
      \  local set = vim.keymap.set
      \   set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      \   set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      \   set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      \   set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
      \   set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
      \   set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      \   set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      \   set('n', 'gx', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
      \   set('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
      \   set('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
      \   set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
      \   end
      \ vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      \   vim.lsp.diagnostic.on_publish_diagnostics,
      \   { virtual_text = false }
      \ )
      \ require("mason").setup()
      \ require("mason-lspconfig").setup()
      \ require("mason-lspconfig").setup_handlers {
      \   function(server_name)
      \     require("lspconfig")[server_name].setup {
      \       on_attach = on_attach,
      \     }
      \   end
      \ }
endif


if get(g:, 'use_coc_nvim', 0) == 0 && get(g:, 'use_mason_nvim', 0) == 0
    "" vim-lsp
    let g:lsp_diagnostics_enabled                          = 1
    let g:lsp_diagnostics_signs_enabled                    = 1
    let g:lsp_diagnostics_signs_insert_mode_enabled        = 1
    let g:lsp_diagnostics_echo_cursor                      = 1
    let g:lsp_diagnostics_float_cursor                     = 1
    let g:lsp_diagnostics_highlights_enabled               = 1
    let g:lsp_diagnostics_virtual_text_enabled             = 1
    let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
    let g:lsp_diagnostics_virtual_text_prefix              = "    "
    let g:lsp_document_code_action_signs_enabled           = 1
    let g:lsp_inlay_hints_delay                            = 0
    let g:lsp_diagnostics_echo_delay                       = 0
    let g:lsp_diagnostics_signs_delay                      = 0
    let g:lsp_diagnostics_float_delay                      = 400
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
    let g:lsp_diagnostics_signs_error = {'text': ''}
    let g:lsp_diagnostics_signs_warning = {'text': ''}
    let g:lsp_diagnostics_signs_hint = {'text': ''}
    let g:lsp_diagnostics_signs_information = {'text': ''}
    let g:lsp_document_code_action_signs_hint = {'text': '💡'}
    hi link LspErrorText       SignColumn
    hi link LspWarningText     SignColumn
    hi link LspInformationText SignColumn
    hi link LspHintText        SignColumn
    hi LspErrorText              gui=bold guifg=#ff0000
    hi LspWarningText            gui=bold guifg=#ffff00
    hi LspInformationText        gui=bold guifg=#ffffff
    hi LspHintText               gui=bold guifg=#5599dd
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
endif

"" pum.vim
set pumblend=20
set shortmess+=c
set wildoptions+=pum
hi PumNormalMenu gui=none guifg=#dddddd guibg=#333333
hi PumColumnKind gui=none guifg=#888888 guibg=#333333
hi PumColumnMenu gui=none guifg=#888888 guibg=#333333
hi PumSelected  gui=bold guibg=#226688
hi PumMatches   guifg=#44aabb
hi PmenuSBar    guifg=#666666 guibg=#cccccc
hi FloatBorder  gui=bold guibg=#282828
call pum#set_option(#{
  \   auto_select: v:false,
  \   max_height: 15,
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
call ddc#custom#patch_global(#{
   \   ui: 'pum',
   \   autoCompleteEvents: [
   \     'CmdlineEnter', 'CmdlineChanged',
   \   ],
   \   backspaceCompletion: v:true,
   \   sources: [],
   \   sourceOptions: #{
   \     _: #{
   \       matchers: ['matcher_fuzzy'],
   \       sorters: ['sorter_fuzzy'],
   \       converters: ['converter_fuzzy', 'converter_remove_overlap'],
   \       ignoreCase: v:true,
   \       minAutoCompleteLength: 1,
   \     },
   \   },
   \   filterParams: #{
   \     matcher_fuzzy: #{
   \       splitMode: 'word'
   \     },
   \     converter_fuzzy: #{
   \       hlGroup: 'PumMatches'
   \     }
   \   },
   \ })
if get(g:, 'use_coc_nvim', 0) == 0 && get(g:, 'use_mason_nvim', 0) == 0
    call ddc#custom#patch_global(#{
       \   sources: [
       \     'vim-lsp',
       \     'around',
       \     'file',
       \     'mocword',
       \     'skkeleton',
       \   ],
       \   sourceOptions: #{
       \     _: #{
       \       matchers: ['matcher_fuzzy'],
       \       sorters: ['sorter_fuzzy'],
       \       converters: ['converter_fuzzy', 'converter_remove_overlap'],
       \       ignoreCase: v:true,
       \       minAutoCompleteLength: 1,
       \     },
       \     vim-lsp: #{
       \       mark: '[LSP]',
       \       forceCompletionPattern: '\.|:|->|"\w+/*',
       \     },
       \     around: #{
       \       mark: '[AROUND]',
       \     },
       \     file: #{
       \       mark: '[FILE]',
       \       forceCompletionPattern: '\S/\S*',
       \     },
       \     mocword: #{
       \       mark: '[MOCWORD]',
       \       forceCompletionPattern: '\ ',
       \       minAutoCompleteLength: 2,
       \       isVolatile: v:true,
       \     },
       \     skkeleton: #{
       \       mark: '[SKK]',
       \       matchers: ['skkeleton'],
       \       sorters: [],
       \       isVolatile: v:true,
       \     },
       \   },
       \ })
endif

"" ddc.vim cmdline completion setup
call ddc#custom#patch_global('cmdlineSources', {
  \ ':': [
  \   'cmdline',
  \   'cmdline-history',
  \   'necovim',
  \   'file',
  \   'mocword',
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
    \ cmdline: #{
    \   mark: '[COMMAND]',
    \   forceCompletionPattern: '\ |:|-|"\w+/*',
    \ },
    \ cmdline-history: #{
    \   mark: '[HISTORY]',
    \ },
    \ necovim: #{
    \   mark: '[ARGS]',
    \   forceCompletionPattern: '\ |:|-|"\w+/*',
    \ },
    \ file: #{
    \   mark: '[FILE]',
    \   forceCompletionPattern: '\S/\S*',
    \ },
    \ mocword: #{
    \   mark: '[MOCWORD]',
    \   forceCompletionPattern: '\ ',
    \   minAutoCompleteLength: 2,
    \   isVolatile: v:true,
    \ },
    \ skkeleton: #{
    \   mark: '[SKK]',
    \   matchers: ['skkeleton'],
    \   sorters: [],
    \   isVolatile: v:true,
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

"" skkeleton
fun! s:skkeleton_init() abort
    call skkeleton#config(#{
      \ globalJisyo: '~/.skk/SKK-JISYO.L',
      \ kanaTable: 'rom',
      \ eggLikeNewline: v:true,
      \ showCandidatesCount: 10,
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
  \     hide_root_folder = true,
  \     signcolumn = "yes",
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
  \     indent_width = 2,
  \     indent_markers = {
  \       enable = true,
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
  \       min = vim.diagnostic.severity.HINT,
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
" hi NvimTreeNormal                    gui=none guibg=#202020
" hi NvimTreeEndOfBuffer               gui=none guifg=#202020 guibg=#202020
hi NvimTreeRootFolder                gui=bold guifg=#bbbbbb guibg=#2e2e35
hi NvimTreeFolderName                gui=bold guifg=#77aadd
hi NvimTreeOpenedFolderName          gui=bold guifg=#77aadd
hi NvimTreeSpecialFile               gui=bold,underline guifg=#aaaa00
hi NvimTreeGitDirty                  gui=bold guifg=#ccaa55
hi NvimTreeGitStaged                 gui=bold guifg=#44cc44
hi NvimTreeGitNew                    gui=bold guifg=#44cc44
hi NvimTreeModifiedFile              gui=bold guifg=#ffaa00
hi NvimTreeLspDiagnosticsError       gui=bold guifg=#ff0000
hi NvimTreeLspDiagnosticsWarning     gui=bold guifg=#ffff00
hi NvimTreeLspDiagnosticsInformation gui=bold guifg=#ffffff
hi NvimTreeLspDiagnosticsHint        gui=bold guifg=#5588dd


""vista.vim
let g:vista_no_mappings = 0
let g:vista_echo_cursor = 1
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_blink = [3, 200]
let g:vista_top_level_blink = [3, 200]
let g:vista_highlight_whole_line = 1
let g:vista_update_on_text_changed = 1
let g:vista_sidebar_width = 25
let g:vista_icon_indent = ['└ ', '│ ']
let g:vista#renderer#enable_icon = 1
let g:vista_fzf_preview = ['right,50%,<70(down,60%)']
let g:vista_fzf_opt = ['--bind=ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up']
if get(g:, 'use_coc_nvim', 0) == 1
    let g:vista_default_executive = 'coc'
endif
"" TODO: vim-lspを使った時にもvistaウィンドウでハイライトさせる
" let g:vista_default_executive = 'vim_lsp'
" let g:vista_executive_for = {
"     \ 'c': 'vim_lsp',
"     \ 'go': 'vim_lsp',
"     \ 'python': 'vim_lsp',
"     \ 'javascript': 'vim_lsp',
"     \ 'typescript': 'vim_lsp',
"     \ }
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
let g:minimap_width                             = 4
let g:minimap_window_width_override_for_scaling = 2147483647
let g:minimap_block_filetypes                   = ['terminal', 'fzf', 'vista_kind', 'NvimTree', 'rnvimr']
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


"" nvim-treesitter
lua require('nvim-treesitter.configs').setup {
    \   ensure_installed = {
    \     "vim",
    \     "regex",
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
    \     "css",
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
    \       "vue",
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
    let g:indent_blankline_indent_level               = 30
    let g:indent_blankline_max_indent_increase        = g:indent_blankline_indent_level
    let g:indent_blankline_show_first_indent_level    = v:true
    let g:indent_blankline_show_current_context_start = v:true
    let g:indent_blankline_filetype_exclude           = ['terminal', 'help', 'fzf', 'vista_kind', 'NvimTree', 'mason', 'rnvimr']
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
    let g:indentLine_fileTypeExclude = ['json', 'terminal', 'help', 'fzf', 'vista_kind', 'NvimTree', 'mason', 'rnvimr']
endif


"" lualine.nvim
fun! LualineSkkeletonMode() abort
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
            return 'IME:'.l:mode
        else
            return ''
        endif
    catch
        return ''
    endtry
endf
fun! LualineVistaNearestMethodOrFunction() abort
  try
    let l:min_width = 50
    if winwidth(0) >= l:min_width
        let l:funcname_text = get(b:, 'vista_nearest_method_or_function', '')
        if l:funcname_text == ''
          return ''
        endif
        return ' '.l:funcname_text
    endif
    return ''
  endtry
endf
if get(g:, 'use_coc_nvim', 0) == 0 && get(g:, 'use_mason_nvim', 0) == 0
    let g:lualine_diagnostics_source = 'vim_lsp'
else
    let g:lualine_diagnostics_source = 'coc'
endif
lua local my_custom_theme = {
  \   normal = {
  \     a = { fg = '#ddddee', bg = '#5588dd' , gui = 'bold' },
  \     b = { fg = '#5588dd', bg = '#394260' },
  \     c = { fg = '#5588dd', bg = '#212736' },
  \   },
  \   insert  = { a = { fg = '#394260', bg = '#a3aed2', gui = 'bold' } },
  \   visual  = { a = { fg = '#394260', bg = '#77bbbb', gui = 'bold' } },
  \   replace = { a = { fg = '#394260', bg = '#bb77cc', gui = 'bold' } },
  \   inactive = {
  \     a = { fg = '#ddddee', bg = '#212736' },
  \     b = { fg = '#ddddee', bg = '#212736' },
  \     c = { fg = '#ddddee', bg = '#212736' },
  \   },
  \ }
  \ local diagnostics = {
  \   'diagnostics',
  \   sources = { vim.g.lualine_diagnostics_source },
  \   sections = { 'error', 'warn', 'info', 'hint' },
  \   diagnostics_color = {
  \     error = 'lualine_lsp_err',
  \     warn  = 'lualine_lsp_warn',
  \     info  = 'lualine_lsp_info',
  \     hint  = 'lualine_lsp_hint',
  \   },
  \   symbols = {
  \     error = ' ',
  \     warn  = ' ',
  \     info  = ' ',
  \     hint  = ' '
  \   },
  \   colored = true,
  \   update_in_insert = true,
  \   always_visible = false,
  \ }
  \ require('lualine').setup {
  \   options = {
  \     icons_enabled = true,
  \     theme = my_custom_theme,
  \     component_separators = { left = ' ', right = ' ' },
  \     section_separators = { left = '', right = ''},
  \     disabled_filetypes = {
  \       statusline = {'NvimTree', 'vista', 'minimap'},
  \       winbar = {},
  \     },
  \     ignore_focus = {'NvimTree', 'vista', 'minimap'},
  \     always_divide_middle = true,
  \     globalstatus = true,
  \     refresh = {
  \       statusline = 1000,
  \       tabline = 1000,
  \       winbar = 1000,
  \     }
  \   },
  \   sections = {
  \     lualine_a = {
  \       { 'mode', separator = { left = '', right = '' } },
  \       { 'LualineSkkeletonMode' }
  \     },
  \     lualine_b = { 'diff', 'branch' },
  \     lualine_c = {
  \       'filename',
  \       { 'LualineVistaNearestMethodOrFunction' },
  \     },
  \     lualine_x = {
  \       diagnostics, 'filetype', 'encoding', 'fileformat' },
  \     lualine_y = { 'progress' },
  \     lualine_z = { {'location', separator = { left = '', right = '' } } },
  \   },
  \   inactive_sections = {
  \     lualine_a = {},
  \     lualine_b = {},
  \     lualine_c = { 'filename' },
  \     lualine_x = { 'location' },
  \     lualine_y = {},
  \     lualine_z = {}
  \   },
  \   tabline = {},
  \   winbar = {},
  \   inactive_winbar = {},
  \   extensions = {}
  \ }
hi lualine_lsp_err  guibg=#212736 guifg=#ff0000
hi lualine_lsp_warn guibg=#212736 guifg=#ffff00
hi lualine_lsp_hint guibg=#212736 guifg=#5599dd
hi lualine_lsp_info guibg=#212736 guifg=#5599dd


"" bufferline.nvim
  " \     separator_style = 'slant',
lua require('bufferline').setup {
  \   options = {
  \     mode = "buffers",
  \     numbers = "none",
  \     close_command = "bdelete! %d",
  \     right_mouse_command = "bdelete! %d",
  \     left_mouse_command = "buffer %d",
  \     middle_mouse_command = nil,
  \     indicator = {
  \       icon = '▎',
  \       style = 'icon'
  \     },
  \     max_name_length = 36,
  \     max_prefix_length = 6,
  \     truncate_names = true,
  \     tab_size = 18,
  \     diagnostics = "coc",
  \     diagnostics_update_in_insert = true,
  \     diagnostics_indicator = function(count, level, diagnostics_dict, context)
  \         local icon = level:match("error") and ""
  \                    or level:match("warning") and ""
  \                    or level:match("hint") and "" or ""
  \         return "" .. icon .. " " .. count
  \     end,
  \     custom_filter = function(buf_number, buf_numbers)
  \         if vim.bo[buf_number].filetype ~= "qf" then
  \             return true
  \         end
  \     end,
  \     offsets = {
  \       {
  \         filetype = "NvimTree",
  \         text = function()
  \           return vim.fn.fnamemodify(vim.fn.getcwd(), ':t:gs?\\l?\\U\\0?')
  \         end,
  \         text_align = "center",
  \         separator = true,
  \         highlight = "NvimTreeRootFolder",
  \       }
  \     },
  \     color_icons = true,
  \     show_buffer_icons = true,
  \     show_buffer_close_icons = true,
  \     show_buffer_default_icon = true,
  \     show_close_icon = true,
  \     show_tab_indicators = true,
  \     show_duplicate_prefix = true,
  \     persist_buffer_sort = true,
  \     separator_style = {"│", "│"},
  \     enforce_regular_tabs = false,
  \     always_show_bufferline = true,
  \     hover = {
  \       enabled = true,
  \       delay = 200,
  \       reveal = {'close'}
  \     },
  \   },
  \   highlights = {
  \     fill = {
  \       fg = '#555555',
  \       bg = '#2e2e35',
  \     },
  \     buffer_selected = {
  \       fg = '#ffffff',
  \       bg = 'none',
  \       italic = false,
  \       bold = true,
  \     },
  \     buffer_visible = {
  \       fg = '#ffffff',
  \       bg = 'none',
  \       italic = false,
  \       bold = true,
  \     },
  \     duplicate_selected = {
  \       fg = '#ffffff',
  \       bg = 'none',
  \       italic = false,
  \       bold = true,
  \     },
  \     duplicate_visible = {
  \       fg = '#ffffff',
  \       bg = 'none',
  \       italic = false,
  \     },
  \     diagnostic_selected = {
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     diagnostic_visible = {
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     error_selected = {
  \         fg = '#cc0000',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     error_visible = {
  \         fg = '#cc0000',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     error_diagnostic_selected = {
  \         fg = '#cc0000',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     error_diagnostic_visible = {
  \         fg = '#cc0000',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     warning_selected = {
  \         fg = '#cccc00',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     warning_visible = {
  \         fg = '#cccc00',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     warning_diagnostic_selected = {
  \         fg = '#cccc00',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     warning_diagnostic_visible = {
  \         fg = '#cccc00',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     info_selected = {
  \         fg = '#ffffff',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     info_visible = {
  \         fg = '#ffffff',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     info_diagnostic_selected = {
  \         fg = '#ffffff',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     info_diagnostic_visible = {
  \         fg = '#ffffff',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     hint_selected = {
  \         fg = '#5588dd',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     hint_visible = {
  \         fg = '#5588dd',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     hint_diagnostic_selected = {
  \         fg = '#5588dd',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     hint_diagnostic_visible = {
  \         fg = '#5588dd',
  \         bg = 'none',
  \         bold = true,
  \         italic = false,
  \     },
  \     indicator_selected = {
  \       fg = '#88ccff',
  \       bg = 'none',
  \     },
  \     close_button = {
  \       fg = '#888888',
  \       bg = 'none',
  \     },
  \     close_button_visible = {
  \       fg = '#888888',
  \       bg = 'none',
  \     },
  \     close_button_selected = {
  \       fg = '#aaaaaa',
  \       bg = 'none',
  \       bold = true,
  \     },
  \     numbers_selected = {
  \       fg = '#ffffff',
  \       bg = 'none',
  \       italic = false,
  \     },
  \     modified_selected = {
  \       fg = '#ffaa00',
  \       bg = 'none',
  \       bold = true,
  \     },
  \     background = {
  \       fg = '#888888',
  \       bg = '#2e2e35',
  \     },
  \     duplicate = {
  \       fg = "#888888",
  \       bg = '#2e2e35',
  \       italic = false,
  \     },
  \     diagnostic = {
  \         fg = '#888888',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     error = {
  \         fg = '#aa0000',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     error_diagnostic = {
  \         fg = '#aa0000',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     warning = {
  \         fg = '#aaaa00',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     warning_diagnostic = {
  \         fg = '#aaaa00',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     info = {
  \         fg = '#888888',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     info_diagnostic = {
  \         fg = '#888888',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     hint = {
  \         fg = '#4466aa',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     hint_diagnostic = {
  \         fg = '#4466aa',
  \         bg = '#2e2e35',
  \         bold = true,
  \         italic = false,
  \     },
  \     numbers = {
  \       fg = '#888888',
  \       bg = '#2e2e35',
  \       italic = false,
  \     },
  \     numbers_visible = {
  \       fg = '#888888',
  \       bg = '#2e2e35',
  \       italic = false,
  \     },
  \     modified = {
  \       fg = '#bb7700',
  \       bg = "#2e2e35",
  \       bold = true,
  \     },
  \     separator_selected = {
  \       fg = "#303030",
  \       bg = "#2e2e35",
  \     },
  \     separator_visible = {
  \       fg = "#303030",
  \       bg = "#2e2e35",
  \     },
  \     separator = {
  \       fg = "#444450",
  \       bg = "#2e2e35",
  \     },
  \     offset_separator = {
  \       fg = win_separator_fg,
  \       bg = '#2e2e35',
  \     },
  \   }
  \ }


"" nvim-scrollbar  " TODO
lua require("scrollbar").setup({
  \   show = true,
  \   show_in_active_only = true,
  \   set_highlights = true,
  \   max_lines = false,
  \   hide_if_all_visible = false,
  \   handle = {
  \     text = " ",
  \     highlight = "CursorColumn",
  \     hide_if_all_visible = true,
  \   },
  \   marks = {
  \     Cursor = {
  \       text = "•",
  \       priority = 0,
  \       highlight = "Normal",
  \     },
  \     Search = {
  \       text = { "-", "=" },
  \       priority = 1,
  \       highlight = "Search",
  \     },
  \   },
  \   excluded_buftypes = {
  \     "terminal",
  \     "nofile",
  \   },
  \   excluded_filetypes = {
  \     "prompt",
  \     "minimap",
  \     "NvimTree",
  \     "noice",
  \   },
  \   autocmd = {
  \     render = {
  \       "BufWinEnter",
  \       "TabEnter",
  \       "TermEnter",
  \       "WinEnter",
  \       "CmdwinLeave",
  \       "TextChanged",
  \       "VimResized",
  \       "WinScrolled",
  \     },
  \     clear = {
  \       "BufWinLeave",
  \       "TabLeave",
  \       "TermLeave",
  \       "WinLeave",
  \     },
  \   },
  \   handlers = {
  \       cursor = false,
  \       handle = true,
  \       diagnostic = true,
  \       gitsigns = false,
  \       search = false,
  \   },
  \ })
hi ScrollbarHandle       gui=none guifg=#333333 guibg=#555555
hi ScrollbarCursor       gui=none guifg=#333333 guibg=#555555
hi ScrollbarCursorHandle gui=none guifg=#ffffff guibg=#555555
hi ScrollbarSearch       gui=bold guifg=#ffaa77
hi ScrollbarSearchHandle gui=bold guifg=#ffaa77 guibg=#555555
hi ScrollbarError        gui=bold guifg=#ff0000
hi ScrollbarErrorHandle  gui=bold guifg=#ff0000 guibg=#555555
hi ScrollbarWarn         gui=bold guifg=#ffff00
hi ScrollbarWarnHandle   gui=bold guifg=#ffff00 guibg=#555555
hi ScrollbarHint         gui=bold guifg=#5599dd
hi ScrollbarHintHandle   gui=bold guifg=#5599dd guibg=#555555


" "" visual-multi  " TODO
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


" "" nvim-colorizer.lua  " TODO
" lua require('colorizer').setup(
"   \   {
"   \     '*';
"   \   },
"   \   {
"   \     RGB      = true;
"   \     RRGGBB   = true;
"   \     names    = false;
"   \     RRGGBBAA = true;
"   \     rgb_fn   = true;
"   \     hsl_fn   = true;
"   \     css      = true;
"   \     css_fn   = true;
"   \     mode     = 'background';
"   \   }
"   \ )

"" vim-hexokinase
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:Hexokinase_optInPatterns = [
\   'full_hex',
\   'triple_hex',
\   'rgb',
\   'rgba',
\   'hsl',
\   'hsla',
\ ]


" "" vscode.nvim  " TODO
" lua local c = require('vscode.colors').get_colors()
"   \ require('vscode').setup({
"   \   style = 'dark',
"   \   transparent = true,
"   \   italic_comments = true,
"   \   disable_nvimtree_bg = false,
"   \   color_overrides = {
"   \     vscLineNumber = '#FFFFFF',
"   \   },
"   \   group_overrides = {
"   \     Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
"   \   }
"   \ })
"   \ require('vscode').load('dark')


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
hi GitGutterAdd        gui=bold guifg=#00bb00
hi GitGutterChange     gui=bold guifg=#cccc00
hi GitGutterDelete     gui=bold guifg=#ff2222
hi DiffAdd             gui=none guifg=#dddddd guibg=#004400
hi DiffChange          gui=none guifg=#dddddd guibg=#555500
hi Difftext            gui=none guifg=#151515 guibg=#dddd00
hi DiffDelete          gui=none guifg=#dddddd guibg=#550000


"" Rnvimr
let g:rnvimr_enable_picker = 1
let g:rnvimr_draw_border = 1
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width':  float2nr(round(0.90 * &columns)),
            \ 'height': float2nr(round(0.90 * &lines)),
            \ 'col':    float2nr(round(0.05 * &columns)),
            \ 'row':    float2nr(round(0.05 * &lines)),
            \ 'style': 'minimal'
            \ }
hi RnvimrCurses guibg=#333333
