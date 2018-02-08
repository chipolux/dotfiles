#!/bin/bash

# Install/Upgrade tools on OSX, you have to do EXTRAS and CASKS yourself.

FORMULAS=(
    "ack"
    "entr"
    "ffmpeg"
    "git"
    "gnu-sed"
    "graphviz"
    "links"
    "macvim"
    "make"
    "mutt"
    "reattach-to-user-namespace"
    "rlwrap"
    "rsync"
    "task"
    "tmux"
    "tree"
    "vim"
    "watch"
    "weechat"
    "wget"
    "youtube-dl"
    "zsh"
)

EXTRAS=(
    "clisp"
    "clozure-cl"
    "gcc"
    "mosh"
    "net-snmp"
    "nmap"
    "python"
    "python3"
    "sbcl"
)

CASKS=(
    "blender"
    "firefox"
    "godot"
    "google-chrome"
    "hex-fiend"
    "iterm2"
    "keka"
    "libreoffice"
    "licecap"
    "macsvg"
    "osxfuse"
    "powershell"
    "sequel-pro"
    "slack"
    "soundcleod"
    "spectacle"
    "spotify"
    "steam"
    "tunnelblick"
    "virtualbox"
    "vlc"
    "wireshark"
    "yed"
)

for formula in ${FORMULAS[@]}; do
    if [ $formula == "macvim" ]; then
        formula="$formula --with-python3"
    elif [ $formula == "vim" ]; then
        formula="$formula --with-python3"
    fi

    if [ "$1" == "install" ]; then
        brew install $formula
    elif [ "$1" == "upgrade" ]; then
        brew upgrade $formula
    fi
done
