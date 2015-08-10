Just some dotfiles.

Most things should just work out-of-the-box as long as you have up to date
versions of vim, zsh, weechat, mutt, and tmux.

##Upgrading TMUX on Ubuntu

TMUX on Ubuntu is at 1.8 right now which is a little old. You need 1.9+ for
things like TPM to function properly.

You can either follow the source install instructions from
[here](http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/README).

Or you can add the pi-rho dev repository and install from there:

1. `sudo apt-get install -y software-properties-common python-software-properties`
2. `sudo add-apt-repository -y ppa:pi-rho/dev`
3. `sudo apt-get update`
4. `sudo apt-get install -y tmux`

You should get 1.9a if you run `tmux -V`, and then all will be well in the world.
