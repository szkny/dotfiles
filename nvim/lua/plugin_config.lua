-- *****************************************************************************
--   Plugin Configuration
-- *****************************************************************************

-- nvim-web-devicons
require'nvim-web-devicons'.setup {
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  },
  ["txt"] = {
    icon = "",
    color = "#81e043",
    name = "Text"
  },
  ["csv"] = {
    icon = "",
    color = "#81e043",
    name = "Csv"
  },
  ["tsv"] = {
    icon = "",
    color = "#81e043",
    name = "Tsv"
  },
  ["dockerfile"] = {
    icon = "",
    color = "#5599dd",
    name = "Dockerfile"
  }
 },
}

-- nvim-notify
--   stages = "fade_in_slide_out",
--   stages = "fade",
--   render = "default",
--   render = "compact",
require("notify").setup({
  stages = "fade",
  render = "compact",
  background_colour = "#3e3e3e",
  timeout = 3000,
  max_width = 80,
  minimum_width = 50,
  top_down = false,
  fps = 60,
  icons = {
    ERROR = " ",
    WARN = " ",
    INFO = " ",
    DEBUG = " ",
    TRACE = "✎ ",
  },
})
vim.cmd([[
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
]])


-- noice.nvim
require("noice").setup({
  messages = {
    enabled = true,
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "messages",
    view_search = "mini",
  },
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "zsh" },
      lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
    },
  },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true,
  },
})
vim.cmd([[
    hi NoiceMini         guifg=#ffbb00 guibg=#383838
    hi NoiceCmdlinePopup               guibg=#383838
    hi NoiceConfirm                    guibg=#383838
]])


-- SplitTerm
vim.api.nvim_set_var("splitterm_auto_close_window", 1)


-- fzf.vim
vim.api.nvim_set_var("wildmode", "list:longest,list:full")
vim.api.nvim_set_var("wildignore", "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__")
-- The Silver Searcher
if vim.fn.executable('ag') then
    vim.api.nvim_set_var('$FZF_DEFAULT_COMMAND' , 'ag --hidden --ignore .git -g ""')
    vim.opt.grepprg = 'ag --nogroup --nocolor'
end
if vim.fn.executable('rg') then
    vim.api.nvim_set_var('$FZF_DEFAULT_COMMAND' , 'rg --files --hidden --follow --glob "!.git/*"')
    vim.opt.grepprg = 'rg --vimgrep'
    vim.api.nvim_create_user_command("Find",
        "call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob \"!.git/*\" --color \"always\" '.shellescape(<q-args>).'| tr -d \"\\017\"', 1, <bang>0)",
        { bang = true, nargs = '*' }
    )
end
vim.api.nvim_set_var('$FZF_DEFAULT_OPTS' , '--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up')
vim.api.nvim_create_user_command("Files",
    "call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)",
    { bang = true, nargs = '?' }
)
-- let g:fzf_layout = { 'window': 'enew' }
vim.cmd([[
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
    let g:fzf_preview_window = ['right,50%,<70(down,60%)', 'ctrl-/']
    let g:fzf_colors =
    \ { 'fg':         ['fg', 'FzfNormal'],
    \   'bg':         ['bg', 'FzfNormal'],
    \   'fg+':        ['fg', 'FzfCursorLine'],
    \   'bg+':        ['bg', 'FzfCursorLine'],
    \   'preview-fg': ['fg', 'FzfPreview'],
    \   'preview-bg': ['bg', 'FzfPreview']}
    hi link FzfNormal Normal
    hi FzfNormal                   guibg=#2a2a2a 
    hi FzfCursorLine guifg=#ffffff guibg=#5e5e5e 
    hi FzfPreview                  guibg=none 
]])


-- vim-easy-align
vim.cmd([[
    let g:easy_align_ignore_groups = ['String']
]])


