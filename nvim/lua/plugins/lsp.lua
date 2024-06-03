return {
	{
		"neovim/nvim-lspconfig",
		commit = "b3fc67c",
	},
	{
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

			---@diagnostic disable-next-line: duplicate-set-field
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded"
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- 1. LSP Sever management
			require("neodev").setup()
			require("mason").setup({
				ui = {
					border = "rounded",
					width = 0.9,
					height = 0.9,
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vimls",
					"ruff_lsp",
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
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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
			-- vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none", fg = "#ee3333" })
			-- vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none", fg = "#edd000" })
			-- vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none", fg = "#5588dd" })

			local DgsErrorHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignError" })
			local DgsWarnHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignWarn" })
			local DgsHintHl = vim.api.nvim_get_hl(0, { name = "DiagnosticSignHint" })
			vim.api.nvim_set_hl(0, "DiagnosticError", { bg = "none", fg = DgsErrorHl.fg })
			vim.api.nvim_set_hl(0, "DiagnosticWarn", { bg = "none", fg = DgsWarnHl.fg })
			vim.api.nvim_set_hl(0, "DiagnosticHint", { bg = "none", fg = DgsHintHl.fg })

			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = DgsErrorHl.fg })
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = DgsWarnHl.fg })
			vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = DgsHintHl.fg })
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
			"williamboman/mason.nvim",
		},
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"black",
			},
			automatic_installation = true,
			methods = {
				diagnostics = true,
				formatting = true,
				code_actions = true,
				completion = true,
				hover = true,
			},
		},
		config = function(_, opts)
			local formatter_on_save = true
			require("mason-null-ls").setup(opts)
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.black,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							callback = function()
								if formatter_on_save then
									vim.lsp.buf.format({ async = false })
								end
							end,
							buffer = bufnr,
						})
					end
				end,
			})

			-- User command
			vim.api.nvim_create_user_command("Format", function()
				vim.lsp.buf.format({ async = false })
			end, {})
			vim.api.nvim_create_user_command("FormatterEnable", function()
				formatter_on_save = true
			end, {})
			vim.api.nvim_create_user_command("FormatterDisable", function()
				formatter_on_save = false
			end, {})
		end,
	},
}
