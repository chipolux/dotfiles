# Load .profile and .bashrc if exist
if [ -s "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

if [ -s "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# Set local bin before system bin
export PATH="/usr/local/bin:$PATH"

# Add sbin to path
export PATH="/usr/local/sbin:$PATH"

# Coloring
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# virtualenvwrapper
if [ -s "/usr/local/bin/virtualenvwrapper.sh" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    source /usr/local/bin/virtualenvwrapper.sh
fi
