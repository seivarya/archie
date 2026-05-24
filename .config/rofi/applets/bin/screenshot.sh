#!/usr/bin/env bash

# theme
theme="$HOME/.config/rofi/applets/style.rasi"

# ui
prompt="screenshot"
mesg="dir: $(xdg-user-dir PICTURES)/Screenshots"

# rofi layout
list_col='1'
list_row='5'
win_width='400px'

# icon mode
layout=$(grep -i 'use_icon' "$theme" | cut -d'=' -f2 | tr -d ' ;')

# options
if [[ "${layout,,}" == "no" ]]; then
	option_1="󰹑 capture desktop"
	option_2="󰆞 capture area"
	option_3="󰖲 capture window"
	option_4="󰔛 capture in 5s"
	option_5="󰔛 capture in 10s"
else
	option_1="󰹑"
	option_2="󰆞"
	option_3="󰖲"
	option_4="󰔛"
	option_5="󰔛"
fi

# rofi command
rofi_cmd() {
	rofi \
		-theme-str "window { width: $win_width; }" \
		-theme-str "listview { columns: $list_col; lines: $list_row; spacing: 8px; }" \
		-theme-str 'textbox-prompt-colon { str: "󰹑"; }' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "$theme"
}

# launch rofi
run_rofi() {
	echo -e \
		"$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# screenshot metadata
time=$(date +%Y-%m-%d-%H-%M-%S)

geometry=$(
	hyprctl monitors |
		awk -v RS="" '/focused: yes/ {
			match($0, /[0-9]+x[0-9]+@[0-9.]+/)
			print substr($0, RSTART, RLENGTH)
		}' |
			cut -d'@' -f1
		)

		dir="$(xdg-user-dir PICTURES)/Screenshots"
		file="screenshot_${time}_${geometry}.png"

# ensure directory exists
mkdir -p "$dir"

# notifications
notify_view() {
	local notify_cmd='dunstify -u low --replace=699'

	$notify_cmd "copied to clipboard"

	if [[ -e "$dir/$file" ]]; then
		$notify_cmd "screenshot saved"
	else
		$notify_cmd "screenshot deleted"
	fi
}

# clipboard copy
copy_shot() {
	wl-copy < "$file"
}

# countdown
countdown() {
	for sec in $(seq "$1" -1 1); do
		dunstify -t 1000 --replace=699 "taking shot in: $sec"
		sleep 1
	done
}

# full screen
shot_now() {
	cd "$dir" || exit
	sleep 0.5

	grim "$file" &&
		copy_shot

	notify_view
}

# delayed 5s
shot_5() {
	countdown 5

	cd "$dir" || exit
	sleep 1

	grim "$file" &&
		copy_shot

	notify_view
}

# delayed 10s
shot_10() {
	countdown 10

	cd "$dir" || exit
	sleep 1

	grim "$file" &&
		copy_shot

	notify_view
}

# active window
shot_window() {
	cd "$dir" || exit

	geom=$(
		hyprctl activewindow |
			awk '
		/at:/   { at=$2 }
		/size:/ {
			size=$2
			gsub(/,/, "x", size)
}
END {
	print at" "size
}
'
)

if [[ -n "$geom" && "$geom" != " " ]]; then
	grim -g "$geom" "$file" &&
		copy_shot

	notify_view
fi
}

# selected area
shot_area() {
	cd "$dir" || exit

	geom=$(slurp)

	if [[ -n "$geom" ]]; then
		grim -g "$geom" "$file" &&
			copy_shot

		notify_view
	fi
}

# actions
run_cmd() {
	case "$1" in
		--desktop)
			shot_now
			;;

		--area)
			shot_area
			;;

		--window)
			shot_window
			;;

		--5)
			shot_5
			;;

		--10)
			shot_10
			;;
	esac
}

# selection
chosen="$(run_rofi)"

case "$chosen" in
	"$option_1")
		run_cmd --desktop
		;;

	"$option_2")
		run_cmd --area
		;;

	"$option_3")
		run_cmd --window
		;;

	"$option_4")
		run_cmd --5
		;;

	"$option_5")
		run_cmd --10
		;;
esac
