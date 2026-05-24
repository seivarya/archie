--[[ must match definitions in hyprland.lua ]]

local terminal = "kitty"
local fileManager = "dolphin"
local menu = "~/.config/rofi/scripts/launcher"

local mainMod = "SUPER"

--[[ window management & layout bindings ]]

hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd(terminal)
)

hl.bind(
	mainMod .. " + Q",
	hl.dsp.window.close()
)

hl.bind(
	mainMod .. " + P",
	hl.dsp.window.pseudo()
)

hl.bind(
	mainMod .. " + J",
	hl.dsp.layout("togglesplit")
)

hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen()
)

hl.bind(
	mainMod .. " + F",
	hl.dsp.window.float({
		action = "toggle"
	})
)

--[[ applications & menu bindings ]]

--[[ rofi app launcher ]]
hl.bind(
	mainMod .. " + R",
	hl.dsp.exec_cmd("rofi -show drun")
)

--[[ rofi powermenu ]]
hl.bind(
	mainMod .. " + X",
	hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu")
)

--[[ lock screen ]]
hl.bind(
	mainMod .. " + L",
	hl.dsp.exec_cmd("hyprlock")
)

--[[ file manager ]]
hl.bind(
	mainMod .. " + E",
	hl.dsp.exec_cmd(fileManager)
)

--[[ web browser ]]
hl.bind(
	mainMod .. " + B",
	hl.dsp.exec_cmd("zen-browser")
)

--[[ screenshot applet ]]
hl.bind(
	mainMod .. " + H",
	hl.dsp.exec_cmd("~/.config/rofi/applets/bin/screenshot.sh")
)

--[[ screenshot (print key) ]]
hl.bind(
	"Print",
	hl.dsp.exec_cmd("~/.config/rofi/applets/bin/screenshot.sh")
)

--[[ volume applet ]]
hl.bind(
	mainMod .. " + SHIFT + A",
	hl.dsp.exec_cmd("~/.config/rofi/applets/bin/volume.sh")
)

--[[ brightness applet ]]
hl.bind(
	mainMod .. " + SHIFT + B",
	hl.dsp.exec_cmd("~/.config/rofi/applets/bin/brightness.sh")
)

--[[ systemd services manager ]]
hl.bind(
	mainMod .. " + CTRL + S",
	hl.dsp.exec_cmd("~/.config/rofi/applets/bin/sysctl.sh")
)

--[[ window focus controls ]]

hl.bind(
	mainMod .. " + left",
	hl.dsp.focus({
		direction = "left"
	})
)

hl.bind(
	mainMod .. " + right",
	hl.dsp.focus({
		direction = "right"
	})
)

hl.bind(
	mainMod .. " + up",
	hl.dsp.focus({
		direction = "up"
	})
)

hl.bind(
	mainMod .. " + down",
	hl.dsp.focus({
		direction = "down"
	})
)

--[[ workspace switching ]]

for i = 1, 10 do
	local key = i % 10 --[[ 10 maps to key 0 ]]

	hl.bind(
		mainMod .. " + " .. key,
		hl.dsp.focus({
			workspace = i
		})
	)

	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({
			workspace = i
		})
	)
end

--[[ special workspace (scratchpad) ]]
hl.bind(
	mainMod .. " + S",
	hl.dsp.workspace.toggle_special("magic")
)

hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.window.move({
		workspace = "special:magic"
	})
)

--[[ scroll workspaces ]]
hl.bind(
	mainMod .. " + mouse_down",
	hl.dsp.focus({
		workspace = "e+1"
	})
)

hl.bind(
	mainMod .. " + mouse_up",
	hl.dsp.focus({
		workspace = "e-1"
	})
)

--[[ window drag and resize ]]
hl.bind(
	mainMod .. " + mouse:272",
	hl.dsp.window.drag(),
	{ mouse = true }
)

hl.bind(
	mainMod .. " + mouse:273",
	hl.dsp.window.resize(),
	{ mouse = true }
)

--[[ multimedia keys ]]
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
	{ locked = true, repeating = true }
)

--[[ media player controls ]]
hl.bind(
	"XF86AudioNext",
	hl.dsp.exec_cmd("playerctl next"),
	{ locked = true }
)

hl.bind(
	"XF86AudioPause",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true }
)

hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true }
)

hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("playerctl previous"),
	{ locked = true }
)

