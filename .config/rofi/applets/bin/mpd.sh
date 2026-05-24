#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# mpd status
status="$(mpc status)"

# ui
if [[ -z "$status" ]]; then
	prompt="offline"
	mesg="mpd is offline"
else
	artist="$(mpc -f "%artist%" current)"
	title="$(mpc -f "%title%" current)"
	progress="$(mpc status | grep "#" | awk '{print $3}')"

	prompt="${artist,,}"
	mesg="${title,,}  ::  $progress"
fi

# rofi layout
list_col='1'
list_row='6'
win_width='400px'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# playback state
if [[ "$status" == *"[playing]"* ]]; then
	play_icon="󰏤"
	play_text="pause"
else
	play_icon="󰐊"
	play_text="play"
fi

# repeat/random state
if [[ "$status" == *"repeat: on"* ]]; then
	repeat_text="repeat on"
else
	repeat_text="repeat off"
fi

if [[ "$status" == *"random: on"* ]]; then
	random_text="shuffle on"
else
	random_text="shuffle off"
fi

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="$play_icon $play_text"
	option_2="󰓛 stop"
	option_3="󰒮 previous"
	option_4="󰒭 next"
	option_5="󰑖 $repeat_text"
	option_6="󰒟 $random_text"
else
	option_1="$play_icon"
	option_2="󰓛"
	option_3="󰒮"
	option_4="󰒭"
	option_5="󰑖"
	option_6="󰒟"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str 'textbox-prompt-colon { str: "󰎆"; }' \
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

# notification helper
notify_track() {
	current="$(mpc current)"

	if [[ -n "$current" ]]; then
		notify-send \
			-u low \
			-t 1000 \
			"󰎆 $current"
	fi
}

# actions
run_cmd() {
	case "$1" in
		--toggle)
			mpc -q toggle
			notify_track
			;;

		--stop)
			mpc -q stop
			;;

		--previous)
			mpc -q prev
			notify_track
			;;

		--next)
			mpc -q next
			notify_track
			;;

		--repeat)
			mpc -q repeat
			;;

		--random)
			mpc -q random
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --toggle
		;;

	"$option_2")
		run_cmd --stop
		;;

	"$option_3")
		run_cmd --previous
		;;

	"$option_4")
		run_cmd --next
		;;

	"$option_5")
		run_cmd --repeat
		;;

	"$option_6")
		run_cmd --random
		;;
esac
