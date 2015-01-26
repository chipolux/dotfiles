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
venvwrapper=`which virtualenvwrapper.sh`
if [ -s $venvwrapper -a -z "$VIRTUAL_ENV" ]; then
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

# project specific greps
alias grpy='grep -r --include="*.py" --exclude-dir="migrations"'
alias grjs='grep -r --include="*.js" --exclude-dir={bin,node_modules,vendor,app-components}'
alias grhtml='grep -r --include="*.html" --exclude-dir={bin,node_modules,vendor,app-components}'
alias grcss='grep -r --include="*.css" --exclude-dir={bin,node_modules,vendor,app-components}'

# lt instances
alias lt='ls -lth'

# mutt aliases
alias mail-personal='mutt -F ~/.mutt/personal.muttrc'
alias mail-newmedio='mutt -F ~/.mutt/newmedio.muttrc'

# Coloring
#export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
