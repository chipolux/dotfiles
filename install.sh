#!/bin/bash
set -e

# we may need aliases or other special secrets from here
if [ -s "$HOME/.private_profile" ]; then
    source "$HOME/.private_profile"
fi

# Install at least some of these tools eirst:
#   zsh
#   git
#   wget
#   curl
#   tmux
#   neovim
#   alacritty
#   kitty
#   ack
#   ripgrep
#   fd
#   rlwrap
#   ecl
#   asdf
#     python
#     sbcl

function join-by { local IFS="$1"; shift; echo "$*"; }

function setup () {
    echo "Moving dotfiles!"
    move-dot-files \
        "bashrc" \
        "profile" \
        "bash_profile" \
        "zshrc" \
        "shell_common" \
        "gitconfig" \
        "gitignore" \
        "tmux.conf" \
        "vimrc" \
        "ackrc" \
        "rtorrent.rc" \
        "taskrc" \
        "screenrc" \
        "ripgreprc" \
        "Xresources"

    echo "Getting tools!"
    if [ ! -d oh-my-zsh ]; then
        echo "    Getting oh-my-zsh!"
        git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git oh-my-zsh
    fi
    if [ ! -d tmux/plugins/tpm ]; then
        echo "    Getting tpm!"
        git clone --depth 1 https://github.com/tmux-plugins/tpm.git tmux/plugins/tpm
    fi
    if [ ! -f vim/autoload/plug.vim ]; then
        echo "    Getting plug.vim!"
        curl -fLo vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    if [ ! -d $HOME/.fzf ]; then
        echo "    Getting fzf!"
        git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    fi
    if [ ! -d $HOME/.quicklisp ] && [ -n "$(command -v sbcl)" ]; then
        echo "    Getting quicklisp!"
        curl -fLO https://beta.quicklisp.org/quicklisp.lisp
        sbcl --load install-quicklisp.lisp
    fi

    echo "Moving dotfolders!"
    move-dot-folders \
        "tmux" \
        "vim" \
        "oh-my-zsh" \
        "zsh-custom" \
        "mutt" \
        "task" \
        "fluxbox"

    echo "Setting up nvim config!"
    nvim_conf=$HOME/.config/nvim/init.vim
    mkdir -p $HOME/.config/nvim
    if [ -e $nvim_conf -a ! -h $nvim_conf ]; then
        mv -f $nvim_conf $nvim_conf.old
    fi
    ln -snf "$(pwd)/init.vim" $nvim_conf

    echo "Moving kitty config!"
    kitty_conf=$HOME/.config/kitty/kitty.conf
    mkdir -p $HOME/.config/kitty
    if [ -e $kitty_conf -a ! -h $kitty_conf ]; then
        mv -f $kitty_conf $kitty_conf.old
    fi
    ln -snf "$(pwd)/kitty.conf" $kitty_conf

    echo "Moving alacritty config!"
    alacritty_conf=$HOME/.config/alacritty/alacritty.toml
    mkdir -p $HOME/.config/alacritty
    if [ -e $alacritty_conf -a ! -h $alacritty_conf ]; then
        mv -f $alacritty_conf $alacritty_conf.old
    fi
    ln -snf "$(pwd)/alacritty.toml" $alacritty_conf

    echo "Touching mutt/aliases!"
    touch mutt/aliases

    if [ -n "$(command -v io.neovim.nvim)" ]; then
        echo "Linking neovim..."
        sudo ln -s $(which io.neovim.nvim) /usr/local/bin/nvim || true
    fi

    echo "Installing vim plugins!"
    if [ -n "$(command -v nvim)" ]; then
        echo "> Using nvim to install plugins..."
        nvim +PlugInstall +qall
    elif [ -n "$(command -v vim)" ]; then
        echo "> Using vim to install plugins..."
        vim +PlugInstall +qall
    else
        echo "> No vim or neovim found!"
    fi

    echo "Installing fzf!"
    $HOME/.fzf/install --key-bindings --completion --no-update-rc

    echo "Installing tmux terminfo!"
    tic -x tmux-terminfo.txt

    echo "Installing xterm terminfo!"
    tic -x xterm-terminfo.txt

    if [ -n "$(command -v zsh)" ]; then
        echo "Setting shell to zsh!"
        sudo chsh -s $(which zsh) $USER
    fi

    if [ -n "$(command -v task)" ] && [ -n "$(command -v timew)" ]; then
        echo "Setting up timewarrior hook..."
        mkdir -p $HOME/.task-data/hooks
        cp $HOME/.task/on-modify.timewarrior $HOME/.task-data/hooks/.
    fi
}

function move-dot-files () {
    for file in $@; do
        if [ -e $HOME/.$file -a ! -h $HOME/.$file ]; then
            mv -f $HOME/.$file $HOME/.$file.old
        fi
        ln -snf "$(pwd)/$file" $HOME/.$file
    done
}

function move-dot-folders () {
    for folder in $@; do
        if [ -d $HOME/.$folder -a ! -h $HOME/.$folder ]; then
            mv -f $HOME/.$folder $HOME/.$folder.old
        fi
        ln -snfF "$(pwd)/$folder" $HOME/.$folder
    done
}

setup
