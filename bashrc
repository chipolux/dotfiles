# Prepend local bin to path
if [ -d "/usr/local/bin" ]; then
    export PATH="/usr/local/bin:$PATH"
fi

# Prepend local sbin to path
if [ -d "/usr/local/sbin" ]; then
    export PATH="/usr/local/sbin:$PATH"
fi

# Prepend opt local bin to path
if [ -d "/opt/local/bin" ]; then
    export PATH="/opt/local/bin:$PATH"
fi

# Prepend opt local sbin to path
if [ -d "/opt/local/sbin" ]; then
    export PATH="/opt/local/sbin:$PATH"
fi

# Set Postgres stuff
if [ -d "/usr/local/var/postgres" ]; then
    export PGDATA="/usr/local/var/postgres"
fi

# RVM stuff
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    source "$HOME/.rvm/scripts/rvm"
    export PATH="$PATH:$HOME/.rvm/bin"
fi

# calibre command line tools
if [ -s "/Applications/calibre.app/Contents/MacOS/calibre" ]; then
    export PATH="/Applications/calibre.app/Contents/MacOS:$PATH"
fi

# virtualenvwrapper
venvwrapper=`which virtualenvwrapper.sh`
if [ -s $venvwrapper ]; then
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

# Coloring
#export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
