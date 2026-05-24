#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# ui
prompt="applications"
mesg="installed packages: $(pacman -Q | wc -l) (pacman)"

# rofi layout
list_col='1'
list_row='6'
win_width='400px'

# applications
term_cmd='kitty'
file_cmd='dolphin'
text_cmd='kitty -e nvim'
web_cmd='zen-browser'
music_cmd='kitty -e btop'
setting_cmd='kitty -e nmcli'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="󰆍 terminal <span weight='light' size='small'><i>($term_cmd)</i></span>"
	option_2="󰉋 files <span weight='light' size='small'><i>($file_cmd)</i></span>"
	option_3="󰕷 editor <span weight='light' size='small'><i>($text_cmd)</i></span>"
	option_4="󰖟 browser <span weight='light' size='small'><i>($web_cmd)</i></span>"
	option_5="󰎄 monitor <span weight='light' size='small'><i>($music_cmd)</i></span>"
	option_6="󰒓 network <span weight='light' size='small'><i>($setting_cmd)</i></span>"
else
	option_1="󰆍"
	option_2="󰉋"
	option_3="󰕷"
	option_4="󰖟"
	option_5="󰎄"
	option_6="󰒓"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str 'textbox-prompt-colon { str: "󰣇"; }' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "$theme"
}

# launch rofi
run_rofi() {
	echo -e \
		"$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# actions
run_cmd() {
	case "$1" in
		--terminal)
			$term_cmd
			;;

		--files)
			$file_cmd
			;;

		--editor)
			$text_cmd
			;;

		--browser)
			$web_cmd
			;;

		--monitor)
			$music_cmd
			;;

		--network)
			$setting_cmd
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --terminal
		;;

	"$option_2")
		run_cmd --files
		;;

	"$option_3")
		run_cmd --editor
		;;

	"$option_4")
		run_cmd --browser
		;;

	"$option_5")
		run_cmd --monitor
		;;

	"$option_6")
		run_cmd --network
		;;
esac
