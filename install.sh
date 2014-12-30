#!/bin/bash

files=("bash_profile"
       "gitconfig"
       "gitignore"
       "tmux.conf"
       "vimrc"
       "zshrc")

for file in "${files[@]}"; do
    ln -snf "$(pwd)/$file" $HOME/.$file
done

folders=("tmux"
         "vim"
         "oh-my-zsh")

for folder in "${folders[@]}"; do
    ln -snfF "$(pwd)/$folder" $HOME/.$folder
done

git submodule update --init --recursive
