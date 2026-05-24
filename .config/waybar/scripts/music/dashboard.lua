#!/usr/bin/env lua
-- waybar/scripts/music/dashboard.lua

local json = require("dkjson")


local function cmd(command)
	local handle = io.popen(command)
	if not handle then
		return ""
	end

	local result = handle:read("*a")
	handle:close()

	return (result or ""):gsub("%s+$", "")
end

local function spotify_metadata()
	local status = cmd("playerctl -p spotify status 2>/dev/null")

	if status == "" then
		return nil
	end

	local artist = cmd("playerctl -p spotify metadata artist 2>/dev/null")
	local title  = cmd("playerctl -p spotify metadata title 2>/dev/null")

	return {
		status = status,
		artist = artist,
		title = title
	}
end


local function spotify_toggle()
	os.execute("playerctl -p spotify play-pause")
end

local function spotify_next()
	os.execute("playerctl -p spotify next")
end

local function spotify_prev()
	os.execute("playerctl -p spotify previous")
end

local function spotify_open()
	os.execute("flatpak run com.spotify.Client &")
end


local function waybar_output()
	local metadata = spotify_metadata()

	local output = {}

	if metadata then
		local icon = metadata.status == "Playing" and "<span size='13000' rise='-1500'>\u{f04c}</span>" or "<span size='13000' rise='-1500'>\u{f04b}</span>"

		output.text =
		icon .. "  " ..
		metadata.artist ..
		" : " ..
		metadata.title

		output.tooltip = "Click to open dashboard"

		output.class =
		metadata.status == "Playing"
		and "playing"
		or "paused"
	else
		output.text = "<span size='13000' rise='-1500'>\u{f075a}</span> Spotify"
		output.tooltip = "Spotify not running"
		output.class = "inactive"
	end

	print(json.encode(output))
end

-- ---------------- Dashboard ----------------

local function show_dashboard()
	local metadata = spotify_metadata()

	local items = {}

	if metadata then
		-- \u{f04ae} is 󰒮 (Previous Track)
		table.insert(items, {
			label = "\u{f04ae}",
			action = "prev"
		})

		-- \u{f03e4} is 󰏤 (Pause), \u{f040a} is 󰐊 (Play)
		local play_pause_icon = metadata.status == "Playing" and "\u{f03e4}" or "\u{f040a}"
		table.insert(items, {
			label = play_pause_icon,
			action = "toggle"
		})

		-- \u{f04ad} is 󰒭 (Next Track)
		table.insert(items, {
			label = "\u{f04ad}",
			action = "next"
		})
	else
		-- \u{f075a} is 󰝚 (Spotify logo)
		table.insert(items, {
			label = "\u{f075a} Open Spotify",
			action = "open"
		})
	end

	local menu = ""
	for _, item in ipairs(items) do
		menu = menu .. item.label .. "\n"
	end

	local message =
	metadata and
	(metadata.artist .. " — " .. metadata.title)
	or
	"Spotify Controller"

	local columns = metadata and 3 or 1
	local font_spec = metadata and "SauceCodePro NFM 16" or "SauceCodePro NFM 14"

	-- Rofi layout with only 3 buttons horizontal, no inputbar, pure black/white/gray monochrome theme.
	local rofi_cmd = string.format([[
	printf "%%s" '%s' | rofi -dmenu \
	-i \
	-no-custom \
	-me-select-entry '' \
	-me-accept-entry MousePrimary \
	-p " " \
	-mesg "%s" \
	-theme "/home/seivarya/.config/waybar/scripts/music/dashboard.rasi" \
	-theme-str 'listview { columns: %d; } element-text { font: "%s"; }'
	]], menu, message, columns, font_spec)

	local selected = cmd(rofi_cmd)

	if selected == "" then
		return
	end

	for _, item in ipairs(items) do
		if selected == item.label then
			if item.action == "toggle" then
				spotify_toggle()
			elseif item.action == "next" then
				spotify_next()
			elseif item.action == "prev" then
				spotify_prev()
			elseif item.action == "open" then
				spotify_open()
			end
		end
	end
end


if arg[1] == "--dashboard" then
	show_dashboard()
else
	waybar_output()
end
