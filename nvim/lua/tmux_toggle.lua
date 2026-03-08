-- tmux_toggle.lua

local M = {}

local term_win = 0
local term_buf = nil
local scroll_buf = nil
local scroll_chan = nil
local switching = false
local refresh_timer = nil

-- プロジェクトごとに一意なセッション名
local function get_session_name()
  local cwd = vim.fn.getcwd()
  return "nvim-tmux-toggle-" .. vim.fn.sha256(cwd):sub(1, 8)
end

-- ウィンドウの装飾設定
local function apply_style(win)
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
    vim.cmd("botright split")
    vim.cmd("resize 20")

    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(term_win, term_buf)
    apply_style(term_win)

    vim.fn.termopen(
      string.format("tmux -L tmux-toggle -f ~/dotfiles/tmux-minimal.conf new-session -A -s %s", get_session_name())
    )

    vim.schedule(function()
      if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_set_current_win(term_win)
        vim.cmd("startinsert")
        vim.cmd.redraw()
      end
      switching = false
    end)
  end)
end

-- 完全に閉じる
function M.close_tmux()
  if refresh_timer then
    refresh_timer:stop()
    refresh_timer:close()
    refresh_timer = nil
  end
  if term_win ~= 0 and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
  end
  term_win, term_buf, scroll_buf, scroll_chan = 0, nil, nil, nil
end

function M.toggle_tmux()
  if term_win ~= 0 and vim.api.nvim_win_is_valid(term_win) then
    M.close_tmux()
  else
    M.open_tmux()
  end
end

-- ユーティリティ: tmux 情報取得
local function get_tmux_info(cb)
  vim.system({
    "tmux", "-L", "tmux-toggle", "display-message", "-p", "#{history_size},#{pane_height}"
  }, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 and obj.stdout then
        local h, p = obj.stdout:match("(%d+),(%d+)")
        if h and p then cb(tonumber(h), tonumber(p)) return end
      end
      cb(nil)
    end)
  end)
end

-- ユーティリティ: tmux 差分取得
local function get_incremental(start_idx, end_idx, cb)
  vim.system({
    "tmux", "-L", "tmux-toggle", "capture-pane", "-e", "-p",
    "-t", get_session_name(), "-S", tostring(start_idx), "-E", tostring(end_idx),
  }, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then cb(obj.stdout) else cb(nil) end
    end)
  end)
end

local function is_scrollback_active()
  return scroll_buf and vim.api.nvim_buf_is_valid(scroll_buf) and
         term_win and vim.api.nvim_win_is_valid(term_win) and
         vim.api.nvim_win_get_buf(term_win) == scroll_buf
end