-- pum.vim
vim.cmd([[
    set shortmess+=c
    set wildoptions+=pum
    hi PumNormalMenu gui=none guifg=#dddddd guibg=#383838
    hi PumColumnKind gui=none guifg=#888888 guibg=#383838
    hi PumColumnMenu gui=none guifg=#888888 guibg=#383838
    hi PumSelected  gui=bold guibg=#226688
    hi PumMatches   guifg=#44aabb
    hi PmenuSBar    guifg=#666666 guibg=#cccccc
    hi FloatBorder  gui=bold guibg=#282828
    call pum#set_option(#{
      \   auto_select: v:true,
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

    call ddc#custom#patch_global(#{
       \   sources: [
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
       \     skkeleton: #{
       \       mark: '[SKK]',
       \       matchers: ['skkeleton'],
       \       sorters: [],
       \       isVolatile: v:true,
       \     },
       \   },
       \ })

    fun s:enable_ddc() abort
        let l:current_mode = mode()
        if (l:current_mode=='i')
            let b:coc_suggest_disable = v:true
            call ddc#custom#patch_global('autoCompleteEvents',
            \ ['TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter'])
            call DdcMapping()
        endif
    endf

    fun s:disable_ddc() abort
        let l:current_mode = mode()
        if (l:current_mode=='i')
            let b:coc_suggest_disable = v:false
            call ddc#custom#patch_global('autoCompleteEvents', ['CmdlineChanged', 'CmdlineEnter'])
            call CocMapping()
        endif
    endf

    call <sid>disable_ddc()

    aug toggleSkkeleton
        au!
        au User skkeleton-enable-pre  call <sid>enable_ddc()
        au User skkeleton-disable-pre call <sid>disable_ddc()
    aug END

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
]])


-- oil.nvim
require("oil").setup({
    columns = {
      "permissions",
      "size",
      "mtime",
      "icon",
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "n",
    },
    default_file_explorer = true,
    trash_command = "rip",
    use_default_keymaps = false,
    keymaps = {
      ["?"]     = "actions.show_help",
      ["<CR>"]  = "actions.select",
      ["<2-LeftMouse>"] = "actions.select",
      ["<C-l>"] = "actions.select",
      ["<C-h>"] = "actions.parent",
      ["W"]     = "actions.open_cwd",
      ["<Tab>"] = "actions.preview",
      ["q"]     = "actions.close",
      ["R"]     = "actions.refresh",
      ["H"]     = "actions.toggle_hidden",
      ["I"]     = "actions.toggle_hidden",
      ["<BS>"]  = "actions.toggle_hidden",
    },
})
vim.cmd([[
    fun! s:oil_init() abort
        setlocal nonumber
        setlocal nobuflisted
        setlocal nolist
        setlocal nospell
        setlocal noequalalways
        " vertical resize 25
    endf
    au FileType oil call s:oil_init()
    hi OilFile gui=bold guifg=#bbbbbb
    hi OilDir  gui=bold guifg=#77aadd
    hi OilLink gui=bold guifg=#77afaf
]])


-- nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)
vim.cmd([[
    hi NvimTreeRootFolder                gui=bold guifg=#bbbbbb
    hi NvimTreeFolderName                gui=bold guifg=#77aadd
    hi NvimTreeEmptyFolderName           gui=bold guifg=#77aadd
    hi NvimTreeOpenedFolderName          gui=bold guifg=#77aadd
    hi NvimTreeSpecialFile               gui=bold,underline guifg=#dfbf66
    hi NvimTreeSymlink                   gui=bold guifg=#77afaf
    hi NvimTreeSymlinkFolderName         gui=bold guifg=#77afaf
    hi NvimTreeExecFile                  gui=bold guifg=#bfbf66
    hi NvimTreeGitDirty                  gui=bold guifg=#ddaa55
    hi NvimTreeGitStaged                 gui=bold guifg=#44cc44
    hi NvimTreeGitNew                    gui=bold guifg=#44cc44
    hi NvimTreeModifiedFile              gui=bold guifg=#ffaa00
    hi NvimTreeLspDiagnosticsError       gui=none guifg=#ff0000
    hi NvimTreeLspDiagnosticsWarning     gui=none guifg=#dddd00
    hi NvimTreeLspDiagnosticsInformation gui=none guifg=#ffffff
    hi NvimTreeLspDiagnosticsHint        gui=none guifg=#5588dd
]])


