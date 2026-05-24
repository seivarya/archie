#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# battery info
battery="$(acpi -b | cut -d',' -f1 | cut -d':' -f1)"
status="$(acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' ')"
percentage="$(acpi -b | cut -d',' -f2 | tr -d ' ,%')"
time="$(acpi -b | cut -d',' -f3)"

# fallback time
if [[ -z "$time" ]]; then
	time=" fully charged"
fi

# battery icons
if [[ "$status" == *"Charging"* ]]; then
	status_icon="󰂄"
elif [[ "$status" == *"Full"* ]]; then
	status_icon="󰂄"
else
	status_icon="󰂃"
fi

# percentage icons
if (( percentage <= 19 )); then
	level_icon="󰁺"
elif (( percentage <= 39 )); then
	level_icon="󰁼"
elif (( percentage <= 59 )); then
	level_icon="󰁾"
elif (( percentage <= 79 )); then
	level_icon="󰂀"
else
	level_icon="󰁹"
fi

# ui
prompt="$(echo "$status" | tr '[:upper:]' '[:lower:]')"
mesg="${battery,,}: ${percentage}%,$time"

# rofi layout
list_col='1'
list_row='4'
win_width='400px'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="$level_icon remaining ${percentage}%"
	option_2="$status_icon status ${status,,}"
	option_3="󰒓 power settings"
	option_4="󰓡 diagnose battery"
else
	option_1="$level_icon"
	option_2="$status_icon"
	option_3="󰒓"
	option_4="󰓡"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str "textbox-prompt-colon { str: \"$level_icon\"; }" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "$theme"
}

# launch rofi
run_rofi() {
	echo -e \
		"$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# pkexec wrapper
pkexec_cmd() {
	pkexec env \
		PATH="$PATH" \
		WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
		XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
		"$@"
}

# actions
run_cmd() {
	case "$1" in
		--remaining)
			notify-send -u low "remaining: ${percentage}%"
			;;

		--status)
			notify-send -u low "battery status: ${status,,}"
			;;

		--settings)
			dunstify -u low "no power manager available"
			;;

		--diagnose)
			pkexec_cmd kitty -e powertop
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --remaining
		;;

	"$option_2")
		run_cmd --status
		;;

	"$option_3")
		run_cmd --settings
		;;

	"$option_4")
		run_cmd --diagnose
		;;
esac
