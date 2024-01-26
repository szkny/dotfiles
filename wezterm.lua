local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- base
config.default_prog = { "wsl.exe", "--cd", "~", "--exec", "/usr/bin/zsh", "-l" }


-- font
config.font = wezterm.font("HackGen Console NFJ", { weight="Regular", stretch="Normal", italic=false })
config.font_size = 12.5
config.adjust_window_size_when_changing_font_size = false


-- color
config.colors = {
  cursor_bg = '#ffffff',
  cursor_fg = '#000000',
  cursor_border = '#ffffff',
  brights = {
    '#999999',
    '#ff6655',
    '#55dd55',
    '#eedd00',
    '#0099ee',
    '#dd66dd',
    '#77ccdd',
    '#dddddd',
  },
}
-- config.color_scheme = "Tomorrow (dark) (terminal.sexy)"
-- config.color_scheme = 'Adventure'
-- config.color_scheme = 'Andromeda'
config.color_scheme = 'Argonaut'
-- config.color_scheme = 'Tokyo Night (Gogh)'


-- window
config.window_background_opacity = 0.70
config.text_background_opacity = 1.00
config.win32_system_backdrop = "Acrylic"
-- config.win32_system_backdrop = "Mica"
-- config.win32_system_backdrop = "Tabbed"
config.initial_rows = 45
config.initial_cols = 150
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 3, right = 3,
  top = 3, bottom = 0,
}


-- tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.window_frame = {
  font_size = 7.0,
  active_titlebar_bg = '#1f232f',
  inactive_titlebar_bg = '#1f232f',
}
wezterm.on(
  'format-tab-title',
  function(tab)
    local title = tab.tab_title
    if not ( title and #title > 0 ) then
      -- local icon = wezterm.nerdfonts.cod_terminal_ubuntu
      local icon = wezterm.nerdfonts.cod_terminal
      title = icon .. '    ' .. ( tab.tab_index + 1 )
    end
    if tab.is_active then
      return {
        { Background = { Color = '#1f232f' } },
        { Foreground = { Color = '#888888' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    return {
      { Background = { Color = '#181d24' } },
      { Foreground = { Color = '#555555' } },
      { Text = ' ' .. title .. ' ' },
    }
  end
)
config.colors.tab_bar = {
  new_tab = {
    bg_color = "#1f232f",
    fg_color = "#888888",
  }
}


-- key bindings
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'K',
    mods = 'CTRL',
    action = wezterm.action.AdjustPaneSize({"Up", 1})
  },
  {
    key = 'J',
    mods = 'CTRL',
    action = wezterm.action.AdjustPaneSize({"Down", 1})
  },
  {
    key = 'L',
    mods = 'CTRL',
    action = wezterm.action.AdjustPaneSize({"Right", 1})
  },
  {
    key = 'H',
    mods = 'CTRL',
    action = wezterm.action.AdjustPaneSize({"Left", 1})
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Right"
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection "Left"
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab("CurrentPaneDomain")
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab("CurrentPaneDomain")
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentTab({ confirm = true })
  },
  -- Send "CTRL-Q" to the terminal when pressing CTRL-Q, CTRL-Q
  {
    key = '1',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey({ key = 'q', mods = 'CTRL' }),
  },
}


-- notifications
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 100,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 350,
}
config.colors.visual_bell = '#444444'


return config
