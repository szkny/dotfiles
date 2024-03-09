vim.g.vista_no_mappings = 0
vim.g.vista_echo_cursor = 0
vim.g.vista_echo_cursor_strategy = "floating_win"
vim.g.vista_blink = { 3, 200 }
vim.g.vista_top_level_blink = { 3, 200 }
vim.g.vista_highlight_whole_line = 1
vim.g.vista_update_on_text_changed = 1
vim.g.vista_sidebar_width = 25
vim.g.vista_icon_indent = { "└ ", "│ " }
vim.g["vista#renderer#enable_icon"] = 1
vim.g.vista_fzf_preview = { "right,50%,<70(down,60%)" }
vim.g.vista_keep_fzf_colors = 1
vim.g.vista_fzf_opt = { "--bind=ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up" }
vim.g.vista_default_executive = "nvim_lsp"
vim.api.nvim_set_hl(0, "VistaFloat", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "VistaLineNr", { fg = "#777777", bg = "none" })
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
