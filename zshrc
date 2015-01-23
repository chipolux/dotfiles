# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="steeef"
#ZSH_THEME="candy"
#ZSH_THEME="ys"

CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git heroku osx brew)

source $ZSH/oh-my-zsh.sh

# User configuration

# Load .bashrc if exist since aliases,
# path changes and stuff live there
if [ -s "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# Don't share history between terminals
setopt no_share_history
setopt no_inc_append_history

# Leave glob unexpanded when no results
setopt no_nomatch
