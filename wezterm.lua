local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_prog = { "wsl.exe", "--cd", "~", "--exec", "/usr/bin/zsh", "-l" }

-- font
config.font = wezterm.font("HackGen Console NFJ", { weight="Regular", stretch="Normal", italic=false })
config.font_size = 12.0
config.adjust_window_size_when_changing_font_size = false

-- color
config.colors = {
  cursor_bg = '#ffffff',
  cursor_fg = 'black',
  cursor_border = '#ffffff',
} 
config.color_scheme = "Tomorrow (dark) (terminal.sexy)"

-- window
config.window_background_opacity = 0.95
config.text_background_opacity = 1.00
-- config.win32_system_backdrop = "Acrylic"
-- config.win32_acrylic_accent_color = "#ffffff"
config.initial_rows = 50
config.initial_cols = 150
config.window_decorations = "RESIZE"
config.window_frame = {
  font_size = 8.0,
  active_titlebar_bg = '#1f1f1f',
  inactive_titlebar_bg = '#1f1f1f',
}

-- tab
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab.tab_title
    if not ( title and #title > 0 ) then
        -- title = tab.active_pane.title
        title = ' wsl '
    end
    if tab.is_active then
      return {
        { Background = { Color = '#333333' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    return {
      { Background = { Color = '#1f1f1f' } },
      { Text = ' ' .. title .. ' ' },
    }
  end
)

-- notifications
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}
config.colors.visual_bell = '#202020'

return config
