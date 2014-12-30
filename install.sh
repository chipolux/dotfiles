#!/bin/bash

files=("bash_profile"
       "gitconfig"
       "gitignore"
       "tmux.conf"
       "vimrc"
       "zshrc")

for file in files; do
    ln -snf "$(pwd)/$file" ~/.$file
done

folders=("tmux"
         "vim")

for folder in folders; do
    ln -snfF "$(pwd)/$folder" ~/.($folder)
done

git submodule update --init --recursive
