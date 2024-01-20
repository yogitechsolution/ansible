#!/bin/sh

ping -Ippp0 -c1 -w5 google.com > /dev/null 2>&1
if [ $? -ne 0 ]; then
	PID=$(pidof pppd)
	kill -s HUP $PID
fi
