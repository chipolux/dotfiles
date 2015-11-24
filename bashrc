PARTS=("/usr/local/bin"
       "/usr/local/sbin"
       "/opt/local/bin"
       "/opt/local/sbin")

for PART in "${PARTS[@]}"; do
    if [[ -e $PART && ":$PATH:" != *":$PART:"* ]]; then
        export PATH="$PART:$PATH"
    fi
done

# Set Postgres stuff
if [ -d "/usr/local/var/postgres" ]; then
    export PGDATA="/usr/local/var/postgres"
fi

# RVM stuff
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    source "$HOME/.rvm/scripts/rvm"
    PART="$HOME/.rvm/bin"
    if [[ -e $PART && ! ":$PATH:" == *":$PART:"* ]]; then
        export PATH="$PATH:$PART"
    fi
fi

# calibre command line tools
if [ -s "/Applications/calibre.app/Contents/MacOS/calibre" ]; then
    PART="/Applications/calibre.app/Contents/MacOS"
    if [[ -e $PART && ! ":$PATH:" == *":$PART:"* ]]; then
        export PATH="$PART:$PATH"
    fi
fi

# virtualenvwrapper
venvwrapper=$(which virtualenvwrapper.sh)
if [ $venvwrapper ] && [ -s $venvwrapper -a -z $VIRTUAL_ENV ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    source $venvwrapper
fi

# Foreman (and ports) stuff
if [ -s "$(which forego)" ]; then
    alias frun='forego run'
    alias fpython='frun python'
elif [ -s "$(which foreman)" ]; then
    alias frun='foreman run'
    alias fpython='frun python'
fi

# useful aliases
alias lt='ls -lth'
alias rsync='rsync -h --progress --partial'

# mutt aliases
alias mail-personal='mutt -F ~/.mutt/personal.muttrc'
alias mail-newmedio='mutt -F ~/.mutt/newmedio.muttrc'
alias mail-summit='mutt -F ~/.mutt/summit.muttrc'

# docker stuff
alias b2d-init='$(boot2docker shellinit)'
alias b2d-time='boot2docker ssh "sudo ntpclient -s -h pool.ntp.org"'

# Don't close terminal on Ctrl+D
export IGNOREEOF=2

# Coloring on some systems for ls
# http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export CLICOLOR=1
export LSCOLORS=GxfxcxdxbxAgAdabagacad

if [ $TERM = "screen" ]; then
    export TERM=screen-256color
fi

# If there is stuff like API tokens, keys, etc that need to be put in the
# environment, put them in ~/.private_profile and this will source them in
if [ -s "$HOME/.private_profile" ]; then
    source "$HOME/.private_profile"
fi
