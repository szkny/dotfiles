-- *****************************************************************************
--   Autocmd Rules
-- *****************************************************************************

-- for CRLF
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("applycrlffileformat", { clear = true }),
	callback = function()
		vim.cmd([[
      try
        call execute("/\\v\r$")
        edit ++ff=dos
      catch
      endtry
    ]])
	end,
})

-- txt
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "text" },
	group = vim.api.nvim_create_augroup("vimrc_wrapping", { clear = true }),
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.wrapmargin = 2
		vim.opt_local.textwidth = 1000
	end,
})

-- c/cpp
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "c", "cpp" },
	group = vim.api.nvim_create_augroup("vimrc_c_cpp", { clear = true }),
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 0
		vim.opt_local.expandtab = true
	end,
})

-- vimscript/lua
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "vim", "lua" },
	group = vim.api.nvim_create_augroup("vimrc_vimscript_lua", { clear = true }),
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 0
		vim.opt_local.expandtab = true
	end,
})

-- javascript/typescript
local vimrc_js_ts = vim.api.nvim_create_augroup("vimrc_js_ts", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.js", "*.cjs", "*.mjs" },
	group = vimrc_js_ts,
	callback = function()
		vim.bo.filetype = "javascript"
	end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.ts" },
	group = vimrc_js_ts,
	callback = function()
		vim.bo.filetype = "typescript"
	end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "javascript", "typescript", "typescriptreact", "vue", "html", "css", "json", "yaml" },
	group = vimrc_js_ts,
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 0
		vim.opt_local.expandtab = true
	end,
})

-- bun
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "bun.lockb",
	callback = function()
		local path = vim.fn.expand("%:p")
		local output = vim.fn.systemlist("bun " .. path)
		if output then
			vim.api.nvim_buf_set_lines(0, 0, -1, true, output)
		end
		vim.opt_local.filetype = "conf"
		vim.opt_local.readonly = true
		vim.opt_local.modifiable = false
	end,
})

-- python
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "python" },
	group = vim.api.nvim_create_augroup("vimrc_python", { clear = true }),
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 0
		vim.opt_local.expandtab = true
		vim.cmd([[
     if getline(0, '$') == ['']
       call append(0,'#!/usr/bin/env python')
       call append(1,'# -*- coding: utf-8 -*-')
       call append(2,'"""')
       call append(3,'Created on '.GetNow())
       call append(4,'   @file  : '.expand('%:t'))
       call append(5,'   @author: '.$USER)
       call append(6,'   @brief :')
       call append(7,'"""')
     endif
  ]])
	end,
})
