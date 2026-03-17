#!/bin/bash
if [ ! -e /run/.containerenv ] && [ -z "${TOOLBOX_PATH}" ] && [ -s "$HOME/.shell_common" ]; then
    source "$HOME/.shell_common"
elif [ -e /run/.containerenv ] && [ -s "$HOME/.toolbox_profile" ]; then
    source "$HOME/.toolbox_profile"
elif [ ! -z "${TOOLBOX_PATH}" ] && [ -s "$HOME/.toolbox_profile" ]; then
    source "$HOME/.toolbox_profile"
fi
