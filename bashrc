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
alias grpy='grep -r --include={"*.py","*.pyw"} --exclude-dir="migrations"'
alias grjs='grep -r --include={"*.js","*.json"} --exclude-dir={bin,node_modules,vendor,app-components}'
alias grhtml='grep -r --include="*.html" --exclude-dir={bin,node_modules,vendor,app-components}'
alias grcss='grep -r --include={"*.css","*.less"} --exclude-dir={bin,node_modules,vendor,app-components}'
alias grc='grep -r --include={"*.c","*.h","*.cpp"}'

# useful aliases
alias lt='ls -lth'
alias rsync='rsync -h --progress --partial'

# mutt aliases
alias mail-personal='mutt -F ~/.mutt/personal.muttrc'
alias mail-newmedio='mutt -F ~/.mutt/newmedio.muttrc'
alias mail-summit='mutt -F ~/.mutt/summit.muttrc'

# open all modified files in git repo with vim (need to be at root of repo)
alias git-modified='git status --porcelain | sed -ne "s/^ M //p"'
#alias open-modified='git-modified | tr "\n" "\0" | tr -d "\"" | xargs -0 vim'
alias open-modified='vim `git-modified`'

# docker stuff
alias b2d-init='$(boot2docker shellinit)'
alias b2d-time='boot2docker ssh "sudo ntpclient -s -h pool.ntp.org"'
alias drm='docker rm'
alias dri='docker rmi'
alias dps='docker ps'
function da () {
    docker start $1 && docker attach $1
}
alias esp8266-build='docker run --rm -ti -v $(pwd):/home/esp8266/project chipolux/esp8266-buildbox'

# Don't close terminal on Ctrl+D
export IGNOREEOF=2

# Coloring on some systems for ls
# http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export CLICOLOR=1
export LSCOLORS=GxfxcxdxbxAgAdabagacad
