-- 1. LSP Sever management
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "jedi_language_server",
    "tsserver",
    "terraformls",
    "volar",
    "jsonls",
    "yamlls",
    "bashls",
    "vimls",
  },
  automatic_installation = true,
})
require("mason-lspconfig").setup_handlers({ function(server)
  local opt = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(client)
      if client.supports_method "textDocument/documentHighlight" then
        vim.cmd([[
          aug lsp_document_highlight
            au!
            au CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            au CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
          aug END
        ]])
      end
      vim.cmd([[
        aug lsp_show_diagnostic
          au!
          au CursorHold <buffer> lua vim.diagnostic.open_float()
        aug END
      ]])
    end,
    handlers = {
      ["textDocument/hover"] =  vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      ),
      ["textDocument/signatureHelp"] =  vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      ),
    },
  }
  if server == "lua_ls" then
    opt.settings = {
      Lua = {
        diagnostics = { enable = true, globals = { "vim" } },
      }
    }
  end
  require("lspconfig")[server].setup(opt)
end })

-- diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<leader>[", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<leader>]", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<C-]>",     "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
)
-- Highlight
vim.api.nvim_set_hl(0, "FloatNormal",       { bg="none",    fg="#9fa3a8" })
vim.api.nvim_set_hl(0, "FloatBorder",       { bg="none",    fg="#9fa3a8" })
vim.api.nvim_set_hl(0, "Pmenu",             { bg="#252525", fg="#9fa3af" })
vim.api.nvim_set_hl(0, "PmenuSel",          { bg="#334f7a", fg="none"    })
vim.api.nvim_set_hl(0, "LspReferenceText",  { bg="#334f7a", fg="none"    })
vim.api.nvim_set_hl(0, "LspReferenceRead",  { bg="#334f7a", fg="none"    })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg="#334f7a", fg="none"    })
vim.api.nvim_set_hl(0, "DiagnosticError",   { bg="none",    fg="#ff0000" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",    { bg="none",    fg="#edd000" })
vim.api.nvim_set_hl(0, "DiagnosticHint",    { bg="none",    fg="#5588dd" })

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "skkeleton" },
  },
  window = {
    completion = {
      border = "rounded"
    },
    documentation = {
      border = "rounded"
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"]  = cmp.mapping.select_prev_item(),
    ["<C-n>"]  = cmp.mapping.select_next_item(),
    ["<Up>"]   = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-l>"]  = cmp.mapping.complete(),
    ["<C-e>"]  = cmp.mapping.abort(),
    ["<CR>"]   = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

cmp.setup.cmdline({"/", "?"}, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

