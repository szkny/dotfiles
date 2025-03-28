return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "copilot",  -- AIプロバイダーとしてCopilotを使用
    auto_suggestions_provider = "copilot",
    behaviour = {
      auto_suggestions = false,      -- 自動提案を有効化
      auto_set_highlight_group = true,
      auto_set_keymaps = true,     -- キーマップを自動設定
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
    },
    windows = {
      position = "right",          -- サイドバーを右側に表示
      width = 40,                  -- サイドバーの幅
      sidebar_header = {
        align = "center",          -- ヘッダーを中央揃え
        rounded = false,
      },
      ask = {
        floating = true,           -- フローティングウィンドウで表示
        start_insert = true,       -- 自動的にインサートモードに入る
        border = "rounded",        -- 角丸のボーダー
      },
    },
    copilot = {
      model = "claude-3.5-sonnet",  -- 使用するAIモデル
      max_tokens = 4096,            -- 最大トークン数
    },
  },
  build = "make BUILD_FROM_SOURCE=true",  -- ソースからビルド
  dependencies = {
    "nvim-treesitter/nvim-treesitter",    -- 構文解析
    "stevearc/dressing.nvim",             -- UIコンポーネント
    "nvim-lua/plenary.nvim",              -- 共通ユーティリティ
    "MunifTanjim/nui.nvim",               -- UIフレームワーク
    "nvim-tree/nvim-web-devicons",        -- アイコン表示
    "zbirenbaum/copilot.lua",             -- Copilot連携
    'MeanderingProgrammer/render-markdown.nvim',  -- マークダウンレンダリング
    {
      "HakonHarnes/img-clip.nvim",        -- 画像クリップボード機能
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("avante_lib").load()    -- アヴァンテライブラリの読み込み
    require("avante").setup(opts)   -- アヴァンテの設定を適用
    vim.keymap.set("n", "<leader>a", "<cmd>AvanteToggle<CR>")
  end,
}

