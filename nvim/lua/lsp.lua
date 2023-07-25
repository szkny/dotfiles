-- *****************************************************************************
--   Coc.nvim Configuration
-- *****************************************************************************
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.pumheight = 15

-- Disable file with size > 1MB
vim.cmd([[
    au BufAdd * if getfsize(expand('<afile>')) > 1024*1024 |
                   \ let b:coc_enabled=0 |
                   \ endif
]])

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.opt.signcolumn = "yes"

-- for coc-fzf
vim.api.nvim_set_var('coc_fzf_preview', 'right,50%,<70(down,60%)')
vim.api.nvim_set_var('coc_fzf_preview_toggle_key', 'ctrl-/')
vim.api.nvim_set_var('coc_fzf_opts', { '--layout=reverse' })

-- Extentions list
vim.api.nvim_set_var('coc_global_extensions', {
    'coc-actions',
    'coc-diagnostic',
    'coc-dictionary',
    'coc-lists',
    'coc-pairs',
    'coc-snippets',
    'coc-vimlsp',
    'coc-lua',
    'coc-prettier',
    'coc-tsserver',
    'coc-deno',
    'coc-json',
    'coc-yaml',
    'coc-html',
    'coc-css',
    'coc-vetur',
    'coc-jedi',
    'coc-sh',
    'coc-rust-analyzer',
    'coc-clangd',
    '@yaegassy/coc-ansible',
})
    -- '@yaegassy/coc-volar',
    -- 'coc-eslint',

-- for ansible yaml
vim.cmd([[
    let g:coc_filetype_map = { 'yaml.ansible': 'ansible' }
]])

vim.cmd([[
    fun! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endf

    fun! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      " else
      "   call feedkeys('K', 'in')
      endif
    endf
]])

-- Highlight the symbol and its references when holding the cursor
vim.cmd([[
    au CursorHold * silent call CocActionAsync('highlight')

    hi CocErrorSign           gui=none guifg=#ff0000
    hi CocWarningSign         gui=none guifg=#dddd00
    hi CocInfoSign            gui=none guifg=#ffffff
    hi CocHintSign            gui=none guifg=#5599dd
    hi CocErrorVirtualText    gui=bold guifg=#ff0000
    hi CocWarningVirtualText  gui=bold guifg=#dddd00
    hi CocInfoVirtualText     gui=bold guifg=#ffffff
    hi CocHintVirtualText     gui=bold guifg=#5599dd
    hi CocErrorHighlight      gui=bold,undercurl guifg=none
    hi CocWarningHighlight    gui=bold,undercurl guifg=none
    hi CocInfoHighlight       gui=bold,undercurl guifg=none
    hi CocHintHighlight       gui=bold,undercurl guifg=none
    hi CocErrorFloat          gui=none guifg=#ff0000
    hi CocHintFloat           gui=none guifg=#5599dd
    hi CocNotificationError   gui=none guibg=#ff0000
    hi CocFadeOut             gui=bold guifg=#888888
    hi CocDeprecatedHighlight gui=bold guifg=#66aa66
    hi CocFloating            gui=none guifg=#dddddd guibg=#383838
    hi CocMenuSel             gui=none               guibg=#226688
    hi CocPumSearch           gui=bold guifg=#44aabb
    hi CocPumDetail           gui=none
    hi CocFloatSbar           gui=bold guifg=none    guibg=#383838
    hi CocFloatThumb          gui=bold guifg=none    guibg=#cccccc
]])

-- Add `:Format` command to format current buffer
vim.cmd([[
    command! -nargs=0 Format :call CocActionAsync('format')
]])

-- Add `:Fold` command to fold current buffer
vim.cmd([[
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
]])

-- Add `:OR` command for organize imports of the current buffer
vim.cmd([[
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
]])

