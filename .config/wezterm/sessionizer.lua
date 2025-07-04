local wezterm = require("wezterm")

local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")

local schema = {
	options = {
		callback = function(_, pane, id, _)
			pane:send_text('cd "' .. id .. '" && cls\r')
		end,
	},

	sessionizer.FdSearch({
		"D:/.onedrive bestanden/creatief/Code",
		exclude = {
			"node_modules",
			".next",
			"remarkable",
			"AI",
			"Add-ons",
			"__pycache__",
			"Add-ons",
			"AI",
		},
	}),
	sessionizer.FdSearch(wezterm.home_dir .. "/Universiteit-Utrecht"),
	sessionizer.FdSearch(wezterm.home_dir .. "/dotfiles"),

	processing = sessionizer.for_each_entry(function(entry)
		entry.label = entry.label:gsub(wezterm.home_dir, "~")
	end),
}

local m = {}

function m.setup(config)
	table.insert(config.keys, {
		key = "s",
		mods = "ALT",
		action = sessionizer.show(schema),
	})
end

return m
