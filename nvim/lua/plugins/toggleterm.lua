return {
  "akinsho/toggleterm.nvim",
  cmd = {
    "ToggleTerm",
    "ToggleTermToggleAll",
  },
  keys = {
    -- { "t", "<CMD>ToggleTerm<CR>", mode = "n" },
    { "<leader>gg", "<CMD>LazyGit<CR>", mode = "n" },
    -- { "<leader>gm", "<CMD>Gemini<CR>", mode = "n" },
  },
  event = "VeryLazy",
  version = "*",
  config = function()
    local FloatBorderHl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
    local function project_session_name()
      local cwd = vim.fn.getcwd()
      local hash = vim.fn.sha256(cwd):sub(1, 8)
      return "toggleterm-" .. hash
    end

    local function project_session()
      local session_name = project_session_name()
      return "tmux -L toggleterm -f ~/dotfiles/tmux-minimal.conf new-session -A -s "
        .. session_name
    end

    local function apply_terminal_window_style(win)
      local opts = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
        statuscolumn = "",
        foldcolumn = "0",
        cursorcolumn = false,
        cursorline = false,
        list = false,
        wrap = false,
        sidescrolloff = 0,
        colorcolumn = "",
      }

      for k, v in pairs(opts) do
        vim.api.nvim_set_option_value(k, v, { win = win })
      end
    end

    local function open_scrollback(term)
      if not term.window
        or not vim.api.nvim_win_is_valid(term.window)
        or not term.bufnr
        or not vim.api.nvim_buf_is_valid(term.bufnr)
      then
        return
      end

      local session = project_session_name()

      local text = vim.fn.system({
        "tmux", "-L", "toggleterm",
        "capture-pane",
        "-p",
        "-t", session,
        "-S", "-",
        "-E", "-",
        "-e",
      })
      text = text:gsub("\n+$", "")

      if not text or text == "" then
        return
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.bo[buf].bufhidden = "hide"
      vim.bo[buf].filetype = "toggleterm_scrollback"

      vim.api.nvim_win_set_buf(term.window, buf)
      apply_terminal_window_style(term.window)

      -- 端末描画
      local chan = vim.api.nvim_open_term(buf, {})
      vim.api.nvim_chan_send(chan, text)

      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_win_is_valid(term.window) then
          local last = vim.api.nvim_buf_line_count(buf)
          vim.api.nvim_win_set_cursor(term.window, { last, 0 })
        end
      end)

      local on_enter_terminal_mode = function ()
        if vim.api.nvim_buf_is_valid(term.bufnr) then
          vim.api.nvim_win_set_buf(0, term.bufnr)
          vim.cmd.startinsert()
        end
      end

      vim.keymap.set("n", "i", function()
        on_enter_terminal_mode()
      end, { buffer = buf })
      vim.keymap.set("n", "a", function()
        on_enter_terminal_mode()
      end, { buffer = buf })
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

      on_open = function(term)
        vim.cmd.startinsert()

        if not term.name:match("^tmux") then
          return
        end

        vim.api.nvim_buf_set_name(term.bufnr, "")

        vim.api.nvim_create_autocmd("TermLeave", {
          buffer = term.bufnr,
          once = true,
          callback = function()
            vim.schedule(function()
              if vim.fn.mode() == "n"
                and term.window
                and vim.api.nvim_win_is_valid(term.window)
              then
                open_scrollback(term)
              end
            end)
          end,
        })
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
