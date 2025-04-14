-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Aci (Gogh)"

config.font = wezterm.font "Cascadia Code"
config.font_size = 12
config.adjust_window_size_when_changing_font_size = false

config.default_prog = { "pwsh.exe", "-NoLogo" }
config.initial_cols = 80

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

return config
