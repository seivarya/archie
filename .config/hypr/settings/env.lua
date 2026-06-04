--[[ environment variables ]]

--[[ reference: https://wiki.hypr.land/configuring/advanced-and-cool/environment-variables/ ]]

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XDG_DATA_DIRS", "/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")

hl.env("QT_QPA_PLATFORM", "wayland") 
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") 
hl.env("QT_STYLE_OVERRIDE", "kvantum") 
hl.env("NIXOS_OZONE_WL", "1");
hl.env("OZONE_PLATFORM", "wayland");
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto");
