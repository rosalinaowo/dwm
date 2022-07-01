#!/bin/sh

sep=$(printf "|")

Cpu() {
	usage=$(top -bn1 | grep Cpu | awk '{print $2}')
	printf "$usage%%"
}

Mem() {
	used=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
	printf "$used"
}

Vol() {
	vol=$(pamixer --get-volume-human)
	if [ "$vol" = "muted" ]; then
		printf "Muted"
	else
		printf "$vol%"
	fi
}

Time() {
	time=$(date "+%H:%M")
	printf "$time"
}

Date() {
	date=$(date "+%b %d")
	printf "$date"
}

while true; do
	sleep 1 && xsetroot -name "$(Mem) $sep $(Cpu) $sep $(Vol) $sep $(Date) $(Time)"
done
