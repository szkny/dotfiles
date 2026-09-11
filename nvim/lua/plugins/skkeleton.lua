return {
  "vim-skk/skkeleton",
  dependencies = {
    {
      "vim-denops/denops.vim",
    }
  },
  cond = function ()
    return vim.fn.executable("deno") == 1 and vim.fn.has("termux") == 0
  end,
  event = { "InsertEnter", "CmdlineEnter" },
  keys = {
    { "<C-j>", "<Plug>(skkeleton-enable)", mode = "i" },
    { "<C-j>", "<Plug>(skkeleton-enable)", mode = "c" },
  },
  config = function()
    -- 1. skkeleton の初期化設定
    local function skkeleton_init()
      vim.fn["skkeleton#config"]({
        globalDictionaries = { "~/.skk/SKK-JISYO.L" },
        kanaTable = "rom",
        eggLikeNewline = true,
        showCandidatesCount = 0,
        registerConvertResult = true,
        acceptIllegalResult = true,
        keepState = false,
        immediatelyCancel = false,
      })

      -- カナテーブルの登録
      vim.fn["skkeleton#register_kanatable"]("rom", {
        ["z "] = { "　", "" },
      })

      -- マップされたキーへの追加
      local mapped_keys = {
        "<C-h>", "<F6>", "<F7>", "<F8>", "<F9>", "<F10>", "<C-k>", "<C-q>", "<C-a>"
      }
      for _, key in ipairs(mapped_keys) do
        vim.fn.add(vim.g["skkeleton#mapped_keys"], key)
      end

      -- キーマップの登録
      vim.fn["skkeleton#register_keymap"]("input", "<C-h>", "")
      vim.fn["skkeleton#register_keymap"]("input", "<Up>", "")
      vim.fn["skkeleton#register_keymap"]("input", "<Down>", "")
      vim.fn["skkeleton#register_keymap"]("input", "<F6>",  "katakana")
      vim.fn["skkeleton#register_keymap"]("input", "<F7>",  "katakana")
      vim.fn["skkeleton#register_keymap"]("input", "<F8>",  "hankatakana")
      vim.fn["skkeleton#register_keymap"]("input", "<F9>",  "zenkaku")
      vim.fn["skkeleton#register_keymap"]("input", "<F10>", "disable")
      vim.fn["skkeleton#register_keymap"]("input", "<C-k>", "katakana")
      vim.fn["skkeleton#register_keymap"]("input", "<C-q>", "hankatakana")
      vim.fn["skkeleton#register_keymap"]("input", "<C-a>", "zenkaku")
    end

    -- 2. Autocmd の登録
    local group_pre = vim.api.nvim_create_augroup("skkeleton-initialize-pre", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group_pre,
      pattern = "skkeleton-initialize-pre",
      callback = skkeleton_init,
    })

    local group_changed = vim.api.nvim_create_augroup("skkeleton-mode-changed", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group_changed,
      pattern = "skkeleton-mode-changed",
      callback = function()
        vim.cmd("redrawstatus")
      end,
    })

    local group_handled = vim.api.nvim_create_augroup("skkeleton-handled", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group_handled,
      pattern = "skkeleton-handled",
      callback = function()
        require("cmp").complete()
      end,
    })
  end,
}
