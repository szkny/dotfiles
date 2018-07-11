scriptencoding utf-8
"*****************************************************************************
"" Plugin Configuration
"*****************************************************************************

"" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000
highlight Pmenu ctermbg=8 guibg=#000000
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6


"" neosnippet
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/neosnippet-snippets/neosnippets'
if finddir('dotfiles/nvim/snippets', $HOME) !=# ''
    let g:neosnippet#snippets_directory.=', ~/dotfiles/nvim/snippets'
endif


"" NERDTree
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 25


"" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_width = 30


"" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#completions_enabled = 1
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#show_call_signatures = "0"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#goto_command = '<Leader>d'
" let g:jedi#goto_assignments_command = '<leader>g'
" let g:jedi#goto_definitions_command = ''

"" PyFlake
let g:PyFlakeOnWrite = 0
let g:PyFlakeCheckers = 'mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10


"" ale (Asynchronous Lint Engine)
let g:ale_sign_column_always = 0
let g:ale_change_sign_column_color = 0
let g:ale_completion_enabled = 1
" let g:ale_sign_error = 'Ｘ'
" let g:ale_sign_warning = '⚠'
let g:ale_sign_error = 'E-'
let g:ale_sign_warning = 'W-'
let g:ale_set_highlights = 1
let g:ale_c_clang_executable = 'clang++'
let g:ale_c_clang_options = '-std=c++11 -Wall'
let g:ale_c_clangtidy_checks = ['*']
let g:ale_c_clangtidy_executable = 'clang-tidy'
let g:ale_c_clangtidy_options = '-I../include'
let g:ale_c_cppcheck_executable = 'cppcheck'
let g:ale_c_cppcheck_options = '--enable=style'
let g:ale_c_gcc_executable = 'g++'
let g:ale_c_gcc_options = '-std=c++11 -Wall'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
let g:ale_statusline_format = [g:ale_sign_error.' %d', g:ale_sign_warning.' %d', '']
let g:ale_echo_msg_error_str = g:ale_sign_error
let g:ale_echo_msg_warning_str = g:ale_sign_warning
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
hi ALEErrorSign   guifg=#000000 guibg=#a01010
hi ALEWarningSign guifg=#000000 guibg=#808010

"" indent_guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['', 'help', 'nerdtree']
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#113344 ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#223344 ctermbg=darkgray


"" indentLine
let g:indentLine_enabled = 0
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1


"" vim-airline
let g:airline_theme = 'kalisi'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
" let g:airline_section_c = '%t'
let g:airline_section_b = '%{airline#extensions#ale#get_error()}'
let g:airline_section_c = '%{airline#extensions#ale#get_warning()}'
let g:airline_section_x = '%{&filetype}'
if &fileformat ==# 'unix'
    let g:airline_section_y = '%{&fileencodings}, LN'
else
    let g:airline_section_y = '%{&fileencodings}, %{&fileformat}'
endif
let g:airline_section_z = 'LOW:%3l/%L'
let g:airline#extensions#ale#error_symbol = g:ale_sign_error.' '
let g:airline#extensions#ale#warning_symbol = g:ale_sign_warning. ' '
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#whitespace#enabled = 1

"" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let g:python_highlight_all = 1


"" grep.vim
" nnoremap <silent> <leader>f :Rgrep<CR>
let g:Grep_Default_Options = '-IR'
let g:Grep_Skip_Files = '*.log *.db'
let g:Grep_Skip_Dirs = '.git node_modules'


"" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '


"" vim-nerdtree-syntax-highlight
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb


"" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

"" ranger.vim
let g:NERDTreeHijackNetrw = 0  " add this line if you use NERDTree
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory


"" previm.vim
fun! s:PrevimOpenCmd()
    let l:cmd = ''
    if has('mac')
        let l:cmd = 'open -a Google\ Chrome'
    elseif system('uname') ==# "Linux\n"
        let l:cmd = 'chrome'
    endif
    return l:cmd
endf
let g:previm_open_cmd = s:PrevimOpenCmd()
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END


if has('mac')
    "" dir-icons
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
    let g:DevIconsEnableFoldersOpenClose = 1
    let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
    let g:DevIconsDefaultFolderOpenSymbol = ''
    "" file-icons
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
    "" installed-font
    set guifont=Ricty\ Discord\ Regular\ Nerd\ Font\ Plus\ Font\ Awesome\ Plus\ Octicons\ Plus\ Pomicons\ Plus\ Font\ Linux:h14
endif
