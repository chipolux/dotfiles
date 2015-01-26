#!/bin/bash

files=("bashrc"
       "profile"
       "bash_profile"
       "gitconfig"
       "gitignore"
       "tmux.conf"
       "vimrc"
       "zshrc"
       "mailcap")

for file in "${files[@]}"; do
    if [ -e $HOME/.$file -a ! -h $HOME/.$file ]; then
        mv -f $HOME/.$file $HOME/.$file.old
    fi
    ln -snf "$(pwd)/$file" $HOME/.$file
done

folders=("tmux"
         "vim"
         "oh-my-zsh"
         "mutt")

for folder in "${folders[@]}"; do
    if [ -d $HOME/.$folder -a ! -h $HOME/.$folder ]; then
        mv -f $HOME/.$folder $HOME/.$folder.old
    fi
    ln -snfF "$(pwd)/$folder" $HOME/.$folder
done

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

git submodule update --init --recursive
