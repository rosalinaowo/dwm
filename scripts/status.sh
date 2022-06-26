#!/bin/sh

# colors
. ~/src/dwm/scripts/themes/paradise

sep=$(printf "^c#bbbbbb^|^d^")

cpu() {
	usage=$(top -bn1 | grep Cpu | awk '{print $2}')
	printf "^c$blue^ ^d^^c$magenta^$usage%%^d^"
}

mem() {
	used=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
	printf "^c$blue^ ^d^^c$magenta^$used^d^"
}

vol() {
	vol=$(pamixer --get-volume-human | sed s/%//)
	if [ "$vol" = "muted" ]; then
		printf "^c$blue^ ^d^^c$magenta^$vol^d^"
	else
		if [ "$vol" -gt 0 ] && [ "$vol" -le 33 ];then
			printf "^c$blue^ ^d^^c$magenta^$vol%%^d^"
		elif [ "$vol" -gt 33 ] && [ "$vol" -le 66 ];then
			printf "^c$blue^ ^d^^c$magenta^$vol%%^d^"
		else
			printf "^c$blue^ ^d^^c$magenta^$vol%%^d^"
		fi
	fi
}

datetime() {
	date=$(date "+%a %d/%m/%y")
	time=$(date "+%H:%M")
	printf "^c$blue^ ^d^^c$magenta^$date^d^ $sep "
	printf "^c$blue^ ^d^^c$magenta^$time^d^"
}

while true; do
	sleep 1 && xsetroot -name "$(mem) $sep $(cpu) $sep $(vol) $sep $(datetime)"
done