-- vista.vim
vim.cmd([[
    let g:vista_no_mappings            = 0
    let g:vista_echo_cursor            = 0
    let g:vista_echo_cursor_strategy   = 'floating_win'
    let g:vista_blink                  = [3, 200]
    let g:vista_top_level_blink        = [3, 200]
    let g:vista_highlight_whole_line   = 1
    let g:vista_update_on_text_changed = 1
    let g:vista_sidebar_width          = 25
    let g:vista_icon_indent            = ['└ ', '│ ']
    let g:vista#renderer#enable_icon   = 1
    let g:vista_fzf_preview            = ['right,50%,<70(down,60%)']
    let g:vista_keep_fzf_colors        = 1
    let g:vista_fzf_opt                = ['--bind=ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up']
    let g:vista_default_executive = 'coc'
    fun! VistaInit() abort
      try
        if &filetype != ''
          call vista#RunForNearestMethodOrFunction()
        endif
      endtry
    endf
    au BufEnter * call VistaInit()
    hi link VistaFloat Pmenu
    " hi VistaKind   guifg=
    " hi VistaTag    guifg=
    " hi VistaPublic guifg=
    hi VistaLineNr guifg=#777777
]])


-- minimap.vim
vim.cmd([[
    let g:minimap_auto_start                        = 0
    let g:minimap_auto_start_win_enter              = 0
    let g:minimap_width                             = 12
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
]])


-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "vim",
    "regex",
    "json",
    "markdown",
    "c",
    "cpp",
    "python",
    "go",
    "javascript",
    "typescript",
    "vue",
    "css",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = { "haskell", "help" },
  highlight = {
    enable = true,
    disable = {
      "haskell",
      "markdown",
      "vim",
      "terraform",
      "terraform-vars",
  },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
}


-- indent-blankline.nvim
vim.cmd([[
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
]])


