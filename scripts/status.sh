#!/bin/sh

sep=$(printf "|")

Cpu() { printf "$(top -bn1 | grep Cpu | awk '{print $2}')%%"; }

Mem() { printf "$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"; }

Vol() {
	vol=$(pamixer --get-volume-human)
	if [ "$vol" = "muted" ]; then
		printf "Muted"
	else
		printf "$vol%"
	fi
}

Time() { printf "$(date "+%H:%M")"; }

Date() { printf "$(date "+%a, %d %b")"; }

: 'Battery() {
	status=$(cat /sys/class/power_supply/BAT0/status)
	capacity=$(cat /sys/class/power_supply/BAT0/capacity)
	if [ "$status" = "Full" ]; then
		printf "$status"
	elif [ "$status" = "Charging" ]; then
		printf "$status $capacity%%"
	else
		printf "$status $capacity%%"
	fi
}'

while true; do
	sleep 1 && xsetroot -name "$(Mem) $sep $(Cpu) $sep $(Vol) $sep $(Date) $(Time)"
done
