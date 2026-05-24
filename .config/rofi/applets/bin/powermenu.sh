#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# ui
prompt="$(hostname)"
mesg="uptime: $(uptime -p | sed 's/up //')"

# layout
list_col='6'
list_row='1'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="󰍁 lock"
	option_2="󰗽 logout"
	option_3="󰤄 suspend"
	option_4="󰒲 hibernate"
	option_5="󰜉 reboot"
	option_6="󰐥 shutdown"

	yes="󰄬 yes"
	no="󰜺 no"
else
	option_1="󰍁"
	option_2="󰗽"
	option_3="󰤄"
	option_4="󰒲"
	option_5="󰜉"
	option_6="󰐥"

	yes="󰄬"
	no="󰜺"
fi

# rofi command
rofi_cmd() {
	rofi \
		-dmenu \
		-markup-rows \
		-p "$prompt" \
		-mesg "$mesg" \
		-theme "$theme" \
		-theme-str "
	configuration {
		font: \"SauceCodePro NFM 14, Symbols Nerd Font Mono 14\";
}

mainbox {
	children: [ inputbar, message, listview ];
}

listview {
	columns: $list_col;
	lines: $list_row;
	spacing: 12px;
	scrollbar: false;
}

textbox-prompt-colon {
	str: \"󰐥\";
	expand: false;
}

element {
	orientation: vertical;
	border-radius: 22px;
	width: 78px;
	height: 78px;
	padding: 0px;
	margin: 0px;
}

element selected.normal {
	background-color: @selected;
}

element-box {
	children: [ element-text ];
	vertical-align: 0.5;
	horizontal-align: 0.5;
}

element-text {
	font: \"SauceCodePro NFM 28\";
	horizontal-align: 0.5;
	vertical-align: 0.5;
	y-offset: -2px;
}
"
}

# launch rofi
run_rofi() {
	echo -e \
		"$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# confirmation dialog
confirm_cmd() {
	rofi \
		-dmenu \
		-p "confirmation" \
		-mesg "are you sure?" \
		-theme "$theme" \
		-theme-str "
	configuration {
		font: \"SauceCodePro NFM 14, Symbols Nerd Font Mono 14\";
}

window {
	location: center;
	anchor: center;
	fullscreen: false;
	width: 340px;
}

mainbox {
	orientation: vertical;
	children: [ message, listview ];
}

listview {
	columns: 2;
	lines: 1;
	spacing: 12px;
}

element {
	border-radius: 14px;
	padding: 12px;
}

element-text {
	horizontal-align: 0.5;
	vertical-align: 0.5;
}

textbox {
	horizontal-align: 0.5;
}
"
}

# confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

confirm_run() {
	selected="$(confirm_exit)"

	[[ "$selected" != "$yes" ]] && exit 0

	"$@"
}

# actions
run_cmd() {
	case "$1" in

		--lock)
			if command -v betterlockscreen &>/dev/null; then
				betterlockscreen -l
			else
				loginctl lock-session
			fi
			;;

		--logout)
			confirm_run pkill -KILL -u "$USER"
			;;

		--suspend)
			confirm_run systemctl suspend
			;;

		--hibernate)
			confirm_run systemctl hibernate
			;;

		--reboot)
			confirm_run systemctl reboot
			;;

		--shutdown)
			confirm_run systemctl poweroff
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --lock
		;;

	"$option_2")
		run_cmd --logout
		;;

	"$option_3")
		run_cmd --suspend
		;;

	"$option_4")
		run_cmd --hibernate
		;;

	"$option_5")
		run_cmd --reboot
		;;

	"$option_6")
		run_cmd --shutdown
		;;
esac
