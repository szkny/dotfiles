return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  lazy = false,
  commit = "c2bdf8c",
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>gm",
      function() require("sidekick.cli").toggle({ name = "gemini", focus = true }) end,
      desc = "Sidekick Toggle Gemini",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{this}\n{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      desc = "Sidekick Select Prompt",
    },
  },
  opts = {
    nes = {
      enabled = function(buf)
        return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false
      end,
      debounce = 100,
      trigger = {
        events = { "ModeChanged i:n", "TextChanged", "User SidekickNesDone" },
      },
      clear = {
        events = { "TextChangedI", "InsertEnter" },
        esc = true,
      },
    },
    cli = {
      watch = true, -- notify Neovim of file changes done by AI CLI tools
      win = {
        layout = "right",
        -- layout = "float",
        split = {
          width = 80,
          height = 20,
        },
        float = {
          width = 0.9,
          height = 0.9,
        },
      },
      prompts = {
        changes         = "変更点をレビューしてもらえますか？",
        diagnostics     = "{file}にある診断エラーを修正するのを手伝ってもらえますか？\n{diagnostics}",
        diagnostics_all = "これらの診断エラーを修正するのを手伝ってもらえますか？\n{diagnostics_all}",
        document        = "{function|line}にドキュメントを追加してください",
        explain         = "{this}を説明してください",
        fix             = "{this}を修正してもらえますか？",
        optimize        = "{this}をどのように最適化できますか？",
        review          = "{file}に問題や改善点がないかレビューしてもらえますか？",
        tests           = "{this}のテストを書いてもらえますか？",
        buffers         = "{buffers}",
        file            = "{file}",
        line            = "{line}",
        position        = "{position}",
        quickfix        = "{quickfix}",
        selection       = "{selection}",
        ["function"]    = "{function}",
        class           = "{class}",
      },
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },
  config = function(_, opts)
    require("sidekick").setup(opts)
  end,
}
