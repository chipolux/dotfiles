# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh-custom

ZSH_THEME="steeef"
#ZSH_THEME="candy"
#ZSH_THEME="ys"

# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
ZSH_DISABLE_COMPFIX="true"

plugins=(git brew rust macos asdf fzf tmux iterm2)

source $ZSH/oh-my-zsh.sh

# User configuration

# Load .shell_common if exist since aliases,
# path changes and stuff live there
if [ -s "$HOME/.shell_common" ]; then
    source "$HOME/.shell_common"
fi

# function to remove all docker state
unset -f docker-purge 2>> /dev/null
function docker-purge () {
    read "?Are you sure you want to purge? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            docker rmi --force $(docker images --all --quiet)
            docker rm --force $(docker ps --all --quiet)
            docker volume rm --force $(docker volume ls --quiet)
            docker system prune --all --force --volumes
            ;;
        *)
            echo Cancelling...
            ;;
    esac
}

# Disable beeping
setopt no_beep

# Don't share history between terminals
setopt no_share_history
setopt no_inc_append_history

# Leave glob unexpanded when no results
setopt no_nomatch

# Don't close the terminal on Ctrl+D
setopt ignoreeof

# Don't autocomplete some filetypes for vim
zstyle ':completion:*:*:*vi*:*' file-patterns '^*.(qmlc|jsc):source-files' '*:all-files'

# Load fzf completions/keybinds
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
