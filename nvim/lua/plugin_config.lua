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
  stages = "fade_in_slide_out",
  render = "default",
  background_colour = "#252525",
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
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg="#8a1f1f", bg="none" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder",  { fg="#79491d", bg="none" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder",  { fg="#4f6752", bg="none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg="#8b8b8b", bg="none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg="#4f3552", bg="none" })
vim.api.nvim_set_hl(0, "NotifyERRORIcon",   { fg="#f70067", bg="none" })
vim.api.nvim_set_hl(0, "NotifyWARNIcon",    { fg="#f79000", bg="none" })
vim.api.nvim_set_hl(0, "NotifyINFOIcon",    { fg="#a9ff68", bg="none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon",   { fg="#8b8b8b", bg="none" })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon",   { fg="#d484ff", bg="none" })
vim.api.nvim_set_hl(0, "NotifyERRORTitle",  { fg="#f70067", bg="none" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle",   { fg="#F79000", bg="none" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle",   { fg="#A9FF68", bg="none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle",  { fg="#8B8B8B", bg="none" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle",  { fg="#D484FF", bg="none" })
vim.api.nvim_set_hl(0, "NotifyERRORBody",   { fg="none",    bg="#252525" })
vim.api.nvim_set_hl(0, "NotifyWARNBody",    { fg="none",    bg="#252525" })
vim.api.nvim_set_hl(0, "NotifyINFOBody",    { fg="none",    bg="#252525" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody",   { fg="none",    bg="#252525" })
vim.api.nvim_set_hl(0, "NotifyTRACEBody",   { fg="none",    bg="#252525" })


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
    view = "cmdline",
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
vim.api.nvim_set_hl(0, "NoiceMini",         { fg="#ffbb00", bg="#383838" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg="none",    bg="#383838" })
vim.api.nvim_set_hl(0, "NoiceCmdline",      { fg="none",    bg="#1f1f1f" })
vim.api.nvim_set_hl(0, "NoiceConfirm",      { fg="none",    bg="#383838" })


-- which-key.nvim
require("which-key").setup({})


-- SplitTerm
vim.api.nvim_set_var("splitterm_auto_close_window", 1)


-- fzf.vim
vim.api.nvim_set_var("wildmode", "list:longest,list:full")
vim.api.nvim_set_var("wildignore", "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__")
vim.api.nvim_set_var('$FZF_DEFAULT_OPTS' , '--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up')
vim.api.nvim_set_var('fzf_layout',         { window = { width = 0.9, height = 0.9 } })
vim.api.nvim_set_var('fzf_preview_window', { 'right,50%,<70(down,60%)', 'ctrl-/' })
vim.api.nvim_set_var('fzf_colors',         {
    fg = { 'fg', 'FzfNormal' },
    bg = { 'bg', 'FzfNormal' },
    ['fg+'] = { 'fg', 'FzfCursorLine' },
    ['bg+'] = { 'bg', 'FzfCursorLine' },
    ['preview-fg'] = { 'fg', 'FzfPreview' },
    ['preview-bg'] = { 'bg', 'FzfPreview' },
})
vim.api.nvim_create_user_command("Files",
    "call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)",
    { bang = true, nargs = '?' }
)
vim.api.nvim_set_hl(0, "FzfNormal",     { fg="none",    bg="#2a2a2a" })
vim.api.nvim_set_hl(0, "FzfCursorLine", { fg="#ffffff", bg="#5e5e5e" })
vim.api.nvim_set_hl(0, "FzfPreview",    { fg="none",    bg="none" })
-- fzf.vim for Silver Searcher
if vim.fn.executable('ag') then
    vim.api.nvim_set_var('$FZF_DEFAULT_COMMAND' , 'ag --hidden --ignore .git -g ""')
    vim.opt.grepprg = 'ag --nogroup --nocolor'
end
-- fzf.vim for RipGrep
if vim.fn.executable('rg') then
    vim.api.nvim_set_var('$FZF_DEFAULT_COMMAND' , 'rg --files --hidden --follow --glob "!.git/*"')
    vim.opt.grepprg = 'rg --vimgrep'
    vim.api.nvim_create_user_command("Find",
        "call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob \"!.git/*\" --color \"always\" '.shellescape(<q-args>).'| tr -d \"\\017\"', 1, <bang>0)",
        { bang = true, nargs = '*' }
    )
    vim.api.nvim_create_user_command("Files",
        "call fzf#run(fzf#wrap(#{source: 'rg --files -uuu -g !.git/ -g !node_modules/ -L', options: '--preview-window \"nohidden,wrap,down,60%\" --preview \"[ -f {} ] && bat --color=always --style=numbers {} || echo {}\"'}))",
        { bang = true, nargs = '?' }
    )
end


-- vim-easy-align
vim.g.easy_align_ignore_groups = { 'String' }


-- skkeleton
vim.cmd([[
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
]])
vim.api.nvim_set_hl(0, "OilFile", { fg="#bbbbbb", bg="none", bold=true })
vim.api.nvim_set_hl(0, "OilDir",  { fg="#77aadd", bg="none", bold=true })
vim.api.nvim_set_hl(0, "OilLink", { fg="#77afaf", bg="none", bold=true })


-- auto-session
require("auto-session").setup({
  log_level = "error",
  auto_session_root_dir = vim.fn.stdpath("data").."/sessions/",
  auto_session_enabled=true,
  auto_session_create_enabled=true,
  auto_session_enable_last_session = false,
  auto_session_suppress_dirs = { "~/", "~/Project", "~/Downloads", "/" },
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_use_git_branch=false,
  bypass_session_save_file_types = nil,
  cwd_change_handling = {
    restore_upcoming_session = true,
    pre_cwd_changed_hook = nil,
    post_cwd_changed_hook = nil,
  },
})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')
    if not view.is_visible() then
      api.tree.open()
    end
  end,
})
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   pattern = '*MINIMAP*',
--   callback = function()
--     vim.cmd('Minimap')
--   end,
-- })


-- nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator",              { fg="#555555", bg="none" })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder",                { fg="#bbbbbb", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeFolderName",                { fg="#77aadd", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName",           { fg="#77aadd", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName",          { fg="#77aadd", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeSpecialFile",               { fg="#dfbf66", bg="none", bold = true, underline = true })
vim.api.nvim_set_hl(0, "NvimTreeSymlink",                   { fg="#77afaf", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeSymlinkFolderName",         { fg="#77afaf", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeExecFile",                  { fg="#bfbf66", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeGitDirty",                  { fg="#ddaa55", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeGitStaged",                 { fg="#44cc44", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeGitNew",                    { fg="#44cc44", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeModifiedFile",              { fg="#ffaa00", bg="none", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsError",       { fg="#ee3333", bg="none" })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsWarning",     { fg="#edd000", bg="none" })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsInformation", { fg="#ffffff", bg="none" })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsHint",        { fg="#5588dd", bg="none" })


-- vista.vim
vim.g.vista_no_mappings             = 0
vim.g.vista_echo_cursor             = 0
vim.g.vista_echo_cursor_strategy    = 'floating_win'
vim.g.vista_blink                   = {3, 200}
vim.g.vista_top_level_blink         = {3, 200}
vim.g.vista_highlight_whole_line    = 1
vim.g.vista_update_on_text_changed  = 1
vim.g.vista_sidebar_width           = 25
vim.g.vista_icon_indent             = {'└ ', '│ '}
vim.g["vista#renderer#enable_icon"] = 1
vim.g.vista_fzf_preview             = {'right,50%,<70(down,60%)'}
vim.g.vista_keep_fzf_colors         = 1
vim.g.vista_fzf_opt                 = {'--bind = ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up'}
vim.g.vista_default_executive       = 'nvim_lsp'
vim.api.nvim_set_hl(0, "VistaFloat",  { link = "Pmenu" })
vim.api.nvim_set_hl(0, "VistaLineNr", { fg="#777777", bg="none" })
vim.cmd([[
    fun! VistaInit() abort
      try
        if &filetype != ''
          call vista#RunForNearestMethodOrFunction()
        endif
      endtry
    endf
    " au BufEnter * call VistaInit()
]])


-- minimap.vim
vim.g.minimap_auto_start                        = 0
vim.g.minimap_auto_start_win_enter              = 0
vim.g.minimap_width                             = 10
vim.g.minimap_window_width_override_for_scaling = 2147483647
vim.g.minimap_block_filetypes                   = {'terminal', 'fzf', 'vista', 'vista_kind', 'NvimTree', 'rnvimr'}
-- vim.g.minimap_close_buftypes                    = {'nofile', 'startify', 'netrw', 'vim-plug', 'terminal'}
vim.g.minimap_enable_highlight_colorgroup       = 0
vim.g.minimap_highlight_range                   = 1
vim.g.minimap_highlight_search                  = 1
vim.g.minimap_git_colors                        = 1
vim.g.minimap_cursor_color_priority             = 110
vim.g.minimap_search_color_priority             = 120
vim.g.minimap_base_highlight                    = 'Normal'
vim.g.minimap_cursor_color                      = 'MyMinimapCursor'
vim.g.minimap_range_color                       = 'MyMinimapRange'
vim.g.minimap_search_color                      = 'MyMinimapSearch'
vim.g.minimap_diff_color                        = 'MyMinimapDiffLine'
vim.g.minimap_diffadd_color                     = 'MyMinimapDiffAdded'
vim.g.minimap_diffremove_color                  = 'MyMinimapDiffRemoved'
vim.api.nvim_set_hl(0, "MyMinimapCursor",      { fg="#000000", bg="#ffffff" })
vim.api.nvim_set_hl(0, "MyMinimapRange",       { fg="#ffffff", bg="#555555" })
vim.api.nvim_set_hl(0, "MyMinimapSearch",      { fg="#ffffff", bg="#bbbb00" })
vim.api.nvim_set_hl(0, "MyMinimapDiffLine",    { fg="#bbbb00", bg="none" })
vim.api.nvim_set_hl(0, "MyMinimapDiffAdded",   { fg="#00aa77", bg="none" })
vim.api.nvim_set_hl(0, "MyMinimapDiffRemoved", { fg="#bb0000", bg="none" })
-- vim.cmd([[
--     aug minimap_auto_start
--         au!
--         au WinEnter * if g:minimap_auto_start_win_enter | exe 'Minimap' | endif
--     aug END
-- ]])


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
require("indent_blankline").setup({
  show_current_context = true,
  show_current_context_start = true,
})
vim.g.indent_blankline_char                       = '│'
vim.g.indent_blankline_context_char               = '┃'
vim.g.indent_blankline_space_char_blankline       = ' '
vim.g.indent_blankline_use_treesitter             = true
vim.g.indent_blankline_indent_level               = 30
vim.g.indent_blankline_max_indent_increase        = vim.g.indent_blankline_indent_level
vim.g.indent_blankline_show_first_indent_level    = true
vim.g.indent_blankline_show_current_context_start = true
vim.g.indent_blankline_filetype_exclude           = { 'terminal', 'help', 'fzf', 'vista', 'vista_kind', 'NvimTree', 'mason', 'rnvimr' }
vim.g.indent_blankline_bufname_exclude            = { 'README.md' }
vim.g.indent_blankline_disable_with_nolist        = true
vim.api.nvim_set_hl(0, "IndentBlanklineChar",               { fg="#3a3a3a", bg="none", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar",        { fg="#606060", bg="none", bold = true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar",          { fg="#3a3a3a", bg="none", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { fg="#3a3a3a", bg="none", nocombine = true })


-- -- nvim-navic
-- require('nvim-navic').setup({
--     icons = {
--         File          = ' ',
--         Module        = ' ',
--         Namespace     = ' ',
--         Package       = ' ',
--         Class         = ' ',
--         Method        = ' ',
--         Property      = ' ',
--         Field         = ' ',
--         Constructor   = ' ',
--         Enum          = ' ',
--         Interface     = ' ',
--         Function      = ' ',
--         Variable      = ' ',
--         Constant      = ' ',
--         String        = ' ',
--         Number        = ' ',
--         Boolean       = ' ',
--         Array         = ' ',
--         Object        = ' ',
--         Key           = ' ',
--         Null          = ' ',
--         EnumMember    = ' ',
--         Struct        = ' ',
--         Event         = ' ',
--         Operator      = ' ',
--         TypeParameter = ' '
--     },
--     lsp = {
--         auto_attach = true,
--         preference = nil,
--     },
--     highlight = true,
--     separator = " 〉",
--     depth_limit = 0,
--     depth_limit_indicator = "..",
--     safe_output = true,
--     lazy_update_context = false,
--     click = true
-- })
vim.api.nvim_set_hl(0, "NavicIconsFile",          { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsModule",        { bold=false, bg="none", fg="#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace",     { bold=false, bg="none", fg="#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsPackage",       { bold=false, bg="none", fg="#c08855" })
vim.api.nvim_set_hl(0, "NavicIconsClass",         { bold=false, bg="none", fg="#c08855" })
vim.api.nvim_set_hl(0, "NavicIconsMethod",        { bold=false, bg="none", fg="#bb9999" })
vim.api.nvim_set_hl(0, "NavicIconsProperty",      { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsField",         { bold=false, bg="none", fg="#5577bb" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor",   { bold=false, bg="none", fg="#bb9999" })
vim.api.nvim_set_hl(0, "NavicIconsEnum",          { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsInterface",     { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsFunction",      { bold=false, bg="none", fg="#bb9999" })
vim.api.nvim_set_hl(0, "NavicIconsVariable",      { bold=false, bg="none", fg="#5577bb" })
vim.api.nvim_set_hl(0, "NavicIconsConstant",      { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsString",        { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsNumber",        { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean",       { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsArray",         { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsObject",        { bold=false, bg="none", fg="#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsKey",           { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsNull",          { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsStruct",        { bold=false, bg="none", fg="#c08855" })
vim.api.nvim_set_hl(0, "NavicIconsEvent",         { bold=false, bg="none", fg="#bbbb55" })
vim.api.nvim_set_hl(0, "NavicIconsOperator",      { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { bold=false, bg="none", fg="#bbbbbb" })
vim.api.nvim_set_hl(0, "NavicText",               { bold=false, bg="none", fg="#888888" })
vim.api.nvim_set_hl(0, "NavicSeparator",          { bold=false, bg="none", fg="#aaaaaa" })


-- barbeque
require("barbecue").setup({
  create_autocmd = false,
})
vim.api.nvim_create_autocmd(
  {
    "WinScrolled",
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    "BufModifiedSet",
  },
  {
    group = vim.api.nvim_create_augroup("barbecue.updater", {}),
    callback = function()
      require("barbecue.ui").update()
    end,
  }
)


-- nvim-navbuddy
require("nvim-navbuddy").setup({
  window = {
    border = "rounded",
    size = "80%",
  },
  icons = {
    [1]   = ' ',
    [2]   = ' ',
    [3]   = ' ',
    [4]   = ' ',
    [5]   = ' ',
    [6]   = ' ',
    [7]   = ' ',
    [8]   = ' ',
    [9]   = ' ',
    [10]  = ' ',
    [11]  = ' ',
    [12]  = ' ',
    [13]  = ' ',
    [14]  = ' ',
    [15]  = ' ',
    [16]  = ' ',
    [17]  = ' ',
    [18]  = ' ',
    [19]  = ' ',
    [20]  = ' ',
    [21]  = ' ',
    [22]  = ' ',
    [23]  = ' ',
    [24]  = ' ',
    [25]  = ' ',
    [26]  = ' ',
    [255] = "󰉨 ",
  },
  lsp = { auto_attach = true },
})


-- symbols-outline.nvim
require("symbols-outline").setup({
  highlight_hovered_item = true,
  show_guides = true,
  position = 'right',
  relative_width = false,
  width = 35,
  auto_close = false,
  auto_preview = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  keymaps = {
    close = {},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<Leader>k",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File          = { icon = " ", hl = "@text.uri" },
    Module        = { icon = " ", hl = "@namespace" },
    Namespace     = { icon = " ", hl = "@namespace" },
    Package       = { icon = " ", hl = "@namespace" },
    Class         = { icon = " ", hl = "@type" },
    Method        = { icon = " ", hl = "@method" },
    Property      = { icon = " ", hl = "@method" },
    Field         = { icon = " ", hl = "@field" },
    Constructor   = { icon = " ", hl = "@constructor" },
    Enum          = { icon = " ", hl = "@type" },
    Interface     = { icon = " ", hl = "@type" },
    Function      = { icon = " ", hl = "@function" },
    Variable      = { icon = " ", hl = "@constant" },
    Constant      = { icon = " ", hl = "@constant" },
    String        = { icon = " ", hl = "@string" },
    Number        = { icon = " ", hl = "@number" },
    Boolean       = { icon = " ", hl = "@boolean" },
    Array         = { icon = " ", hl = "@constant" },
    Object        = { icon = " ", hl = "@type" },
    Key           = { icon = " ", hl = "@type" },
    Null          = { icon = " ", hl = "@type" },
    EnumMember    = { icon = " ", hl = "@field" },
    Struct        = { icon = " ", hl = "@type" },
    Event         = { icon = " ", hl = "@type" },
    Operator      = { icon = " ", hl = "@operator" },
    TypeParameter = { icon = " ", hl = "@parameter" },
    Component     = { icon = " ", hl = "@function" },
    Fragment      = { icon = " ", hl = "@constant" },
  },
})
vim.api.nvim_set_hl(0, "FocusedSymbol",           { bold=true,  bg="#394260", fg="#e3e3f8" })
vim.api.nvim_set_hl(0, "SymbolsOutlineConnector", { bold=false, bg="none",    fg="#aaaaaa" })


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
]])
vim.g.lualine_diagnostics_source = 'nvim_diagnostic'
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
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = my_custom_theme,
    -- theme = 'vscode',
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {'NvimTree', 'vista', 'minimap'},
      winbar = {'NvimTree', 'vista', 'minimap'},
    },
    ignore_focus = {'NvimTree', 'vista', 'minimap'},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 250,
      tabline = 250,
      winbar = 250,
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
      -- { 'LualineVistaNearestMethodOrFunction' },
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
  winbar = {
    -- lualine_c = {
    --   {
    --     [[
    --       require('nvim-navic').get_location()
    --       .. ( require('nvim-navic').is_available() and ' ' or '' )
    --     ]],
    --     color_correction = nil,
    --     navic_opts = nil,
    --     color = { fg = '#666666', bg = 'none' }
    --   }
    -- }
  },
  inactive_winbar = {},
  extensions = {}
}
vim.api.nvim_set_hl(0, "lualine_lsp_err",     { fg="#ee3333", bg="#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_warn",    { fg="#edd000", bg="#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_hint",    { fg="#5599dd", bg="#212736" })
vim.api.nvim_set_hl(0, "lualine_lsp_info",    { fg="#5599dd", bg="#212736" })
vim.api.nvim_set_hl(0, "lualine_diff_add",    { fg="#66aa88", bg="#394260" })
vim.api.nvim_set_hl(0, "lualine_diff_change", { fg="#bbbb88", bg="#394260" })
vim.api.nvim_set_hl(0, "lualine_diff_delete", { fg="#aa6666", bg="#394260" })


-- barbar.nvim
vim.g.barbar_auto_setup = false
require('barbar').setup({
  animation = true,
  auto_hide = false,
  tabpages = false,
  clickable = true,
  icons = {
    buffer_index = false,
    buffer_number = false,
    button = '',
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ' '},
      [vim.diagnostic.severity.WARN] = {enabled = true, icon = ' '},
      [vim.diagnostic.severity.INFO] = {enabled = true, icon = ' '},
      [vim.diagnostic.severity.HINT] = {enabled = true, icon = ' '},
    },
    gitsigns = {
      added = {enabled = false, icon = '+'},
      changed = {enabled = false, icon = '~'},
      deleted = {enabled = false, icon = '-'},
    },
    filetype = {
      custom_colors = false,
      enabled = true,
    },
    separator = {left = '▎', right = ''},
    separator_at_end = false,
    modified = {button = '●'},
    pinned = {button = '', filename = true},
    preset = 'default',
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = false},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },
  highlight_alternate = false,
  highlight_inactive_file_icons = false,
  highlight_visible = true,
  insert_at_end = false,
  insert_at_start = false,
  maximum_padding = 1,
  minimum_padding = 1,
  maximum_length = 60,
  minimum_length = 12,
  sidebar_filetypes = { NvimTree = { text = '   File Explorer' } },
  no_name_title = '[No Name]',
})
vim.api.nvim_set_hl(0, "BufferTabpageFill",   { bg="none" })
vim.api.nvim_set_hl(0, "BufferCurrent",       { bg="#1e1e1e", fg="#ffffff", bold = true })
vim.api.nvim_set_hl(0, "BufferVisible",       { bg="none",    fg="#ffffff" })
vim.api.nvim_set_hl(0, "BufferInactive",      { bg="none",    fg="#888888" })
vim.api.nvim_set_hl(0, "BufferCurrentMod",    { bg="#1e1e1e", fg="#ffaa00", bold = true })
vim.api.nvim_set_hl(0, "BufferVisibleMod",    { bg="none",    fg="#ffaa00" })
vim.api.nvim_set_hl(0, "BufferInactiveMod",   { bg="none",    fg="#bb7700" })
vim.api.nvim_set_hl(0, "BufferCurrentSign",   { bg="#1e1e1e", fg="#88ccff", bold = true })
vim.api.nvim_set_hl(0, "BufferVisibleSign",   { bg="none",    fg="#5588dd" })
vim.api.nvim_set_hl(0, "BufferInactiveSign",  { bg="none",    fg="#444444" })
vim.api.nvim_set_hl(0, "BufferCurrentERROR",  { bg="#1e1e1e", fg="#ee3333" })
vim.api.nvim_set_hl(0, "BufferVisibleERROR",  { bg="none",    fg="#ee3333" })
vim.api.nvim_set_hl(0, "BufferInactiveERROR", { bg="none",    fg="#aa3333" })
vim.api.nvim_set_hl(0, "BufferCurrentWARN",   { bg="#1e1e1e", fg="#edd000" })
vim.api.nvim_set_hl(0, "BufferVisibleWARN",   { bg="none",    fg="#edd000" })
vim.api.nvim_set_hl(0, "BufferInactiveWARN",  { bg="none",    fg="#908000" })
vim.api.nvim_set_hl(0, "BufferCurrentHINT",   { bg="#1e1e1e", fg="#5588dd" })
vim.api.nvim_set_hl(0, "BufferVisibleHINT",   { bg="none",    fg="#5588dd" })
vim.api.nvim_set_hl(0, "BufferInactiveHINT",  { bg="none",    fg="#4466aa" })
vim.api.nvim_set_hl(0, "BufferCurrentINFO",   { bg="#1e1e1e", fg="#ffffff" })
vim.api.nvim_set_hl(0, "BufferVisibleINFO",   { bg="none",    fg="#ffffff" })
vim.api.nvim_set_hl(0, "BufferInactiveINFO",  { bg="none",    fg="#888888" })


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
      cursor = false,
      handle = true,
      diagnostic = true,
      gitsigns = true,
      search = true,
  },
})
vim.api.nvim_set_hl(0, "ScrollbarHandle",          { fg="#333333", bg="#888888" })
vim.api.nvim_set_hl(0, "ScrollbarCursor",          { fg="#333333", bg="#888888" })
vim.api.nvim_set_hl(0, "ScrollbarCursorHandle",    { fg="#ffffff", bg="#888888" })
vim.api.nvim_set_hl(0, "ScrollbarSearch",          { fg="#ffaa77", bg="none",    bold = true })
vim.api.nvim_set_hl(0, "ScrollbarSearchHandle",    { fg="#ffaa77", bg="#888888", bold = true })
vim.api.nvim_set_hl(0, "ScrollbarError",           { fg="#ee3333", bg="none",    bold = true })
vim.api.nvim_set_hl(0, "ScrollbarErrorHandle",     { fg="#ee3333", bg="#888888", bold = true })
vim.api.nvim_set_hl(0, "ScrollbarWarn",            { fg="#edd000", bg="none",    bold = true })
vim.api.nvim_set_hl(0, "ScrollbarWarnHandle",      { fg="#edd000", bg="#888888", bold = true })
vim.api.nvim_set_hl(0, "ScrollbarHint",            { fg="#5599dd", bg="none",    bold = true })
vim.api.nvim_set_hl(0, "ScrollbarHintHandle",      { fg="#5599dd", bg="#888888", bold = true })
vim.api.nvim_set_hl(0, "ScrollbarInfo",            { fg="#ffffff", bg="none",    bold = true })
vim.api.nvim_set_hl(0, "ScrollbarInfoHandle",      { fg="#ffffff", bg="#888888", bold = true })
vim.api.nvim_set_hl(0, "ScrollbarGitAdd",          { fg="#00bb00", bg="none" })
vim.api.nvim_set_hl(0, "ScrollbarGitAddHandle",    { fg="#00bb00", bg="#888888" })
vim.api.nvim_set_hl(0, "ScrollbarGitChange",       { fg="#cccc00", bg="none" })
vim.api.nvim_set_hl(0, "ScrollbarGitChangeHandle", { fg="#cccc00", bg="#888888" })
vim.api.nvim_set_hl(0, "ScrollbarGitDelete",       { fg="#bb2222", bg="none" })
vim.api.nvim_set_hl(0, "ScrollbarGitDeleteHandle", { fg="#bb2222", bg="#888888" })


-- neoscroll.nvim
require("neoscroll").setup({
  mappings = {
    "<C-u>",
    "<C-d>",
  },
  hide_cursor = true,
  stop_eof = true,
  respect_scrolloff = true,
  cursor_scrolls_alone = true,
  easing_function = "quadratic",
})
require('neoscroll.config').set_mappings({
  ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '300'}},
  ['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '300'}},
})


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
vim.api.nvim_set_hl(0, "Search",           { fg="none",    bg="#334f7a" })
vim.api.nvim_set_hl(0, "IncSearch",        { fg="none",    bg="#334f7a" })
vim.api.nvim_set_hl(0, "WildMenu",         { fg="none",    bg="#334f7a" })
vim.api.nvim_set_hl(0, "HlSearchNear",     { link = "IncSearch", default = true })
vim.api.nvim_set_hl(0, "HlSearchLens",     { fg="#777777", bg="none" })
vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg="#777777", bg="none" })


-- lightspeed.nvim
require('lightspeed').setup({
  ignore_case = false,
  exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
  limit_ft_matches = 4,
  repeat_ft_with_target_char = false,
})
vim.api.nvim_set_hl(0, "LightspeedOneCharMatch", { fg="#ff3377", bg="none", bold = true })
vim.api.nvim_set_hl(0, "LightspeedCursor",       { fg="none",    bg="none", bold = true })


-- fuzzy-motion.vim
vim.g.fuzzy_motion_auto_jump = true
vim.api.nvim_set_hl(0, "FuzzyMotionShade",   { fg="#666666", bg="none",    bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionChar",    { fg="#eeeeee", bg="#ff3377", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionSubChar", { fg="#eeeeee", bg="#ff3377", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionMatch",   { fg="#66bbee", bg="none",    bold = true })


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
        line = '<C-_>',
        block = 'gbc',
    },
    opleader = {
        line = '<C-_>',
        block = 'gb',
    },
    extra = {
        -- above = 'gcO',
        -- below = 'gco',
        -- eol = 'gcA',
    },
    mappings = {
        basic = true,
        extra = true,
    },
})


-- nvim-highlight-colors
require('nvim-highlight-colors').setup({
    render = 'background',
    enable_named_colors = true,
})


-- nvim-autopairs
require('nvim-autopairs').setup({})
require('cmp').event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)


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
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 0,
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
vim.api.nvim_set_hl(0, "GitSignsAdd",              { fg="#00bb00", bg="none", bold = true })
vim.api.nvim_set_hl(0, "GitSignsChange",           { fg="#aaaa00", bg="none", bold = true })
vim.api.nvim_set_hl(0, "GitSignsDelete",           { fg="#ff2222", bg="none", bold = true })
vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg="#777777", bg="none" })
vim.api.nvim_set_hl(0, "DiffAdd",                  { fg="none",    bg="#004400" })
vim.api.nvim_set_hl(0, "DiffChange",               { fg="none",    bg="#303000" })
vim.api.nvim_set_hl(0, "Difftext",                 { fg="none",    bg="#505000" })
vim.api.nvim_set_hl(0, "DiffDelete",               { fg="none",    bg="#440000" })


-- rnvimr
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_draw_border = 1
vim.cmd([[
  let g:rnvimr_layout = {
    \ 'relative': 'editor',
    \ 'width':  float2nr(round(0.90 * &columns)),
    \ 'height': float2nr(round(0.90 * &lines)),
    \ 'col':    float2nr(round(0.05 * &columns)),
    \ 'row':    float2nr(round(0.05 * &lines)),
    \ 'style': 'minimal'
    \ }
]])
vim.api.nvim_set_hl(0, "RnvimrCurses", { fg="none", bg="#2a2a2a" })
