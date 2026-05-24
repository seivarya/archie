--[[ windows and workspaces ]]

--[[ reference: https://wiki.hypr.land/configuring/basics/workspace-rules/ ]]
--[[ smart gaps / no gaps when only (uncomment if you wish to use) ]]
--[[ hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 }) ]]
--[[ hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 }) ]]
--[[ hl.window_rule({ ]]
--[[     name  = "no-gaps-wtv1", ]]
--[[     match = { float = false, workspace = "w[tv1]" }, ]]
--[[     border_size = 0, ]]
--[[     rounding    = 0, ]]
--[[ }) ]]
--[[ hl.window_rule({ ]]
--[[     name  = "no-gaps-f1", ]]
--[[     match = { float = false, workspace = "f[1]" }, ]]
--[[     border_size = 0, ]]
--[[     rounding    = 0, ]]
--[[ }) ]]

--[[ reference: https://wiki.hypr.land/configuring/basics/window-rules/ ]]

--[[ example window rules ]]

local suppressMaximizeRule = hl.window_rule({
	--[[ ignore maximize events from all windows ]]
	name = "suppress-maximize-events",
	match = {
		class = ".*"
	},
	suppress_event = "maximize",
})
--[[ suppressMaximizeRule:set_enabled(false) ]]

hl.window_rule({
	--[[ fix dragging issues with xwayland ]]
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

--[[ layer rules (returns a handle) ]]
--[[ local overlayLayerRule = hl.layer_rule({ ]]
--[[     name  = "no-anim-overlay", ]]
--[[     match = { namespace = "^my-overlay$" }, ]]
--[[     no_anim = true, ]]
--[[ }) ]]
--[[ overlayLayerRule:set_enabled(false) ]]

--[[ hyprland run window rule ]]
hl.window_rule({
	name = "move-hyprland-run",
	match = {
		class = "hyprland-run"
	},
	move = "20 monitor_h-120",
	float = true,
})

