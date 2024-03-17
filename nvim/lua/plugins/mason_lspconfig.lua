return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"folke/neodev.nvim",
		"williamboman/mason.nvim",
	},
	lazy = false,
	-- event = "VeryLazy",
	config = function()
		-- To instead override globally
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		-- 1. LSP Sever management
		require("neodev").setup()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"vimls",
				"jedi_language_server",
				"tsserver",
				"volar",
				"html",
				"jsonls",
				"yamlls",
				"bashls",
				"terraformls",
			},
			automatic_installation = true,
		})
		require("mason-lspconfig").setup_handlers({
			function(server)
				local opt = {
					capabilities = vim.lsp.protocol.make_client_capabilities(),
					on_attach = function(client, bufnr)
						if client.supports_method("textDocument/documentHighlight") then
							vim.api.nvim_create_autocmd(
								{ "CursorHold", "CursorHoldI" },
								{ callback = vim.lsp.buf.document_highlight, buffer = bufnr }
							)
							vim.api.nvim_create_autocmd(
								{ "CursorMoved", "CursorMovedI" },
								{ callback = vim.lsp.buf.clear_references, buffer = bufnr }
							)
						end
						-- vim.api.nvim_create_autocmd({ "CursorHold" }, { callback = vim.diagnostic.open_float, buffer = bufnr })
					end,
					handlers = {
						["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
						["textDocument/signatureHelp"] = vim.lsp.with(
							vim.lsp.handlers.signature_help,
							{ border = "rounded" }
						),
					},
				}
				if server == "lua_ls" then
					opt.settings = {
						Lua = {
							diagnostics = { enable = true, globals = { "vim" } },
							completion = {
								callSnippet = "Replace",
							},
						},
					}
				end
				require("lspconfig")[server].setup(opt)
			end,
		})

		-- diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- 2. build-in LSP function
		-- keyboard shortcut
		vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>")
		vim.keymap.set("n", "<leader>[", "<cmd>lua vim.lsp.buf.references()<CR>")
		vim.keymap.set("n", "<leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>")
		vim.keymap.set("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
		vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		vim.keymap.set("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next()<CR>")
		vim.keymap.set("n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
		-- Command
		vim.api.nvim_create_user_command("LspCodeAction", function()
			vim.lsp.buf.code_action()
		end, { bang = true, nargs = "?" })
		-- LSP handlers
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			border = "rounded",
			update_in_insert = false,
			signs = true,
			underline = true,
			virtual_text = {
				prefix = "",
				format = function(diagnostic)
					return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
				end,
			},
		})

		-- Highlight
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = "#9fa3a8" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#9fa3a8" })
		vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#334f7a", fg = "none" })
		vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#334f7a", fg = "none" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#334f7a", fg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticError", { bg = "none", fg = "#ee3333" })
		vim.api.nvim_set_hl(0, "DiagnosticWarn", { bg = "none", fg = "#edd000" })
		vim.api.nvim_set_hl(0, "DiagnosticHint", { bg = "none", fg = "#5588dd" })
	end,
}
