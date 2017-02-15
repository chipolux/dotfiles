#!/bin/bash

function setup () {
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
        "ackrc" \
        "rtorrent.rc" \
        "taskrc" \
        "Xresources"

    echo "Moving dotfolders!"
    move-dot-folders \
        "tmux" \
        "vim" \
        "oh-my-zsh" \
        "mutt" \
        "task" \
        "fluxbox"

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
            # Backup existing config
            mv -f $HOME/.weechat/$file $HOME/.weechat/$file.old
        fi

        if [ -e $HOME/.weechat/$file.old ]; then
            # Create new config based on backup and customizations
            $(pwd)/weechat/set_options.py \
                $HOME/.weechat/$file.old \
                $(pwd)/weechat/$file \
                $HOME/.weechat/$file
            if [ $? != 0 ]; then
                # Failed to setup new config, replace original
                mv -f $HOME/.weechat/$file.old $HOME/.weechat/$file
            fi
        fi
    done
}

setup
