local wezterm = require("wezterm")

local config = wezterm.config_builder()

local scheme = "Abernathy"
local scheme_def = wezterm.color.get_builtin_schemes()[scheme]

config.color_scheme = scheme

config.colors = {
	tab_bar = {
		background = scheme_def.background,

		active_tab = {
			bg_color = scheme_def.background,
			fg_color = scheme_def.foreground,
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		inactive_tab = {
			bg_color = scheme_def.ansi[1],
			fg_color = scheme_def.brights[1],
		},

		inactive_tab_hover = {
			bg_color = scheme_def.ansi[5],
			fg_color = scheme_def.brights[8],
			italic = true,
		},

		new_tab = {
			bg_color = scheme_def.ansi[1],
			fg_color = scheme_def.brights[1],
		},

		new_tab_hover = {
			bg_color = scheme_def.ansi[6],
			fg_color = scheme_def.brights[8],
			italic = true,
		},
	},
}

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

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe", "-NoLogo" }
end
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
					win:perform_action(wezterm.action.SpawnTab("CurrentPaneDomain"), pane)
				end
			end
		end),
	},
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
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
			else
				win:perform_action(wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
			end
		end),
	},
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({
			domain = { DomainName = "WSL:NixOS" },
		}),
	},
}

for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

require("sessionizer").setup(config)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

smart_splits.apply_to_config(config, {
	-- the default config is here, if you'd like to use the default keys,
	-- you can omit this configuration table parameter and just use
	-- smart_splits.apply_to_config(config)

	-- directional keys to use in order of: left, down, up, right
	direction_keys = { "h", "j", "k", "l" },
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
	-- log level to use: info, warn, error
	log_level = "info",
})

return config
