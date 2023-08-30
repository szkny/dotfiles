-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(client, bufnr)
      if client.supports_method "textDocument/documentHighlight" then
        vim.cmd([[
          aug lsp_document_highlight
            au!
            au CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            au CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
          aug END
        ]])
      end
      require('nvim-navic').attach(client, bufnr)
      vim.cmd([[
        aug lsp_show_diagnostic
          au!
          au CursorHold <buffer> lua vim.diagnostic.open_float()
        aug END
      ]])
    end,
  }
  if server == 'lua_ls' then
    opt.settings = {
      Lua = {
        diagnostics = { enable = true, globals = { 'vim' } },
      }
    }
  end
  require('lspconfig')[server].setup(opt)
end })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>[', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<leader>]', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<C-]>',     '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
)
-- Highlight
vim.cmd([[
hi DiagnosticError   guifg=#ff0000
hi DiagnosticWarn    guifg=#edd000
hi DiagnosticInfo    guifg=#ffffff
hi DiagnosticHint    guifg=#5588dd
hi LspReferenceText  guibg=#334f7a
hi LspReferenceRead  guibg=#334f7a
hi LspReferenceWrite guibg=#334f7a
]])

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
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})
