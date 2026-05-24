#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# brightness info
bright_info="$(brightnessctl -m | head -n1)"

card="$(echo "$bright_info" | cut -d',' -f1)"
backlight="$(echo "$bright_info" | cut -d',' -f4 | tr -d '%')"

# brightness level
if (( backlight <= 29 )); then
	level="low"
	icon="󰃞"
elif (( backlight <= 49 )); then
	level="optimal"
	icon="󰃟"
elif (( backlight <= 69 )); then
	level="high"
	icon="󰃠"
else
	level="peak"
	icon="󰃠"
fi

# ui
prompt="${backlight}%"
mesg="device: ${card,,}  |  level: $level"

# rofi layout
list_col='1'
list_row='4'
win_width='400px'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="󰃠 increase brightness"
	option_2="󰃟 optimal brightness"
	option_3="󰃞 decrease brightness"
	option_4="󰒓 brightness settings"
else
	option_1="󰃠"
	option_2="󰃟"
	option_3="󰃞"
	option_4="󰒓"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str "textbox-prompt-colon { str: \"$icon\"; }" \
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

# actions
run_cmd() {
	case "$1" in
		--increase)
			brightnessctl set +5%
			;;

		--optimal)
			brightnessctl set 25%
			;;

		--decrease)
			brightnessctl set 5%-
			;;

		--settings)
			dunstify \
				-u low \
				-h string:x-dunst-stack-tag:brightness \
				"brightness settings not installed"
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --increase
		;;

	"$option_2")
		run_cmd --optimal
		;;

	"$option_3")
		run_cmd --decrease
		;;

	"$option_4")
		run_cmd --settings
		;;
esac
