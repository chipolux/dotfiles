#!/bin/bash

modules=("oh-my-zsh"
         "tmux/plugins/tpm"
         "vim/bundle/editorconfig-vim"
         "vim/bundle/vim-airline"
         "vim/bundle/vim-clojure-static"
         "vim/bundle/vim-colors-solarized"
         "vim/bundle/vim-javascript-syntax"
         "vim/bundle/vim-json"
         "vim/bundle/vim-markdown"
         "vim/bundle/vim-pathogen")

for module in "${modules[@]}"; do
    pushd $module
    git pull origin master
    popd > /dev/null
done

pushd "vim/bundle/python-mode"
git pull origin develop
popd > /dev/null
