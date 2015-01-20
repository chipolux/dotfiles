#!/bin/bash

files=("bash_profile"
       "gitconfig"
       "gitignore"
       "tmux.conf"
       "vimrc"
       "zshrc")

for file in "${files[@]}"; do
    if [ -s $HOME/.$file ]; then
        mv -f $HOME/.$file $HOME/.$file.old
    fi
    ln -snf "$(pwd)/$file" $HOME/.$file
done

folders=("tmux"
         "vim"
         "oh-my-zsh")

for folder in "${folders[@]}"; do
    if [ -s $HOME/.$folder ]; then
        mv -f $HOME/.$folder $HOME/.$folder.old
    fi
    ln -snfF "$(pwd)/$folder" $HOME/.$folder
done

weechat=("irc.conf"
         "weechat.conf")

for file in "${weechat[@]}"; do
    if [ -s $HOME/.weechat/$file ]; then
        mv -f $HOME/.weechat/$file $HOME/.weechat/$file.old
        python $(pwd)/weechat/set_options.py \
            $HOME/.weechat/$file.old \
            $(pwd)/weechat/$file \
            $HOME/.weechat/$file
    fi
done

git submodule update --init --recursive
