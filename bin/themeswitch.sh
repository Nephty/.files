#!/bin/bash

# use a lockfile to make sure only one instance is running
lockfile -r 0 /tmp/themeswitch.lock || exit 1

# themes="day dark"

# check if a valid theme is entered
if [ "${1,,}" != "day" ] && [ "${1,,}" != "dark" ]; then
    echo "Invalid theme."
    rm -f /tmp/themeswitch.lock
    exit
fi

# set vars as if it was day
newcolor="453745"
oldcolor="231515"
style=""

# if we asked for dark theme, change these vars accordingly
if [ "${1,,}" == "dark" ]; then
    newcolor="231515"
    oldcolor="453745"
    style="-dark"
fi

swaybg -i /home/Nephty/Pictures/Backgrounds/$newcolor\ Mountain.jpg & disown
sleep 0.4 # prevents the default hyperland background from being seen
ps -ef | grep swaybg | grep "$oldcolor" | awk '{print "kill "$2}' | sh
ps -ef | grep waybar | awk '{print "kill "$2}' | sh
waybar -l off -s /home/Nephty/.config/waybar/style$style.css & disown

sleep 1
rm -f /tmp/themeswitch.lock
