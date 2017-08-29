#!/bin/bash

menu=~/.fluxbox/application-menu
if [ -e $menu ]; then
    rm $menu
fi

function add-to-menu () {
    app_path=$(which $1)
    app_name=$2
    icon_path=$3
    if [ $app_path ]; then
        echo "[exec] ($app_name) {$app_path} <$icon_path>" >> $menu
    fi
}

add-to-menu "urxvt" "urxvt" "/usr/share/pixmaps/urxvt_32x32.xpm"

add-to-menu "firefox" "Firefox" "/usr/share/pixmaps/firefox.png"
add-to-menu "google-chrome" "Chrome" "/usr/share/icons/hicolor/32x32/apps/google-chrome.png"
add-to-menu "chromium-browser" "Chromium" "/usr/share/pixmaps/chromium-browser.png"

add-to-menu "spyder" "Spyder" "/usr/share/pixmaps/spyder.png"
add-to-menu "virtualbox" "VirtualBox" "/usr/share/pixmaps/virtualbox.xpm"

add-to-menu "steam" "Steam" "/usr/share/pixmaps/steam.png"
add-to-menu "discord" "Discord" "/usr/share/pixmaps/discord.png"

add-to-menu "gimp" "Gimp" "/usr/share/pixmaps/gimp.xpm"

add-to-menu "cura" "Cura" "/usr/share/cura/resources/images/c.png"
add-to-menu "blender" "Blender" "/usr/share/pixmaps/blender-32x32.xpm"
add-to-menu "solvespace" "SolveSpace" "/usr/local/share/pixmaps/solvespace-32x32.xpm"
