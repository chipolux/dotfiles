#!/bin/bash
if [ -s "$HOME/.shell_common" ]; then
    source "$HOME/.shell_common"
fi

# Load fzf completions/keybinds
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
