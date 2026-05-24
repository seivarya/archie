--[[ permissions ]]

--[[ reference: https://wiki.hypr.land/configuring/advanced-and-cool/permissions/ ]]
--[[ note: permission changes require a hyprland restart and are not applied on-the-fly. ]]

--[[ hl.config({ ]]
--[[   ecosystem = { ]]
--[[     enforce_permissions = true, ]]
--[[   }, ]]
--[[ }) ]]

--[[ hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow") ]]
--[[ hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow") ]]
--[[ hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow") ]]


--[[ look and feel ]]

--[[ reference: https://wiki.hypr.land/configuring/basics/variables/ ]]

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 8,

		border_size = 1,

		col = {
			active_border = {
				colors = { "#ffffff", "#ffffff" },
				angle = 45
			},
			inactive_border = "rgba(595959aa)",
		},

		--[[ enable resizing windows by clicking and dragging on borders and gaps ]]
		resize_on_border = false,

		--[[ reference: https://wiki.hypr.land/configuring/advanced-and-cool/tearing/ ]]
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		--[[ window transparency settings ]]
		active_opacity = 1.0,
		inactive_opacity = 0.98,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 2,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

--[[ reference: https://wiki.hypr.land/configuring/layouts/dwindle-layout/ ]]
hl.config({
	dwindle = {
		preserve_split = true, --[[ recommended setting ]]
	},
})

--[[ reference: https://wiki.hypr.land/configuring/layouts/master-layout/ ]]
hl.config({
	master = {
		new_status = "master",
	},
})

--[[ reference: https://wiki.hypr.land/configuring/layouts/scrolling-layout/ ]]
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

--[[ miscellaneous settings ]]

hl.config({
	misc = {
		force_default_wallpaper = -1, --[[ disable default anime wallpapers ]]
		disable_hyprland_logo = false, --[[ toggle logo / anime background ]]
	},
})


--[[ input settings ]]

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,

		sensitivity = 0, --[[ range: -1.0 to 1.0, 0 means no modification ]]

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace"
})

--[[ device-specific configuration ]]
--[[ reference: https://wiki.hypr.land/configuring/advanced-and-cool/devices/ ]]
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

