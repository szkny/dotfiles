return {
	"szkny/SplitTerm",
	cmd = "SplitTerm",
	-- keys = {
	--   { "t",          "<CMD>18SplitTerm<CR>i",                              mode = "n" },
	--   { "<leader>gg", "<CMD>SplitTerm lazygit<CR><C-w>J:res 1000<CR>i<CR>", mode = "n" },
	-- },
	event = "VeryLazy",
	config = function()
		vim.api.nvim_set_var("splitterm_auto_close_window", 1)
		vim.cmd([[
        fun! s:trans(...) abort range
            " transコマンド(Google翻訳)を利用してvisual選択中の文字列を日本語変換する関数
            if executable('trans')
                let l:text = ''
                if a:0 == 0
                    let @@ = ''
                    exe 'silent normal gvy'
                    if @@ !=# ''
                        let l:text = join(split(@@,'\n'))
                    else
                        let l:text = expand('<cword>')
                    endif
                else
                    let l:text = join(a:000)
                endif
                let l:text = substitute(l:text, '"', '\\"', 'g')
                let l:text = substitute(l:text, '`', '\\`', 'g')
                let l:text = substitute(l:text, '%', '\\%', 'g')
                if len(l:text) < 900
                    call splitterm#open('trans', '{en=ja}', '"'.l:text.'"', ' ; read -q')
                else
                    echo 'Trans: [error] text too long.'
                endif
            else
                call s:install_trans()
            endif
        endf
        command! -range -nargs=* Trans call s:trans(<f-args>)


        fun! s:transja(...) abort range
            " transコマンド(Google翻訳)を利用してvisual選択中の日本語を英語に変換する関数
            if executable('trans')
                let l:text = ''
                if a:0 == 0
                    let @@ = ''
                    exe 'silent normal gvy'
                    if @@ !=# ''
                        let l:text = join(split(@@,'\n'))
                    else
                        let l:text = expand('<cword>')
                    endif
                else
                    let l:text = join(a:000)
                endif
                let l:text = substitute(l:text, '"', '\\"', 'g')
                let l:text = substitute(l:text, '`', '\\`', 'g')
                let l:text = substitute(l:text, '%', '\\%', 'g')
                if len(l:text) < 900
                    call splitterm#open('trans', '{ja=en}', '"'.l:text.'"', ' ; read -q')
                else
                    echo 'Trans: [error] text too long.'
                endif
            else
                call s:install_trans()
            endif
        endf
        command! -range -nargs=* Transja call s:transja(<f-args>)


        fun! s:install_trans() abort
            if has('mac')
                let l:install_cmd = 'brew install http://www.soimort.org/translate-shell/translate-shell.rb'
            elseif system('uname') ==# "Linux\n"
                let l:exe = '/usr/local/bin/trans'
                let l:install_cmd = 'sudo wget git.io/trans -O '.l:exe
                let l:install_cmd .= ' && sudo chmod +x '.l:exe
            else
                echon 'Trans: [error] trans command not found.'
                return
            endif
            silent call splitterm#open('(echo "trans command not found. installing ..."'
                                     \.' && '.l:install_cmd
                                     \.' && echo " Success !!"'
                                     \.' && echo " you can do \":Trans [WORD]\".")'
                                     \.' ; read -q')
            startinsert
        endf
    ]])

		vim.cmd([[
        command! Fshow exe "SplitTerm zsh -i -c fshow" | startinsert
    ]])

		vim.cmd([[
        fun! s:viu(...) abort
            if executable('viu')
                if a:0 == 0
                    let l:filepath = expand('%:p')
                else
                    let l:filepath = join(a:000)
                endif
                call splitterm#open_width(1000, 'viu', l:filepath, '; read -q')
            else
                echo "command not found: viu"
            endif
        endf
        command! -nargs=* Viu call s:viu(<f-args>)
    ]])

		vim.cmd([[
        fun! s:delta(...) abort
          exe "1000SplitTerm file=$(fzf) && delta -s --paging always "..expand("%").." $file"
          startinsert
        endf
        command! -nargs=* Delta call s:delta(<f-args>)
    ]])

		local kopts = { noremap = true, silent = true }
		vim.keymap.set("v", "<Leader>t", "<CMD>Trans<CR>", kopts)
		vim.keymap.set("n", "<Leader>gf", "<CMD>Fshow<CR>", kopts)
	end,
}
