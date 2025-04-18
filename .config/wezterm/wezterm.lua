-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Aci (Gogh)"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.font = wezterm.font("Cascadia Code")
config.font_size = 12
config.adjust_window_size_when_changing_font_size = false

config.default_prog = { "pwsh.exe", "-NoLogo" }
config.initial_cols = 132
config.initial_rows = 52

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.keys = {
	{
		key = "Space",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1b[32;5u"),
	},
}
return config
