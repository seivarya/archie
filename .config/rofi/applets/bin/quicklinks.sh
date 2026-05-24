#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# ui
prompt="quick links"
mesg="browser: ${BROWSER:-default}"

# rofi layout
list_col='1'
list_row='6'
win_width='400px'

# icon font sizing
efonts="SauceCodePro NFM 12"

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="󰖟 google"
	option_2="󰇮 gmail"
	option_3="󰗃 youtube"
	option_4="󰊤 github"
	option_5="󰑍 reddit"
	option_6="󰕃 twitter"
else
	option_1="󰖟"
	option_2="󰇮"
	option_3="󰗃"
	option_4="󰊤"
	option_5="󰑍"
	option_6="󰕃"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str 'textbox-prompt-colon { str: "󰖉"; }' \
		-theme-str "element-text { font: \"$efonts\"; }" \
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

# open links
open_link() {
	xdg-open "$1" &>/dev/null
}

# actions
run_cmd() {
	case "$1" in
		--google)
			open_link "https://google.com"
			;;

		--gmail)
			open_link "https://mail.google.com"
			;;

		--youtube)
			open_link "https://youtube.com"
			;;

		--github)
			open_link "https://github.com"
			;;

		--reddit)
			open_link "https://reddit.com"
			;;

		--twitter)
			open_link "https://twitter.com"
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --google
		;;

	"$option_2")
		run_cmd --gmail
		;;

	"$option_3")
		run_cmd --youtube
		;;

	"$option_4")
		run_cmd --github
		;;

	"$option_5")
		run_cmd --reddit
		;;

	"$option_6")
		run_cmd --twitter
		;;
esac
