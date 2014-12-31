# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

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

# Set local bins before system bins
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# RVM
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    # Load RVM into a shell session *as a function*
    source "$HOME/.rvm/scripts/rvm"
    # Add RVM to PATH for scripting
    export PATH="$PATH:$HOME/.rvm/bin"
fi

# calibre command line tools
if [ -s "/Applications/calibre.app/Contents/MacOS/calibre" ]; then
    export PATH="/Applications/calibre.app/Contents/MacOS:$PATH"
fi

# virtualenvwrapper
if [ -s "/usr/local/bin/virtualenvwrapper.sh" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    source /usr/local/bin/virtualenvwrapper.sh
fi

# autoenv
if [ -s "/usr/local/opt/autoenv/activate.sh" ]; then
    source /usr/local/opt/autoenv/activate.sh
fi

# Don't share history between terminals
setopt no_share_history
setopt no_inc_append_history

# Leave glob unexpanded when no results
setopt no_nomatch

# project specific greps
alias grpy='grep -r --include="*.py" --exclude-dir="migrations"'
alias grjs='grep -r --include="*.js" --exclude-dir={bin,node_modules,vendor,app-components}'
alias grhtml='grep -r --include="*.html" --exclude-dir={bin,node_modules,vendor,app-components}'
alias grcss='grep -r --include="*.css" --exclude-dir={bin,node_modules,vendor,app-components}'

