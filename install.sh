#!/bin/bash
set -e

function join-by { local IFS="$1"; shift; echo "$*"; }

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

    echo "Installing vim plugins!"
    vim +PlugInstall +qall

    echo "Installing tmux terminfo!"
    tic -x tmux-terminfo.txt

    echo "Installing xterm terminfo!"
    tic -x xterm-terminfo.txt

    zsh_path=$(which zsh)
    if [ $zsh_path ] && [ -e $zsh_path ]; then
        echo "Setting shell to zsh!"
        sudo chsh -s $zsh_path $USER
    fi

    weechat_path=$(which weechat)
    if [ $weechat_path ] && [ -e $weechat_path ]; then
        echo "Configuring weechat!"
        weechat_cmds=$(join-by ";" \
            "/set weechat.startup.display_logo off" \
            "/set weechat.startup.display_version off" \
            "/set weechat.look.mouse on" \
            "/set weechat.look.buffer_notify_default message" \
            "/set weechat.look.color_inactive_buffer off" \
            "/set weechat.look.color_inactive_window off" \
            "/set weechat.look.prefix_align_max 13" \
            "/set weechat.look.prefix_same_nick ' '" \
            "/set weechat.bar.nicklist.size_max 15" \
            "/set weechat.bar.status.color_bg black" \
            "/set weechat.bar.title.color_bg black" \
            "/set weechat.color.chat 179" \
            "/set weechat.bar.input.color_fg 48" \
            "/set fset.color.line_selected_bg1 237" \
            "/set buflist.format.buffer_current '\\\${color:,237}\\\${format_buffer}'" \
            "/set irc.look.smart_filter on" \
            "/filter add irc_smart * irc_smart_filter *" \
            "/filter add joinquit * irc_join,irc_part,irc_quit *" \
            "/set irc.server_default.msg_part ''" \
            "/set irc.server_default.msg_quit ''" \
            "/set irc.server_default.nicks 'chipolux,chip'" \
            "/set irc.server_default.username 'chipolux'" \
            "/set irc.server_default.realname 'nakyle'" \
            "/server add freenode chat.freenode.net/6697 -ssl" \
            "/set irc.server.freenode.autoconnect yes" \
            "/set irc.server.freenode.autojoin #reddit-anime,#python,#powershell" \
            "/server add rizon irc.rizon.net/6697 -ssl" \
            "/set irc.server.rizon.autoconnect yes" \
            "/set irc.server.rizon.autojoin #horriblesubs" \
            "/quit")
        weechat -r "$weechat_cmds"
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
