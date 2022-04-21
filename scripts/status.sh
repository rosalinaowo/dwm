#!/bin/sh

# colors
. themes/paradise

sep=" | "

cpu() {
	usage=$(top -bn1 | grep Cpu | awk '{print $2}')\%%
	printf "^c$blue^ ^d^ ^c$magenta^$usage^d^"
}

mem() {
	used=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
	printf "^c$blue^ ^d^ ^c$magenta^$used^d^"
}

vol() {
	vol=$(pamixer --get-volume-human | sed s/%//)
	printf "^c$blue^ ^d^ ^c$magenta^$vol%%^d^"
}

datetime() {
	date=$(date "+%a %d/%m/%y")
	time=$(date "+%H:%M")
	printf "^c$blue^ ^d^ ^c$magenta^$date^d^ "
	printf "^c$blue^ ^d^ ^c$magenta^$time^d^"
}

while true; do
	sleep 1 && xsetroot -name "$(mem) $(cpu) $(vol) $(datetime)"
done