-- リアルタイム更新タイマー
local function start_refresh_timer()
  if refresh_timer then return end
  refresh_timer = vim.uv.new_timer()
  refresh_timer:start(200, 200, function()
    vim.schedule(function()
      if not is_scrollback_active() or switching then return end

      get_tmux_info(function(h, p)
        if not h or not scroll_buf or not vim.api.nvim_buf_is_valid(scroll_buf) then return end

        local current_total = h + p
        local last_total = vim.b[scroll_buf].last_total or 0
        local last_content = vim.b[scroll_buf].last_content or ""
        local diff = current_total - last_total

        local view = vim.api.nvim_win_call(term_win, vim.fn.winsaveview)
        local line_count = vim.api.nvim_buf_line_count(scroll_buf)
        local is_at_end = (view.lnum >= line_count - 2)

        if diff > 0 then
          switching = true
          get_incremental(p - diff, p - 1, function(text)
            if text and scroll_chan then
              vim.api.nvim_chan_send(scroll_chan, text)
              vim.b[scroll_buf].last_total = current_total
              vim.b[scroll_buf].last_content = text:match("([^\n]*)\n?$") or ""
            end
            if is_at_end then
              pcall(vim.api.nvim_win_set_cursor, term_win, { vim.api.nvim_buf_line_count(scroll_buf), 0 })
            else
              vim.api.nvim_win_call(term_win, function() vim.fn.winrestview(view) end)
            end
            switching = false
          end)
        else
          get_incremental(p - 1, p - 1, function(text)
            if not text then return end
            local new_last = text:gsub("\n$", "")
            if new_last ~= last_content and scroll_chan then
              -- \x1b[1A: Up, \r: CR, \x1b[2K: Clear Line
              vim.api.nvim_chan_send(scroll_chan, "\x1b[1A\r\x1b[2K" .. text)
              vim.b[scroll_buf].last_content = new_last
              if is_at_end then
                pcall(vim.api.nvim_win_set_cursor, term_win, { vim.api.nvim_buf_line_count(scroll_buf), 0 })
              else
                vim.api.nvim_win_call(term_win, function() vim.fn.winrestview(view) end)
              end
            end
          end)
        end
      end)
    end)
  end)
end

-- scrollback 表示への切り替え
function M.open_scrollback()
  if switching or is_scrollback_active() then return end
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then return end

  local win_row, win_col = vim.fn.winline(), vim.fn.virtcol('.')

  switching = true
  get_tmux_info(function(h, p)
    if not h then switching = false; return end

    local start_idx = math.max(-h, -3000)
    get_incremental(start_idx, p - 1, function(text)
      switching = false
      if not text or not term_win or not vim.api.nvim_win_is_valid(term_win) then return end

      -- モードが変更されていたり、別のバッファに切り替わっていたら中止
      if vim.api.nvim_get_mode().mode ~= "nt" or vim.api.nvim_win_get_buf(term_win) ~= term_buf then
        return
      end

      scroll_buf = vim.api.nvim_create_buf(false, true)
      vim.bo[scroll_buf].bufhidden = "wipe"
      vim.api.nvim_set_option_value("scrollback", 100000, { buf = scroll_buf })

      -- バッファ変数の初期化
      vim.b[scroll_buf].last_total = h + p
      vim.b[scroll_buf].last_content = text:match("([^\n]*)\n?$") or ""

      vim.api.nvim_win_set_buf(term_win, scroll_buf)
      apply_style(term_win)

      scroll_chan = vim.api.nvim_open_term(scroll_buf, {})
      vim.api.nvim_chan_send(scroll_chan, text)

      -- ビューの同期
      vim.defer_fn(function()
        if not is_scrollback_active() then return end
        vim.api.nvim_win_call(term_win, function()
          local line_count = vim.api.nvim_buf_line_count(scroll_buf)
          local target_line = math.max(1, line_count - p + win_row)
          local topline = math.max(1, line_count - p + 1)
          vim.fn.winrestview({ topline = topline, lnum = target_line, col = win_col })
        end)
      end, 20)

      start_refresh_timer()
    end)
  end)
end

-- 状態更新ロジック (ModeChanged から呼ばれる)
local function update_mode(opts)
  opts = opts or {}
  if switching or not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then return end
  if vim.api.nvim_get_current_win() ~= term_win then return end

  local mode = vim.api.nvim_get_mode().mode
  local active = is_scrollback_active()

  if active then
    if mode:sub(1,1) == "t" then
      if refresh_timer then
        refresh_timer:stop()
        refresh_timer:close()
        refresh_timer = nil
      end
      switching = true
      vim.cmd.stopinsert()
      vim.schedule(function()
        pcall(function()
          if term_win and vim.api.nvim_win_is_valid(term_win) then
            vim.api.nvim_win_set_buf(term_win, term_buf)
            scroll_buf, scroll_chan = nil, nil
            vim.cmd.startinsert()
            vim.cmd.redraw()
          end
        end)
        switching = false
      end)
    end
  else
    if mode == "nt" or opts.open then M.open_scrollback() end
  end
end

-- Autocmds
local group = vim.api.nvim_create_augroup("TmuxToggleScrollback", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
  group = group, pattern = "*:nt",
  callback = function(args) if args.buf == term_buf then update_mode() end end,
})

vim.api.nvim_create_autocmd({ "TermEnter", "WinEnter" }, {
  group = group,
  callback = function(args)
    if args.buf == term_buf or args.buf == scroll_buf then update_mode() end
  end,
})

-- バッファ削除時のクリーンアップ
vim.api.nvim_create_autocmd("BufWipeout", {
  group = group,
  callback = function(args)
    if args.buf == term_buf or args.buf == scroll_buf then
      if refresh_timer then
        refresh_timer:stop()
        refresh_timer:close()
        refresh_timer = nil
      end
    end
  end,
})

-- マウスホイール対応
local MOUSE_SCROLL_UP = vim.keycode("<ScrollWheelUp>")
local MOUSE_SCROLL_DOWN = vim.keycode("<ScrollWheelDown>")
vim.on_key(function(key, typed)
  key = typed or key
  if not term_win or not vim.api.nvim_win_is_valid(term_win) then return end
  if vim.api.nvim_get_current_win() ~= term_win then return end
  if (key == MOUSE_SCROLL_UP or key == MOUSE_SCROLL_DOWN) and not is_scrollback_active() and not switching then
    vim.schedule(function() update_mode({ open = true }) end)
  end
end)

return M
