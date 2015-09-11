#!/bin/bash

function setup-minimal () {
    echo "Moving minimal dotfiles!"
    mv vimrc-min vimrc
    mv bashrc-min bashrc
    mv tmux.conf-min tmux.conf

    echo "Moving dotfiles!"
    move-dot-files \
        "bashrc" \
        "profile" \
        "bash_profile" \
        "gitconfig" \
        "gitignore" \
        "tmux.conf" \
        "vimrc" \
        "zshrc"

    echo "Moving dotfolders!"
    move-dot-folders \
        "tmux" \
        "vim" \
        "oh-my-zsh"

    echo "Getting submodules!"
    git submodule update --init --recursive oh-my-zsh
}

function setup-normal () {
    echo "Moving dotfiles!"
    move-dot-files \
        "bashrc" \
        "profile" \
        "bash_profile" \
        "gitconfig" \
        "gitignore" \
        "tmux.conf" \
        "vimrc" \
        "zshrc" \
        "rtorrent.rc"

    echo "Moving dotfolders!"
    move-dot-folders \
        "tmux" \
        "vim" \
        "oh-my-zsh" \
        "mutt"

    echo "Moving weechat stuff!"
    move-weechat-stuff

    echo "Getting submodules!"
    git submodule update --init --recursive

    echo "Installing vim plugins!"
    vim +PluginInstall +qall
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

function move-weechat-stuff () {
    weechat=("irc.conf"
             "weechat.conf")

    for file in "${weechat[@]}"; do
        if [ -e $HOME/.weechat/$file ]; then
            mv -f $HOME/.weechat/$file $HOME/.weechat/$file.old
            python $(pwd)/weechat/set_options.py \
                $HOME/.weechat/$file.old \
                $(pwd)/weechat/$file \
                $HOME/.weechat/$file
        fi
    done
}

if [ "$1" == "minimal" ]; then
    echo "Minimal setup..."
    setup-minimal
else
    echo "Standard setup..."
    setup-normal
fi
