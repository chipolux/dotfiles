PARTS=("/usr/local/bin"
       "/usr/local/sbin"
       "/opt/local/bin"
       "/opt/local/sbin"
       "$HOME/.local/bin")

for PART in "${PARTS[@]}"; do
    if [[ -e $PART && ":$PATH:" != *":$PART:"* ]]; then
        export PATH="$PART:$PATH"
    fi
done

# Set Postgres stuff
if [ -d "/usr/local/var/postgres" ]; then
    export PGDATA="/usr/local/var/postgres"
fi

# virtualenvwrapper
venvwrapper=$(which virtualenvwrapper.sh)
if [ -f ~/.local/bin/virtualenvwrapper.sh ]; then
    venvwrapper=~/.local/bin/virtualenvwrapper.sh
fi

if [ $venvwrapper ] && [ -s $venvwrapper ] && [ -z $VIRTUAL_ENV ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    source $venvwrapper
fi

# Ack-grep to ack
if [ -s "$(which ack-grep)" ]; then
    alias ack='ack-grep'
fi

# useful aliases
alias lt='ls -lth'
alias rsync='rsync -h --progress --partial'
alias gvir='gvim --remote'

# mutt aliases
alias mail-personal='mutt -F ~/.mutt/personal.muttrc'
alias mail-summit='mutt -F ~/.mutt/summit.muttrc'

# always try to use imagemagick with feh
alias feh='feh --magick-timeout 1 --geometry 500x500'

# Don't close terminal on Ctrl+D
export IGNOREEOF=2

# Coloring on some systems for ls
# http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export CLICOLOR=1
export LSCOLORS=GxfxcxdxbxAgAdabagacad

if [ $TERM = "screen" ]; then
    export TERM=screen-256color
fi

if [ $TERM = "xterm-kitty" ]; then
    alias ssh="kitty +kitten ssh"
fi

export EDITOR=vim

# If there is stuff like API tokens, keys, etc that need to be put in the
# environment, put them in ~/.private_profile and this will source them in
if [ -s "$HOME/.private_profile" ]; then
    source "$HOME/.private_profile"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
