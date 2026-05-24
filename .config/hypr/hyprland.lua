--[[ hyprland lua configuration ]]
--[[ reference: https://wiki.hypr.land/configuring/start/ ]]

require("hyprlock")

--[[ core settings ]]
require("settings.monitors")
require("settings.programs")
require("settings.autostart")
require("settings.env")
require("settings.general")

--[[ animations ]]
require("animations.animations")

--[[ keybindings ]]
require("keybinds.keybinds")

--[[ window & workspace rules ]]
require("settings.rules")