-- Mappings
vim.cmd([[
    fun CocMapping() abort
        let g:mapleader = "\<Space>"
        ino <silent><expr> <C-n>  coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
        ino <silent><expr> <C-p>  coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
        ino <silent><expr> <DOWN> coc#pum#visible() ? coc#pum#next(1) : "\<DOWN>"
        ino <silent><expr> <UP>   coc#pum#visible() ? coc#pum#prev(1) : "\<UP>"
        ino <silent><expr> <TAB>
              \ coc#pum#visible() ? coc#pum#next(1) :
              \ CheckBackspace() ? "\<Tab>" : coc#refresh()
        ino <silent><expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
        ino <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        ino <silent> <C-e>  <Space><BS>

        " " Use <c-space> to trigger completion
        " if has('nvim')
        "   inoremap <silent><expr> <c-space> coc#refresh()
        " else
        "   inoremap <silent><expr> <c-@> coc#refresh()
        " endif

        " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
        nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
        nmap <silent> <leader>n <Plug>(coc-diagnostic-next)

        " GoTo code navigation
        nmap <silent> <leader>] <Plug>(coc-definition)
        " nmap <silent> gy <Plug>(coc-type-definition)
        " nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> <leader>[ <Plug>(coc-references)

        " Use K to show documentation in preview window
        nnoremap <silent> <leader>k :call ShowDocumentation()<CR>

        " " Symbol renaming
        " nmap <leader>rn <Plug>(coc-rename)
        "
        " " Formatting selected code
        " xmap <leader>f  <Plug>(coc-format-selected)
        " nmap <leader>f  <Plug>(coc-format-selected)
        "
        " augroup mygroup
        "   autocmd!
        "   " Setup formatexpr specified filetype(s)
        "   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        "   " Update signature help on jump placeholder
        "   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        " augroup end
        "
        " " Applying code actions to the selected code block
        " " Example: `<leader>aap` for current paragraph
        " xmap <leader>a  <Plug>(coc-codeaction-selected)
        " nmap <leader>a  <Plug>(coc-codeaction-selected)
        "
        " " Remap keys for applying code actions at the cursor position
        " nmap <leader>ac  <Plug>(coc-codeaction-cursor)
        " " Remap keys for apply code actions affect whole buffer
        " nmap <leader>as  <Plug>(coc-codeaction-source)
        " " Apply the most preferred quickfix action to fix diagnostic on the current line
        " nmap <leader>qf  <Plug>(coc-fix-current)
        "
        " " Remap keys for applying refactor code actions
        " nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
        " xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
        " nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
        "
        " " Run the Code Lens action on the current line
        " nmap <leader>cl  <Plug>(coc-codelens-action)
        "
        " " Map function and class text objects
        " " NOTE: Requires 'textDocument.documentSymbol' support from the language server
        " xmap if <Plug>(coc-funcobj-i)
        " omap if <Plug>(coc-funcobj-i)
        " xmap af <Plug>(coc-funcobj-a)
        " omap af <Plug>(coc-funcobj-a)
        " xmap ic <Plug>(coc-classobj-i)
        " omap ic <Plug>(coc-classobj-i)
        " xmap ac <Plug>(coc-classobj-a)
        " omap ac <Plug>(coc-classobj-a)

        " " Remap <C-f> and <C-b> to scroll float windows/popups
        " if has('nvim-0.4.0') || has('patch-8.2.0750')
        "   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        "   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        "   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        "   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        "   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        "   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        " endif

        " " Use CTRL-S for selections ranges
        " " Requires 'textDocument/selectionRange' support of language server
        " nmap <silent> <C-s> <Plug>(coc-range-select)
        " xmap <silent> <C-s> <Plug>(coc-range-select)

        " " Mappings for CoCList
        " " Show all diagnostics
        " nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
        " " Manage extensions
        " nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
        " " Show commands
        " nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
        " " Find symbol of current document
        " nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
        " " Search workspace symbols
        " nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
        " " Do default action for next item
        " nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
        " " Do default action for previous item
        " nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
        " " Resume latest coc list
        " nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

        " Mappings for CocFzfList
        " nno <silent><nowait> <leader>c :<C-u>CocFzfList<CR>
        " nno <silent><nowait> <leader>a :<C-u>CocFzfList diagnostics<CR>
        nno <silent><nowait> <leader>a <CMD>call Cocfzflist_wrap("diagnostics")<CR>
        nno <silent><nowait> <leader>c <CMD>call Cocfzflist_wrap()<CR>
        fun! Cocfzflist_wrap(...) abort
            try
                exe 'CocFzfList '.join(a:000)
            catch
            endtry
        endf
    endf

    call CocMapping()
]])
