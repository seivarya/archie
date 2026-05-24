--[[ environment variables ]]

--[[ reference: https://wiki.hypr.land/configuring/advanced-and-cool/environment-variables/ ]]

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XDG_DATA_DIRS", "/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")

hl.env("QT_QPA_PLATFORM", "wayland") 
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") 
hl.env("QT_STYLE_OVERRIDE", "kvantum") 

