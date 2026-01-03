return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      {
        "rinx/cmp-skkeleton",
        cond = function ()
          return vim.fn.executable("deno") == 1 and vim.fn.has("termux") == 0
        end,
      },
      "f3fora/cmp-spell",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "zbirenbaum/copilot-cmp",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      -- for cmp-spell
      vim.opt.spell = true
      vim.opt.spelllang = { "en_us" }
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl=false, underline=false })
      vim.api.nvim_set_hl(0, "SpellCap", { undercurl=false, underline=false })
      vim.api.nvim_set_hl(0, "SpellRare", { undercurl=false, underline=false })
      vim.api.nvim_set_hl(0, "SpellLocal", { undercurl=false, underline=false })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("lspkind").init({
        mode = "symbol_text",
        preset = "default",
        symbol_map = {
          Copilot = "",
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "",
          Variable = "",
          Class = "",
          Interface = "",
          Module = "",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      })

      local sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
        {
          name = "spell",
          option = {
            keep_all_entries = false,
            enable_in_context = function()
                return true
            end,
            preselect_correct_word = true,
          }
        },
      }
      if vim.fn.executable("deno") == 1 and vim.fn.has("termux") == 0 then
        table.insert(sources, 4, { name = "skkeleton" })
      end
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = sources,
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
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.scroll_docs(-1),
          ["<C-j>"] = cmp.mapping.scroll_docs(1),
          ["<C-l>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            before = function(_, vim_item)
              return vim_item
            end,
          }),
        },
      })

      sources = {
          { name = "buffer" },
      }
      if vim.fn.executable("deno") == 1 and vim.fn.has("termux") == 0 then
        table.insert(sources, { name = "skkeleton" })
      end
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = sources,
      })
      sources = {
          { name = "path" },
          { name = "cmdline" },
      }
      if vim.fn.executable("deno") == 1 and vim.fn.has("termux") == 0 then
        table.insert(sources, { name = "skkeleton" })
      end
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = sources,
      })

      -- Highlight
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = "#9fa3a8" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#9fa3a8" })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "none", fg = "#9fa3a8" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#334f7a", fg = "none", bold = true })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter", "LspAttach" },
    commit = "af15584",
    fix_pairs = true,
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = 'node',
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
    end,
  },
}
