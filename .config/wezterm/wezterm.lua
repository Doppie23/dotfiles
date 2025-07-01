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
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local window = wezterm.mux.get_window(win:window_id())
			local tabs = window:tabs()
			local tab_id = win:active_tab():tab_id()
			wezterm.log_info(tab_id)

			local active_tab_index = nil
			for i, t in ipairs(tabs) do
				if t:tab_id() == tab_id then
					active_tab_index = i - 1 -- Convert to 0-based index
					break
				end
			end

			if active_tab_index == 1 then
				win:perform_action(wezterm.action.ActivateTab(0), pane)
			else
				if #tabs >= 2 then
					win:perform_action(wezterm.action.ActivateTab(1), pane)
				else
					win:perform_action(wezterm.action.SpawnTab("DefaultDomain"), pane)
				end
			end
		end),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local dim = pane:get_dimensions()
			local w = dim.pixel_width
			local h = dim.pixel_height

			if w > h then
				win:perform_action(wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
				wezterm.log_info("widht", w)
			else
				win:perform_action(wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
				wezterm.log_info("heigh", h)
			end
		end),
	},
}

for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "META",
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
