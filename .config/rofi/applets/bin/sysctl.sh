#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# ui
prompt="services"
mesg="manage systemd services"

# rofi layout
list_col='1'
list_row='6'
win_width='400px'

# managed services
services=(
	iwd
	bluetooth
	NetworkManager
	sshd
	docker
	libvirtd
)

# service status
get_status() {
	local service="$1"

	if systemctl is-active --quiet "$service"; then
		echo "󰐊  $service  <span alpha='70%'>running</span>"
	else
		echo "󰚌  $service  <span alpha='70%'>stopped</span>"
	fi
}

# generate options
generate_options() {
	for service in "${services[@]}"; do
		get_status "$service"
	done
}

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str 'textbox-prompt-colon { str: "󰒓"; }' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "$theme"
}

# launch rofi
run_rofi() {
	generate_options | rofi_cmd
}

# pkexec wrapper
pkexec_cmd() {
	pkexec env \
		PATH="$PATH" \
		WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
		XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
		"$@"
}

# notifications
notify_success() {
	dunstify \
		-u normal \
		-h string:x-dunst-stack-tag:services \
		"$1"
}

notify_error() {
	dunstify \
		-u critical \
		-h string:x-dunst-stack-tag:services \
		"$1"
}

# selection
chosen="$(run_rofi)"

# exit safely
[[ -z "$chosen" ]] && exit 0

# extract service name
service="$(echo "$chosen" | awk '{print $2}')"

# toggle service
if systemctl is-active --quiet "$service"; then

	if pkexec_cmd systemctl stop "$service"; then
		notify_success "$service stopped"
	else
		notify_error "failed to stop $service"
	fi

else

	if pkexec_cmd systemctl start "$service"; then
		notify_success "$service started"
	else
		notify_error "failed to start $service"
	fi

fi
