#!/bin/bash

menu=~/.fluxbox/application-menu
if [ -e $menu ]; then
    rm $menu
fi

app_path=$(which urxvt)
if [ $app_path ]; then
    echo "[exec] (urxvt) {$app_path} </usr/share/pixmaps/urxvt_32x32.xpm>" >> $menu
fi

app_path=$(which firefox)
if [ $app_path ]; then
    echo "[exec] (Firefox) {$app_path} </usr/share/pixmaps/firefox.png>" >> $menu
fi

app_path=$(which spyder)
if [ $app_path ]; then
    echo "[exec] (Spyder) {$app_path} </usr/share/pixmaps/spyder.png>" >> $menu
fi
