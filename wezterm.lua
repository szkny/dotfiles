local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- base
config.default_prog = { "wsl.exe", "--cd", "~", "--exec", "/usr/bin/zsh", "-l" }

-- font
config.font = wezterm.font("HackGen Console NFJ", { weight = "Regular", stretch = "Normal", italic = false })
config.font_size = 11.8
config.adjust_window_size_when_changing_font_size = false

-- color
config.colors = {
	cursor_bg = "#ffffff",
	cursor_fg = "#000000",
	cursor_border = "#ffffff",
	brights = {
		"#999999",
		"#ff6655",
		"#55dd55",
		"#eedd00",
		"#0099ee",
		"#dd66dd",
		"#77ccdd",
		"#dddddd",
	},
}
-- config.color_scheme = "Tomorrow (dark) (terminal.sexy)"
-- config.color_scheme = "Adventure"
-- config.color_scheme = "Andromeda"
config.color_scheme = "Argonaut"
-- config.color_scheme = "Tokyo Night (Gogh)"

-- window
config.window_background_opacity = 0.70
config.text_background_opacity = 1.00
config.win32_system_backdrop = "Acrylic"
-- config.win32_system_backdrop = "Mica"
-- config.win32_system_backdrop = "Tabbed"
config.initial_rows = 60
config.initial_cols = 200
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 3,
	right = 3,
	top = 3,
	bottom = 0,
}

-- tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.window_frame = {
	font_size = 7.0,
	active_titlebar_bg = "#1f232f",
	inactive_titlebar_bg = "#1f232f",
}
wezterm.on("format-tab-title", function(tab)
	local title = tab.tab_title
	if not (title and #title > 0) then
		-- local icon = wezterm.nerdfonts.cod_terminal_ubuntu
		local icon = wezterm.nerdfonts.cod_terminal
		title = icon .. "    " .. (tab.tab_index + 1)
	end
	if tab.is_active then
		return {
			{ Background = { Color = "#1f232f" } },
			{ Foreground = { Color = "#888888" } },
			{ Text = " " .. title .. " " },
		}
	end
	return {
		{ Background = { Color = "#181d24" } },
		{ Foreground = { Color = "#555555" } },
		{ Text = " " .. title .. " " },
	}
end)
config.colors.tab_bar = {
	new_tab = {
		bg_color = "#1f232f",
		fg_color = "#888888",
	},
}

-- toggle full screen
wezterm.on("toggle-full-screen", function(window, _)
	window:toggle_fullscreen()
end)

-- key bindings
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
	{
		key = "F11",
		mods = "",
		action = wezterm.action.EmitEvent("toggle-full-screen"),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "K",
		mods = "CTRL",
		action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
	},
	{
		key = "J",
		mods = "CTRL",
		action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
	},
	{
		key = "L",
		mods = "CTRL",
		action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
	},
	{
		key = "H",
		mods = "CTRL",
		action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action.QuickSelect,
	},
	{
		key = " ",
		mods = "SHIFT|CTRL",
		action = wezterm.action.QuickSelect,
	},
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "l",
		mods = "LEADER|CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "h",
		mods = "LEADER|CTRL",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "LEADER",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = wezterm.action.MoveTabRelative(-1),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
}
local act = wezterm.action

config.key_tables = {
	copy_mode = {
		{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{
			key = "Tab",
			mods = "SHIFT",
			action = act.CopyMode("MoveBackwardWord"),
		},
		{
			key = "Enter",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfNextLine"),
		},
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "[", mods = "CTRL", action = act.CopyMode("Close") },
		{
			key = "Space",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Cell" }),
		},
		{
			key = "$",
			mods = "NONE",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{
			key = "$",
			mods = "SHIFT",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
		{
			key = "F",
			mods = "NONE",
			action = act.CopyMode({ JumpBackward = { prev_char = false } }),
		},
		{
			key = "F",
			mods = "SHIFT",
			action = act.CopyMode({ JumpBackward = { prev_char = false } }),
		},
		{
			key = "G",
			mods = "NONE",
			action = act.CopyMode("MoveToScrollbackBottom"),
		},
		{
			key = "G",
			mods = "SHIFT",
			action = act.CopyMode("MoveToScrollbackBottom"),
		},
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
		-- { key = "H", mods = "SHIFT", action = act.CopyMode { MoveLeft = 2 } },
		-- { key = "L", mods = "SHIFT", action = act.CopyMode { MoveRight = 2 } },
		{ key = "J", mods = "SHIFT", action = act.CopyMode({ MoveByPage = 0.1 }) },
		{ key = "K", mods = "SHIFT", action = act.CopyMode({ MoveByPage = -0.1 }) },
		{
			key = "O",
			mods = "NONE",
			action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
		},
		{
			key = "O",
			mods = "SHIFT",
			action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
		},
		{
			key = "T",
			mods = "NONE",
			action = act.CopyMode({ JumpBackward = { prev_char = true } }),
		},
		{
			key = "T",
			mods = "SHIFT",
			action = act.CopyMode({ JumpBackward = { prev_char = true } }),
		},
		{
			key = "V",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "V",
			mods = "SHIFT",
			action = act.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "^",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{
			key = "^",
			mods = "SHIFT",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
		{
			key = "d",
			mods = "CTRL",
			action = act.CopyMode({ MoveByPage = 0.5 }),
		},
		{
			key = "e",
			mods = "NONE",
			action = act.CopyMode("MoveForwardWordEnd"),
		},
		{
			key = "f",
			mods = "NONE",
			action = act.CopyMode({ JumpForward = { prev_char = false } }),
		},
		{
			key = "g",
			mods = "NONE",
			action = act.CopyMode("MoveToScrollbackTop"),
		},
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
		{
			key = "u",
			mods = "CTRL",
			action = act.CopyMode({ MoveByPage = -0.5 }),
		},
		{
			key = "v",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Cell" }),
		},
		{
			key = "v",
			mods = "CTRL",
			action = act.CopyMode({ SetSelectionMode = "Block" }),
		},
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				{ CopyTo = "ClipboardAndPrimarySelection" },
				{ CopyMode = "Close" },
			}),
		},
		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
		{
			key = "End",
			mods = "NONE",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{
			key = "Home",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfLine"),
		},
		{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{
			key = "LeftArrow",
			mods = "CTRL",
			action = act.CopyMode("MoveBackwardWord"),
		},
		{
			key = "RightArrow",
			mods = "NONE",
			action = act.CopyMode("MoveRight"),
		},
		{
			key = "RightArrow",
			mods = "CTRL",
			action = act.CopyMode("MoveForwardWord"),
		},
		{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		{
			key = "/",
			mods = "NONE",
			action = wezterm.action({ Search = { CaseInSensitiveString = "" } }),
		},
		{
			key = "/",
			mods = "LEADER",
			action = wezterm.action({ Search = { CaseInSensitiveString = "" } }),
		},
		{ key = "F", mods = "SHIFT|CTRL", action = wezterm.action({ Search = { CaseSensitiveString = "" } }) },
		{ key = "n", mods = "NONE", action = wezterm.action({ CopyMode = "NextMatch" }) },
		{ key = "N", mods = "SHIFT", action = wezterm.action({ CopyMode = "PriorMatch" }) },
	},
	search_mode = {
		{ key = "Escape", mods = "NONE", action = "ActivateCopyMode" },
		{ key = "[", mods = "CTRL", action = "ActivateCopyMode" },
		{ key = "c", mods = "CTRL", action = "ActivateCopyMode" },
		{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
	},
}

-- mouse
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- notifications
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 100,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 350,
}
config.colors.visual_bell = "#444444"

return config
