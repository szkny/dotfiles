return {
  {
    "neovim/nvim-lspconfig",
    commit = "b3fc67c",
  },
  {
    "microsoft/python-type-stubs",
    cond = false,
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
          "pylsp",
          -- "pyright",
          "tsserver",
          "volar",
          "html",
          "jsonls",
          "yamlls",
          "taplo",
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
          elseif server == "pylsp" then
            opt.settings = {
              pylsp = {
                plugins = {
                  ruff = {
                    enabled = true,
                  },
                  pycodestyle = {
                    enabled = false,
                    ignore = {"E501"},
                    maxLineLength = 1000,
                  },
                  pyflakes = {
                    enabled = false,
                  },
                  mccabe = {
                    enabled = false,
                  },
                },
              },
            }
          elseif server == "pyright" then
            opt.settings = {
              pyright = {
                disableOrganizeImports = true, -- Using Ruff
              },
              python = {
                analysis = {
                  ignore = { "*" }, -- Using Ruff
                  typeCheckingMode = "off", -- Using mypy
                  autoSearchPaths = false,
                  useLibraryCodeForTypes = false,
                  diagnosticMode = "openFilesOnly",
                  stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
                },
              },
            }
          elseif server == "volar" then
            opt.filetypes = { "vue" }
            -- opt.init_options = {
            --   typescript = {
            --     tsdk = "~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib",
            --   },
            -- }
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
      -- vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover)        -- lspsaga
      -- vim.keymap.set("n", "<leader>[", vim.lsp.buf.references)   -- fzf-lua
      -- vim.keymap.set("n", "<leader>]", vim.lsp.buf.definition)   -- lspsaga
      -- vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition)       -- lspsaga
      -- vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)  -- lspsaga
      -- vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next) -- lspsaga
      -- vim.keymap.set("n", "<leader>p", vim.diagnostic.goto_prev) -- lspsaga
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

      -- Python virtual env
      local function auto_activate_venv()
        local venv_path = vim.fn.trim(vim.fn.system("poetry env info -p"))
        if vim.v.shell_error == 0 then
          vim.env.VIRTUAL_ENV = venv_path
          vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH

          -- require("noice").redirect(function()
          --   local notify = require("notify")
          --   notify("activate -> " .. venv_path, "info", { title = "Activate venv" })
          -- end)
        end
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          auto_activate_venv()
        end,
      })
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
        "mypy",
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
          null_ls.builtins.diagnostics.mypy,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              callback = function()
                if vim.bo.filetype ~= "lua" then
                  if formatter_on_save then
                    vim.lsp.buf.format({ async = false })
                  end
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
  {
    "szkny/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    event = "LspAttach",
    opts = {
      ui = {
        border = "rounded",
        devicon = true,
        title = true,
        expand = "⊞",
        collapse = "⊟",
        code_action = "💡",
        actionfix = " ",
      },
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = true,
        sign = true,
        virtual_text = false,
        enable_in_insert = false,
      },
      code_action = {
        num_shortcut = true,
        show_server_name = true,
        extend_gitsigns = false,
        keys = {
          quit = { "<ESC>", "q" },
          exec = "<CR>",
        },
      },
      definition = {
        width = 0.9,
        height = 0.9,
        keys = {
          quit = { "<ESC>", "q" },
        },
      },
      diagnostic = {
        show_code_action = true,
        jump_num_shortcut = true,
        max_width = 0.8,
        max_height = 0.6,
        text_hl_follow = true,
        border_follow = true,
        extend_relatedInformation = true,
        show_layout = "float",
        show_normal_height = 10,
        max_show_width = 0.9,
        max_show_height = 0.6,
        diagnostic_only_current = false,
        keys = {
          exec_action = "o",
          toggle_or_jump = "<CR>",
          quit = { "q", "<ESC>" },
          quit_in_show = { "q", "<ESC>" },
        },
      },
      hover = {
        max_width = 0.5,
        max_height = 0.5,
      },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)
      vim.keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>")
      vim.keymap.set("n", "<leader>n", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      vim.keymap.set("n", "<leader>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>")
      vim.keymap.set("n", "<leader>]", "<cmd>Lspsaga peek_definition<CR>")
      vim.keymap.set("n", "<C-]>", "<cmd>Lspsaga goto_definition<CR>")
    end,
  },
}
