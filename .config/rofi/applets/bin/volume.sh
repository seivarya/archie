#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"


# volume info
speaker="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f%%", $2*100}')"
mic="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{printf "%.0f%%", $2*100}')"

# speaker state
if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q 'MUTED'; then
	sicon="󰖁"
	stext="speaker muted"
else
	sicon="󰕾"
	stext="speaker unmuted"
fi

# mic state
if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q 'MUTED'; then
	micon="󰍭"
	mtext="mic muted"
else
	micon="󰍬"
	mtext="mic unmuted"
fi

# rofi layout
list_col='1'
list_row='5'
win_width='400px'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="󰕾 increase"
	option_2="󰖀 decrease"
	option_3="$sicon $stext"
	option_4="$micon $mtext"
	option_5="󰒓 settings"
else
	option_1="󰕾"
	option_2="󰖀"
	option_3="$sicon"
	option_4="$micon"
	option_5="󰒓"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str 'textbox-prompt-colon { str: "󰕾"; }' \
		-dmenu \
		-p "audio" \
		-mesg "speaker: $speaker  |  mic: $mic" \
		-markup-rows \
		-theme "$theme"
}

# launch rofi
run_rofi() {
	echo -e \
		"$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# actions
run_cmd() {
	case "$1" in
		--inc)
			wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
			;;

		--dec)
			wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
			;;

		--speaker)
			wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
			;;

		--mic)
			wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
			;;

		--settings)
			pavucontrol
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --inc
		;;

	"$option_2")
		run_cmd --dec
		;;

	"$option_3")
		run_cmd --speaker
		;;

	"$option_4")
		run_cmd --mic
		;;

	"$option_5")
		run_cmd --settings
		;;
esac
