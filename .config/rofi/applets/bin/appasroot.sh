#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# ui
prompt="applications"
mesg="run applications as root"

# rofi layout
list_col='1'
list_row='4'
win_width='400px'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="󰆍 kitty"
	option_2="󰉋 dolphin"
	option_3="󰕷 neovim"
	option_4="󰙅 ranger"
else
	option_1="󰆍"
	option_2="󰉋"
	option_3="󰕷"
	option_4="󰙅"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str 'textbox-prompt-colon { str: "󰌾"; }' \
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
		--kitty)
			pkexec_cmd kitty
			;;

		--dolphin)
			pkexec_cmd dbus-run-session dolphin
			;;

		--nvim)
			pkexec_cmd kitty -e nvim
			;;

		--ranger)
			pkexec_cmd kitty -e ranger
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --kitty
		;;

	"$option_2")
		run_cmd --dolphin
		;;

	"$option_3")
		run_cmd --nvim
		;;

	"$option_4")
		run_cmd --ranger
		;;
esac
