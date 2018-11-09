#!/bin/bash

# when ran from cron we need to figure out the current gnome session's dbus
# bus address and set that up so gsettings will work
PID=$(pgrep -f "gnome-session" | tail -n1)
BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ | cut -d= -f2-)

FOLDERS=("$HOME/Pictures/backgrounds")
IMAGES=()

for folder in ${FOLDERS[@]}; do
    IMAGES+=$(find $folder -iname "*.png" -o -iname "*.jpg")
done

IMAGE=$(shuf -e -n 1 $IMAGES)
DBUS_SESSION_BUS_ADDRESS=$BUS_ADDRESS gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE"

echo $(date +"%FT%T") \"$IMAGE\"