-- lualine.nvim
vim.cmd([[
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
    let g:lualine_diagnostics_source = 'coc'
]])
local my_custom_theme = {
  normal = {
    a = { fg = '#ddddee', bg = '#5588dd' , gui = 'bold' },
    b = { fg = '#5588dd', bg = '#394260' },
    c = { fg = '#5588dd', bg = '#212736' },
  },
  insert   = { a = { fg = '#394260', bg = '#a3aed2', gui = 'bold' } },
  terminal = { a = { fg = '#394260', bg = '#a3aed2', gui = 'bold' } },
  visual   = { a = { fg = '#394260', bg = '#88b4c4', gui = 'bold' } },
  replace  = { a = { fg = '#394260', bg = '#9988dd', gui = 'bold' } },
  inactive = {
    a = { fg = '#ddddee', bg = '#212736' },
    b = { fg = '#ddddee', bg = '#212736' },
    c = { fg = '#ddddee', bg = '#212736' },
  },
}
local lualine_diagnostics = {
  'diagnostics',
  sources = { vim.g.lualine_diagnostics_source },
  sections = { 'error', 'warn', 'info', 'hint' },
  diagnostics_color = {
    error = 'lualine_lsp_err',
    warn  = 'lualine_lsp_warn',
    info  = 'lualine_lsp_info',
    hint  = 'lualine_lsp_hint',
  },
  symbols = {
    error = ' ',
    warn  = ' ',
    info  = ' ',
    hint  = ' '
  },
  colored = true,
  update_in_insert = true,
  always_visible = false,
}
local lualine_diff = {
  'diff',
  colored = true,
  diff_color = {
    added    = 'lualine_diff_add',
    modified = 'lualine_diff_change',
    removed  = 'lualine_diff_delete',
  },
  symbols = {added = '+', modified = '~', removed = '-'},
}
local lualine_filename = {
  'filename',
  file_status = true,
  newfile_status = false,
  symbols = {
    modified = '●',
    readonly = '',
    unnamed = '[No Name]',
    newfile = '[New]',
  }
}
-- local lualine_noice = {
--   {
--     require("noice").api.status.message.get_hl,
--     cond = require("noice").api.status.message.has,
--   },
--   {
--     require("noice").api.status.command.get,
--     cond = require("noice").api.status.command.has,
--     color = { fg = "#ff9e64" },
--   },
--   {
--     require("noice").api.status.mode.get,
--     cond = require("noice").api.status.mode.has,
--     color = { fg = "#ff9e64" },
--   },
--   {
--     require("noice").api.status.search.get,
--     cond = require("noice").api.status.search.has,
--     color = { fg = "#ff9e64" },
--   },
-- }
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = my_custom_theme,
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {'NvimTree', 'vista', 'minimap'},
      winbar = {},
    },
    ignore_focus = {'NvimTree', 'vista', 'minimap'},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '', right = '' } },
      { 'LualineSkkeletonMode' }
    },
    lualine_b = { 'branch', lualine_diff },
    lualine_c = {
      lualine_filename,
      { 'LualineVistaNearestMethodOrFunction' },
    },
    lualine_x = {
      lualine_diagnostics, 'filetype', 'encoding', 'fileformat',
    },
    lualine_y = { 'progress' },
    lualine_z = { {'location', separator = { left = '', right = '' } } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
vim.cmd([[
    hi lualine_lsp_err     guibg=#212736 guifg=#ff0000
    hi lualine_lsp_warn    guibg=#212736 guifg=#dddd00
    hi lualine_lsp_hint    guibg=#212736 guifg=#5599dd
    hi lualine_lsp_info    guibg=#212736 guifg=#5599dd
    hi lualine_diff_add    guibg=#394260 guifg=#66aa88
    hi lualine_diff_change guibg=#394260 guifg=#bbbb88
    hi lualine_diff_delete guibg=#394260 guifg=#aa6666
]])


-- bufferline.nvim
  -- separator_style = 'slant',
require('bufferline').setup {
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = "bn|sp|bp|bd! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    indicator = {
      icon = '▎',
      style = 'icon'
    },
    max_name_length = 36,
    max_prefix_length = 6,
    truncate_names = true,
    tab_size = 18,
    diagnostics = "coc",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and ""
                   or level:match("warning") and ""
                   or level:match("hint") and "" or ""
        return icon .. " " .. count
    end,
    custom_filter = function(buf_number)
        if vim.bo[buf_number].filetype ~= "qf" then
            return true
        end
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ':t:gs?\\l?\\U\\0?')
        end,
        text_align = "left",
        separator = true,
        highlight = "NvimTreeRootFolder",
      }
    },
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
  },
  highlights = {
    buffer_selected = {
      fg = '#ffffff',
      bg = 'none',
      italic = false,
      bold = true,
    },
    buffer_visible = {
      fg = '#ffffff',
      bg = 'none',
      italic = false,
      bold = true,
    },
    duplicate_selected = {
      fg = '#ffffff',
      bg = 'none',
      italic = false,
      bold = true,
    },
    duplicate_visible = {
      fg = '#ffffff',
      bg = 'none',
      italic = false,
    },
    diagnostic_selected = {
        bg = 'none',
        bold = true,
        italic = false,
    },
    diagnostic_visible = {
        bg = 'none',
        bold = true,
        italic = false,
    },
    error_selected = {
        fg = '#ff0000',
        bg = 'none',
        bold = true,
        italic = false,
    },
    error_visible = {
        fg = '#ff0000',
        bg = 'none',
        bold = true,
        italic = false,
    },
    error_diagnostic_selected = {
        fg = '#ff0000',
        bg = 'none',
        bold = true,
        italic = false,
    },
    error_diagnostic_visible = {
        fg = '#ff0000',
        bg = 'none',
        bold = true,
        italic = false,
    },
    warning_selected = {
        fg = '#dddd00',
        bg = 'none',
        bold = true,
        italic = false,
    },
    warning_visible = {
        fg = '#dddd00',
        bg = 'none',
        bold = true,
        italic = false,
    },
    warning_diagnostic_selected = {
        fg = '#dddd00',
        bg = 'none',
        bold = true,
        italic = false,
    },
    warning_diagnostic_visible = {
        fg = '#dddd00',
        bg = 'none',
        bold = true,
        italic = false,
    },
    info_selected = {
        fg = '#ffffff',
        bg = 'none',
        bold = true,
        italic = false,
    },
    info_visible = {
        fg = '#ffffff',
        bg = 'none',
        bold = true,
        italic = false,
    },
    info_diagnostic_selected = {
        fg = '#ffffff',
        bg = 'none',
        bold = true,
        italic = false,
    },
    info_diagnostic_visible = {
        fg = '#ffffff',
        bg = 'none',
        bold = true,
        italic = false,
    },
    hint_selected = {
        fg = '#ffffff',
        bg = 'none',
        bold = true,
        italic = false,
    },
    hint_visible = {
        fg = '#ffffff',
        bg = 'none',
        bold = true,
        italic = false,
    },
    hint_diagnostic_selected = {
        fg = '#5588dd',
        bg = 'none',
        bold = true,
        italic = false,
    },
    hint_diagnostic_visible = {
        fg = '#5588dd',
        bg = 'none',
        bold = true,
        italic = false,
    },
    indicator_selected = {
      fg = '#88ccff',
      bg = 'none',
    },
    close_button = {
      fg = '#888888',
      bg = 'none',
    },
    close_button_visible = {
      fg = '#888888',
      bg = 'none',
    },
    close_button_selected = {
      fg = '#aaaaaa',
      bg = 'none',
      bold = true,
    },
    numbers_selected = {
      fg = '#ffffff',
      bg = 'none',
      italic = false,
    },
    modified_selected = {
      fg = '#ffaa00',
      bg = 'none',
      bold = true,
    },
    fill = {
      fg = '#555555',
      bg = 'none',
    },
    background = {
      fg = '#888888',
      bg = '#181d24',
    },
    duplicate = {
      fg = "#888888",
      bg = '#181d24',
      italic = false,
    },
    diagnostic = {
        fg = '#888888',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    error = {
        fg = '#880000',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    error_diagnostic = {
        fg = '#880000',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    warning = {
        fg = '#888800',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    warning_diagnostic = {
        fg = '#888800',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    info = {
        fg = '#888888',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    info_diagnostic = {
        fg = '#888888',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    hint = {
        fg = '#888888',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    hint_diagnostic = {
        fg = '#4466aa',
        bg = '#181d24',
        bold = true,
        italic = false,
    },
    numbers = {
      fg = '#888888',
      bg = '#181d24',
      italic = false,
    },
    numbers_visible = {
      fg = '#888888',
      bg = '#181d24',
      italic = false,
    },
    modified = {
      fg = '#bb7700',
      bg = "#181d24",
      bold = true,
    },
    separator_selected = {
      fg = "#303030",
      bg = "#181d24",
    },
    separator_visible = {
      fg = "#303030",
      bg = "#181d24",
    },
    separator = {
      fg = "#444450",
      bg = "#181d24",
    },
    offset_separator = {
      fg = win_separator_fg,
      bg = 'none',
    },
  }
}


-- nvim-scrollbar
require("scrollbar").setup({
  show = true,
  show_in_active_only = true,
  set_highlights = true,
  max_lines = false,
  hide_if_all_visible = true,
  handle = {
    text = " ",
    highlight = "CursorColumn",
    hide_if_all_visible = true,
  },
  marks = {
    Cursor = {
      text = "•",
      priority = 0,
      highlight = "Normal",
    },
    Search = {
      text = { "-", "=" },
      priority = 1,
      highlight = "Search",
    },
  },
  Error = {
      text = { "-", "=" },
      priority = 2,
      highlight = "DiagnosticVirtualTextError",
  },
  Warn = {
      text = { "-", "=" },
      priority = 3,
      highlight = "DiagnosticVirtualTextWarn",
  },
  Info = {
      text = { "-", "=" },
      priority = 4,
      highlight = "DiagnosticVirtualTextInfo",
  },
  Hint = {
      text = { "-", "=" },
      priority = 5,
      highlight = "DiagnosticVirtualTextHint",
  },
  GitAdd = {
      text = "│",
      priority = 7,
      highlight = "GitSignsAdd",
  },
  GitChange = {
      text = "│",
      priority = 7,
      highlight = "GitSignsChange",
  },
  GitDelete = {
      text = "▁",
      priority = 7,
      highlight = "GitSignsDelete",
  },
  excluded_buftypes = {
    "terminal",
    "nofile",
  },
  excluded_filetypes = {
    "prompt",
    "minimap",
    "NvimTree",
    "noice",
  },
  autocmd = {
    render = {
      "BufWinEnter",
      "TabEnter",
      "TermEnter",
      "WinEnter",
      "CmdwinLeave",
      "TextChanged",
      "VimResized",
      "WinScrolled",
    },
    clear = {
      "TabLeave",
      "TermLeave",
      "WinLeave",
    },
  },
  handlers = {
      cursor = true,
      handle = true,
      diagnostic = true,
      gitsigns = true,
      search = true,
  },
})
vim.cmd([[
    hi ScrollbarHandle          gui=none guifg=#333333 guibg=#888888
    hi ScrollbarCursor          gui=none guifg=#333333 guibg=#888888
    hi ScrollbarCursorHandle    gui=none guifg=#ffffff guibg=#888888
    hi ScrollbarSearch          gui=bold guifg=#ffaa77
    hi ScrollbarSearchHandle    gui=bold guifg=#ffaa77 guibg=#888888
    hi ScrollbarError           gui=bold guifg=#ff0000
    hi ScrollbarErrorHandle     gui=bold guifg=#ff0000 guibg=#888888
    hi ScrollbarWarn            gui=bold guifg=#dddd00
    hi ScrollbarWarnHandle      gui=bold guifg=#dddd00 guibg=#888888
    hi ScrollbarHint            gui=bold guifg=#5599dd
    hi ScrollbarHintHandle      gui=bold guifg=#5599dd guibg=#888888
    hi ScrollbarInfo            gui=bold guifg=#ffffff
    hi ScrollbarInfoHandle      gui=bold guifg=#ffffff guibg=#888888
    hi ScrollbarGitAdd          gui=none guifg=#00bb00
    hi ScrollbarGitAddHandle    gui=none guifg=#00bb00 guibg=#888888
    hi ScrollbarGitChange       gui=none guifg=#cccc00
    hi ScrollbarGitChangeHandle gui=none guifg=#cccc00 guibg=#888888
    hi ScrollbarGitDelete       gui=none guifg=#ff2222
    hi ScrollbarGitDeleteHandle gui=none guifg=#ff2222 guibg=#888888
]])


-- nvim-hlslens
require('hlslens').setup( {
  calm_down = true,
  nearest_only = true,
  nearest_float_when = 'auto',
  build_position_cb = function(plist, _, _, _)
    require("scrollbar.handlers.search").handler.show(plist.start_pos)
  end,
})
local kopts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.cmd([[
    hi Search    guibg=#334f7a
    hi IncSearch guibg=#334f7a
    hi WildMenu  guibg=#334f7a
    hi default link HlSearchNear IncSearch
    " hi default link HlSearchLens WildMenu
    " hi default link HlSearchLensNear IncSearch
    hi HlSearchLens     guifg=#777777 guibg=none
    hi HlSearchLensNear guifg=#777777 guibg=none
]])


--  visual-multi  " TODO
vim.cmd([[
    let g:VM_default_mappings = 0
    let g:VM_maps = {}
    let g:VM_maps['Find Under']         = '<C-d>'      " replace C-n
    let g:VM_maps['Find Subword Under'] = '<C-d>'      " replace visual C-n
    let g:VM_maps["Select Cursor Down"] = '<M-C-Down>' " start selecting down
    let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'   " start selecting up
]])


-- Comment.nvim
require('Comment').setup({
    padding = true,
    sticky = true,
    toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
    },
    mappings = {
        basic = true,
        extra = true,
    },
})
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', {})
vim.api.nvim_set_keymap('v', '<C-_>', 'gc',  {})


-- nvim-highlight-colors
require('nvim-highlight-colors').setup({
    render = 'background',
    enable_named_colors = true,
})


-- delimitmate
vim.cmd([[
    let g:delimitMate_autoclose            = 1
    let g:delimitMate_matchpairs           = "(:),[:],{:}"
    let g:delimitMate_jump_expansion       = 1
    let g:delimitMate_expand_space         = 1
    let g:delimitMate_expand_cr            = 2
    let g:delimitMate_expand_inside_quotes = 1
    let g:delimitMate_balance_matchpairs   = 1
    ino {<CR> {<CR>} <C-o>O
]])


-- fugitive
vim.cmd([[
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
    au FileType fugitive call s:fugitive_init()
]])


-- gitsigns.nvim
require("scrollbar.handlers.gitsigns").setup()
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,
  numhl      = false,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = true,
    virt_text_priority = 0,
  },
  current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', '<leader>gn', function()
      if vim.wo.diff then return '' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map('n', '<leader>gp', function()
      if vim.wo.diff then return '' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})
  end
}
vim.cmd([[
    hi GitSignsAdd    gui=bold guifg=#00bb00
    hi GitSignsChange gui=bold guifg=#aaaa00
    hi GitSignsDelete gui=bold guifg=#ff2222
    hi GitSignsCurrentLineBlame gui=none guifg=#777777
    hi DiffAdd    gui=none guifg=none guibg=#004400
    hi DiffChange gui=none guifg=none guibg=#303000
    hi Difftext   gui=none guifg=none guibg=#505000
    hi DiffDelete gui=none guifg=none guibg=#440000
]])


-- rnvimr
vim.cmd([[
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
    hi RnvimrCurses guibg=#2a2a2a
]])
