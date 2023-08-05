#!/usr/bin/env bash

# list available devices
echo "Connecting to all available devices..."
devices="$(adb devices)"

export IFS=$'\n'

declare -a devicemap

i=0

# iterate for each device and connect
for word in $devices; do
	
	# device id
	device=("$(echo $word | awk '{print $1}')")
	
	# skip the first line
	if [ "$i" != "0" ]; then

		echo "---"

		devicename="$(adb devices -l | grep $device | awk '{print $4}' | cut -d: -f2)"
		devicemodel="$(adb devices -l | grep $device | awk '{print $5}' | cut -d: -f2)"

		echo "Connecting to device $device $devicename $devicemodel..."

		# restart adb in tcpip mode for the device
		adb -s $device tcpip 5555

		# wait for adb to restart
		# note: this may change depending on the machine
		sleep 5s

		# find out the wlan ip of the device by running ifconfig in device's shell
		# ip="$(adb -s $device shell ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')"
		# new version
		ip="$(adb -s $device shell ip -f inet addr show wlan0 | grep 'inet' | cut -d: -f2 | awk '{print $2}')"
		ip=${ip%/*}
		echo "Connecting to $ip..."

		# connect to the device
		adb connect $ip:5555

	fi
	
	i=$((i+1))
	done