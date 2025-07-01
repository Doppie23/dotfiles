-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Abernathy"

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

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

config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.keys = {
	{
		key = "Space",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1b[32;5u"),
	},
}

local tab_keys = { "x", "c", "v" }

for i, key in ipairs(tab_keys) do
	table.insert(config.keys, {
		key = key,
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

require("sessionizer").setup(config)

local function basename(path)
	return path:match("([^/\\]+)$") or path
end
wezterm.on("update-status", function(window, _)
	local workspace = window:active_workspace()
	workspace = basename(workspace)
	window:set_left_status(wezterm.format({
		{ Text = " " .. workspace .. " " },
	}))
end)

return config
