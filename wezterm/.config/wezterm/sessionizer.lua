local wezterm = require("wezterm")
local m = {}

local cache_file = wezterm.home_dir .. "/.fcd_cache.txt"

local function refresh_cache()
	local roots = {
		"D:/.onedrive bestanden/creatief/Code",
		wezterm.home_dir .. "/Universiteit-Utrecht",
		wezterm.home_dir .. "/dotfiles",
	}
	local exclude_args = ""
	for _, e in ipairs({ "node_modules", ".next", "AI", "Add-ons", "__pycache__" }) do
		exclude_args = exclude_args .. " -E " .. e
	end

	local quoted_roots = {}
	for _, r in ipairs(roots) do
		table.insert(quoted_roots, "'" .. r .. "'")
	end

	local fd_cmd = "fd -H -t d '^\\.git$'"
		.. exclude_args
		.. " "
		.. table.concat(quoted_roots, " ")
		.. " | ForEach-Object { $_ -replace '[\\\\/]\\.git[\\\\/]?$','' } | Out-File -Encoding utf8 '"
		.. cache_file
		.. "'"

	wezterm.background_child_process({ "pwsh.exe", "-NoProfile", "-Command", fd_cmd })
end

local function file_exists(file_path)
	local f = io.open(file_path, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- wezterm.on("gui-startup", function()
-- 	refresh_cache()
-- end)

function m.setup(config)
	table.insert(config.keys, {
		key = "s",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local choices = {}

			if not file_exists(cache_file) then
				refresh_cache()
			end

			for line in io.lines(cache_file) do
				table.insert(choices, { id = line, label = (line:gsub(wezterm.home_dir, "~")) })
			end
			window:perform_action(
				wezterm.action.InputSelector({
					title = "Select repo",
					choices = choices,
					fuzzy = true,
					action = wezterm.action_callback(function(_, p, id)
						if id then
							-- p:send_text('cd "' .. id .. '"; cls\r')
							p:send_text('cd "' .. id .. '"\r')
						end
					end),
				}),
				pane
			)
		end),
	})

	table.insert(config.keys, {
		key = "s",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(win)
			refresh_cache()
			win:toast_notification("fcd", "Reloading cache...", nil, 4000)
		end),
	})
end

return m
