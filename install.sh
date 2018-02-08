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

    echo "Cloning tools!"
    if [ ! -d oh-my-zsh ]; then
        git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git oh-my-zsh
    fi
    if [ ! -d tmux/plugins/tpm ]; then
        git clone --depth 1 https://github.com/tmux-plugins/tpm.git tmux/plugins/tpm
    fi
    if [ ! -d vim/autoload/plug.vim ]; then
        curl -fLo vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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

    echo "Moving weechat stuff!"
    move-weechat-stuff

    echo "Installing vim plugins!"
    vim +PlugInstall +qall

    echo "Installing tmux terminfo!"
    tic -x tmux-terminfo.txt

    zsh_path=$(which zsh)
    if [ -e $zsh_path ]; then
        echo "Setting shell to zsh!"
        sudo chsh -s $zsh_path $USER
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
