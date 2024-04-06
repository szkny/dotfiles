return {
	"jay-babu/mason-null-ls.nvim",
	dependencies = { "nvimtools/none-ls.nvim", "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	opts = {
		ensure_installed = {
			"stylua",
			"prettier",
			"black",
		},
		automatic_installation = true,
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
								vim.cmd("silent normal zz")
							end
						end,
						buffer = bufnr,
					})
				end
			end,
		})
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
}
