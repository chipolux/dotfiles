#!/bin/bash
if [ -z "${TOOLBOX_PATH}" ] && [ -s "$HOME/.shell_common" ]; then
    source "$HOME/.shell_common"
elif [ ! -z "${TOOLBOX_PATH}" ] && [ -s "$HOME/.toolbox_profile" ]; then
    source "$HOME/.toolbox_profile"
fi
