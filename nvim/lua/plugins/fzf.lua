return {
  "junegunn/fzf.vim",
  dependencies = { "junegunn/fzf" },
  event = "VeryLazy",
  config = function()
    vim.api.nvim_set_var("wildmode", "list:longest,list:full")
    vim.api.nvim_set_var("wildignore", "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__")
    vim.api.nvim_set_var("$FZF_DEFAULT_OPTS", "--reverse --bind ctrl-j:preview-down,ctrl-k:preview-up")
    vim.api.nvim_set_var("fzf_layout", { window = { width = 1.00, height = 0.98, yoffset = 1.00 } })
    vim.api.nvim_set_var("fzf_preview_window", { "right,50%,<70(down,60%)", "ctrl-/" })
    vim.api.nvim_set_var("fzf_colors", {
      fg = { "fg", "FzfNormal" },
      bg = { "bg", "FzfNormal" },
      ["fg+"] = { "fg", "FzfCursorLine" },
      ["bg+"] = { "bg", "FzfCursorLine" },
      ["preview-fg"] = { "fg", "FzfPreview" },
      ["preview-bg"] = { "bg", "FzfPreview" },
    })
    vim.api.nvim_create_user_command(
      "Files",
      "call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)",
      { bang = true, nargs = "?" }
    )
    vim.api.nvim_set_hl(0, "FzfNormal", { fg = "none", bg = "#2a2a2a" })
    vim.api.nvim_set_hl(0, "FzfCursorLine", { fg = "#ffffff", bg = "#5e5e5e" })
    vim.api.nvim_set_hl(0, "FzfPreview", { fg = "none", bg = "none" })
    -- fzf.vim for Silver Searcher
    if vim.fn.executable("ag") then
      vim.api.nvim_set_var("$FZF_DEFAULT_COMMAND", 'ag --hidden --ignore .git -g ""')
      vim.opt.grepprg = "ag --nogroup --nocolor"
    end
    -- fzf.vim for RipGrep
    if vim.fn.executable("rg") then
      vim.api.nvim_set_var("$FZF_DEFAULT_COMMAND", 'rg --files --hidden --follow --glob "!.git/*"')
      vim.opt.grepprg = "rg --vimgrep"
      vim.api.nvim_create_user_command(
        "Find",
        'call fzf#vim#grep(\'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" \'.shellescape(<q-args>).\'| tr -d "\\017"\', 1, <bang>0)',
        { bang = true, nargs = "*" }
      )
      vim.api.nvim_create_user_command(
        "Files",
        "call fzf#run(fzf#wrap(#{source: 'rg --files -uuu -g !.git/ -g !node_modules/ -L', options: '--preview-window \"nohidden,wrap,down,60%\" --preview \"[ -f {} ] && bat --color=always --style=numbers {} || echo {}\"'}))",
        { bang = true, nargs = "?" }
      )
    end

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<C-b>", ":<C-u>Buffers<CR>", opts)
    vim.keymap.set("n", "<C-p>", ":<C-u>Files<CR>", opts)
    vim.keymap.set("n", "<Leader>/", ":<C-u>Lines<CR>", opts)
    vim.keymap.set("n", "<C-f>", ":<C-u>Rg<CR>", opts)
    vim.keymap.set("v", "<C-f>", ":<C-u>call VRgWord()<CR>", opts)
    vim.cmd([[
    fun! VRgWord() abort range
        let @@ = ''
        exe 'silent normal gvy'
        if @@ !=# ''
            let l:text = join(split(@@,'\n'))
            silent exe 'Rg '.l:text
        endif
    endf
    ]])
  end,
}
