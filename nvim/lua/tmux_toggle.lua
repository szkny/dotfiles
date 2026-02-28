-- tmux_toggle.lua

local M = {}

local term_win = 0
local term_buf = nil
local scroll_buf = nil
local switching = false

-- プロジェクトごとに一意なセッション名
local function project_session_name()
  local cwd = vim.fn.getcwd()
  local hash = vim.fn.sha256(cwd):sub(1, 8)
  return "nvim-tmux-toggle-" .. hash
end

-- terminal ウィンドウ装飾
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

-- tmux 起動
function M.open_tmux()
  if switching then return end
  if term_win ~= 0 and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_set_current_win(term_win)
    return
  end

  switching = true

  pcall(function()
    vim.cmd("wincmd t")
    vim.cmd("botright split")
    vim.cmd("resize 20")

    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(term_win, term_buf)
    apply_terminal_window_style(term_win)

    vim.fn.termopen(
      "tmux -L tmux-toggle -f ~/dotfiles/tmux-minimal.conf new-session -A -s "
        .. project_session_name()
    )

    -- ターミナル準備完了後に挿入モードへ
    vim.schedule(function()
      if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_set_current_win(term_win)
        vim.cmd("startinsert")
        vim.cmd.redraw()
      end
      switching = false
    end)
  end)

  -- 万が一 pcall 内で schedule が呼ばれなかった場合への備え
  if not vim.api.nvim_win_is_valid(term_win) then
    switching = false
  end
end

-- tmux 閉じる（Neovim側のみ）
function M.close_tmux()
  if switching then return end
  if term_win ~= 0 and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
  end
  term_win = 0
  term_buf = nil
  scroll_buf = nil
end

function M.toggle_tmux()
  if term_win ~= 0 and vim.api.nvim_win_is_valid(term_win) then
    M.close_tmux()
  else
    M.open_tmux()
  end
end

-- scrollback取得
local function get_scrollback()
  local text = vim.fn.system({
    "tmux",
    "-L", "tmux-toggle",
    "capture-pane",
    "-e",
    "-p",
    "-t", project_session_name(),
    "-S", "-",
    "-E", "-",
  })
  return text and text:gsub("\n$", "")
end

local function is_scrollback_open()
  if not scroll_buf or not vim.api.nvim_buf_is_valid(scroll_buf) then
    return false
  end
  if not term_win or term_win == 0 or not vim.api.nvim_win_is_valid(term_win) then
    return false
  end
  return vim.api.nvim_win_get_buf(term_win) == scroll_buf
end

-- scrollback表示
function M.open_scrollback()
  if switching or is_scrollback_open() then
    return
  end

  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    return
  end

  local text = get_scrollback()
  if not text or text == "" then
    return
  end

  switching = true
  vim.schedule(function()
    pcall(function()
      if not term_win or not vim.api.nvim_win_is_valid(term_win) then
        return
      end

      scroll_buf = vim.api.nvim_create_buf(false, true)
      vim.bo[scroll_buf].bufhidden = "wipe"

      vim.api.nvim_win_set_buf(term_win, scroll_buf)
      apply_terminal_window_style(term_win)

      local chan = vim.api.nvim_open_term(scroll_buf, {})
      vim.api.nvim_chan_send(chan, text)

      -- redraw hack
      vim.bo[scroll_buf].scrollback = 9999
      vim.bo[scroll_buf].scrollback = 9998

      -- 最下部へスクロール
      local height = vim.api.nvim_win_get_height(term_win)
      local lines = vim.api.nvim_buf_line_count(scroll_buf)
      local topline = math.max(1, lines - height + 1)

      vim.api.nvim_win_call(term_win, function()
        vim.fn.winrestview({
          topline = topline,
          lnum = lines,
          col = 0,
        })
      end)
    end)
    switching = false
  end)
end

-- Sidekick式 update ロジック
local function update(opts)
  opts = opts or {}

  if switching or not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    return
  end

  local is_focused = (vim.api.nvim_get_current_win() == term_win)
  if not is_focused then
    return
  end

  local mode = vim.api.nvim_get_mode().mode
  local is_open = is_scrollback_open()

  if is_open then
    -- スクロールバック中：入力モードに入ろうとしたら戻す
    if mode:sub(1,1) == "t" then
      switching = true
      vim.cmd.stopinsert()
      vim.schedule(function()
        pcall(function()
          if term_win and vim.api.nvim_win_is_valid(term_win) then
            vim.api.nvim_win_set_buf(term_win, term_buf)
            scroll_buf = nil
            vim.cmd.startinsert()
            vim.cmd.redraw()
          end
        end)
        switching = false
      end)
    end
  else
    -- 通常：ノーマルモードに入ったらスクロールバックを開く
    if mode == "nt" or opts.open then
      M.open_scrollback()
    end
  end
end

-- autocmd
local group = vim.api.nvim_create_augroup("TmuxToggleScrollback", { clear = true })

-- モード変更をトリガーにする (より高速で正確)
vim.api.nvim_create_autocmd("ModeChanged", {
  group = group,
  pattern = "*:nt",
  callback = function(args)
    if args.buf == term_buf then
      update()
    end
  end,
})

vim.api.nvim_create_autocmd({ "TermEnter", "WinEnter" }, {
  group = group,
  callback = function(args)
    if args.buf ~= term_buf and args.buf ~= scroll_buf then
      return
    end
    update()
  end,
})

-- マウスイベント
local MOUSE_SCROLL_UP = vim.keycode("<ScrollWheelUp>")
local MOUSE_SCROLL_DOWN = vim.keycode("<ScrollWheelDown>")

vim.on_key(function(key, typed)
  key = typed or key
  if not term_win or term_win == 0 or not vim.api.nvim_win_is_valid(term_win) then
    return
  end
  if vim.api.nvim_get_current_win() ~= term_win then
    return
  end

  if (key == MOUSE_SCROLL_UP or key == MOUSE_SCROLL_DOWN) and not is_scrollback_open() then
    update({ open = true })
  end
end)

return M
