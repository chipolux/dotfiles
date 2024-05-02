#!/bin/bash
if [ -z "${TOOLBOX_PATH}" ] && [ -s "$HOME/.shell_common" ]; then
    source "$HOME/.shell_common"
fi
