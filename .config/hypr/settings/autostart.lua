--[[ autostart ]]

--[[ reference: https://wiki.hypr.land/configuring/basics/autostart/ ]]

--[[ autostart necessary background processes (e.g., wallpaper, status bars, notifications) ]]

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hyprlock")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("dbus-update-activation-environment")
	hl.exec_cmd("gnome-keyring-daemon")
end)
