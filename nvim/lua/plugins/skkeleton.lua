if vim.fn.has("termux") then
  return {}
else
  return {
    "vim-skk/skkeleton",
    dependencies = {
      {
        "vim-denops/denops.vim",
        commit = "a77c1fa5"
      }
    },
    cond = function ()
      return vim.fn.executable("deno") == 1
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    keys = {
      { "<C-j>", "<Plug>(skkeleton-enable)", mode = "i" },
      { "<C-j>", "<Plug>(skkeleton-enable)", mode = "c" },
    },
    commit = "ce5968d",
    init = function()
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
    end,
  }
end
