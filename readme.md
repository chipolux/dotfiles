Just some dotfiles.

Most things should just work out-of-the-box as long as you have up to date
versions of vim, zsh, weechat, mutt, and tmux.

Just run the `install.sh` script to get things setup!

## URxvt and Colors
Colors in vim and tmux may not look right unless you have rxvt-unicode-256color
installed.

## Latest Versions
On Ubuntu the latest versions of tmux and weechat aren't always in the default
repos, but you can add `ppa:pi-rho/dev` for tmux and `ppa:nesthib/weechat-stable`
for weechat.

## Mutt
When using mutt for email it seems best to install from source to enable all
the features we want.

```
> wget ftp://ftp.mutt.org/pub/mutt/mutt-1.10.1.tar.gz
> tar zxf mutt-1.10.1.tar.gz
> cd mutt-1.10.1
> ./configure --enable-pop --enable-imap --enable-smtp --enable-hcache --with-ssl --with-sasl
> # handle any missing dependencies like tokyocabinet, ssl, etc.
> sudo make install
```
