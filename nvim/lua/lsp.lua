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
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
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

-- formatter
local formatter_on_save = true
require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",
    "prettier",
    "black",
  },
  automatic_installation = true,
})
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
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ async = false })
end, {})
vim.api.nvim_create_user_command("FormatterEnable", function()
  formatter_on_save = true
end, {})
vim.api.nvim_create_user_command("FormatterDisable", function()
  formatter_on_save = false
end, {})

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
vim.api.nvim_set_hl(0, "FloatNormal", { bg = "none", fg = "#9fa3a8" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#9fa3a8" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#252525", fg = "#9fa3af" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#334f7a", fg = "none", bold = true })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#334f7a", fg = "none" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#334f7a", fg = "none" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#334f7a", fg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticError", { bg = "none", fg = "#ee3333" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { bg = "none", fg = "#edd000" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { bg = "none", fg = "#5588dd" })

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
      border = "rounded",
    },
    documentation = {
      border = "rounded",
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-l>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  experimental = {
    ghost_text = true,
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})
