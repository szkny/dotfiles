return {
  "akinsho/toggleterm.nvim",
  cmd = {
    "ToggleTerm",
    "ToggleTermToggleAll",
  },
  keys = {
    { "t", "<CMD>ToggleTerm<CR>", mode = "n" },
    { "<leader>gg", "<CMD>LazyGit<CR>", mode = "n" },
    -- { "<leader>gm", "<CMD>Gemini<CR>", mode = "n" },
  },
  event = "VeryLazy",
  version = "*",
  config = function()
    local FloatBorderHl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
    local function project_session()
      local cwd = vim.fn.getcwd()
      local hash = vim.fn.sha256(cwd):sub(1, 8)
      local session_name = "toggleterm-" .. hash
      return "tmux -L toggleterm -f ~/dotfiles/tmux-minimal.conf new-session -A -s " .. session_name
    end
    require("toggleterm").setup({
      -- direction = "float",
      direction = "horizontal",
      size = 20,
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = {
          guifg = FloatBorderHl.fg,
          guibg = "none",
        },
      },
      on_open = function()
        vim.cmd([[startinsert]])
      end,
      close_on_exit = false,
      shell = project_session(),
    })
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
    })
    local gemini = Terminal:new({
      cmd = "gemini",
      hidden = true,
      direction = "float",
    })
    vim.api.nvim_create_user_command("LazyGit", function()
      lazygit:toggle()
    end, {})
    vim.api.nvim_create_user_command("Gemini", function()
      gemini:toggle()
    end, {})
    vim.api.nvim_create_user_command("Viu", function(opts)
      local file = opts.fargs[1]
      if file then
        Terminal:new({
          cmd = "viu -t " .. file .. "; read -q",
          hidden = true,
          direction = "float",
        }):open()
      end
    end, { nargs = 1 })
  end,
}
