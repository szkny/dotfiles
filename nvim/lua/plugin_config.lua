-- *****************************************************************************
--   Plugin Configuration
-- *****************************************************************************

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

-- barbar.nvim
require("plugin.barbar")

-- gitsigns
require("plugin.gitsigns")

-- nvim-scrollbar
require("plugin.nvim_scrollbar")

-- nvim-hlslens
require("plugin.nvim_hlslens")

-- lightspeed.nvim
require("lightspeed").setup({
	ignore_case = false,
	exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
	limit_ft_matches = 4,
	repeat_ft_with_target_char = false,
})
vim.api.nvim_set_hl(0, "LightspeedOneCharMatch", { fg = "#ff3377", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "LightspeedCursor", { fg = "none", bg = "none", bold = true })

-- fuzzy-motion.vim
vim.g.fuzzy_motion_auto_jump = true
vim.api.nvim_set_hl(0, "FuzzyMotionShade", { fg = "#666666", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionChar", { fg = "#eeeeee", bg = "#ff3377", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionSubChar", { fg = "#eeeeee", bg = "#ff3377", bold = true })
vim.api.nvim_set_hl(0, "FuzzyMotionMatch", { fg = "#66bbee", bg = "none", bold = true })

--  visual-multi  " TODO
vim.cmd([[
    let g:VM_default_mappings = 0
    let g:VM_maps = {}
    let g:VM_maps['Find Under']         = '<C-d>'      " replace C-n
    let g:VM_maps['Find Subword Under'] = '<C-d>'      " replace visual C-n
    let g:VM_maps["Select Cursor Down"] = '<M-C-Down>' " start selecting down
    let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'   " start selecting up
]])

-- nvim-highlight-colors
require("plugin.nvim_highlight_colors")
