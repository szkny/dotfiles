local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_prog = { "wsl.exe", "--cd", "~", "--exec", "/usr/bin/zsh", "-l" }
config.font = wezterm.font("HackGen Console NFJ", { weight="Regular", stretch="Normal", italic=false })

config.color_scheme = "Tender (Gogh)"
config.window_background_opacity = 0.9
config.text_background_opacity = 1.0

return config
