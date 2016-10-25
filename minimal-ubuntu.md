# Setting Up Minimal Ubuntu Machine
1. Download minimal iso [here](https://help.ubuntu.com/community/Installation/MinimalCD).
    * Alternatively you can use the server install if you need UEFI.
    * You can also use the regular distro with a command-line only system.
2. Install onto your machine, vm, whatever.
    * Later on I plan on making an touchless setup configuration.
    * Select OpenSSH server on package selection if you need it.
3. Disable hibernation:
    * `sudo rm /etc/initramfs-tools/conf.d/resume`
    * `sudo update-initramfs -u`
4. Ensure you're up to date:
    * `sudo apt-get update`
    * `sudo apt-get dist-upgrade`
    * `sudo apt-get upgrade`
    * `sudo apt-get clean`
5. Install core utilities:
    * zsh
    * tmux
    * git
    * vim
6. Install graphical environment (if you want it): 
    * xorg
    * fluxbox
    * rxvt-unicode-256color
7. Get these dotfiles:
    * `git clone https://github.com/chipolux/dotfiles.git .dotfiles`
    * `cd .dotfiles && ./install.sh`


# Setting Up Passwordless Sudo
Only do this if you're absolutely sure you know what you're doing!

`sudo vim /etc/sudoers` and add `username ALL=(ALL:ALL) NOPASSWD:ALL` to the 
bottom, changing username of course.


# Setting Up Auto Login
Only do this if you know exactly what you're doing! This only works on systemd
systems, so newer Ubuntu releases are good.

Install mingetty: `sudo apt-get install mingetty`
Create and open a unit: `sudo systemctl edit getty@tty1`, or
edit the existing unit at `/etc/systemd/system/getty@tty1.service.d/override.conf`.
Add these lines (swapping username as appropriate):
```
[Service]
ExecStart=
ExecStart=-/sbin/mingetty --autologin username --noclear %I $TERM
```

Now when you boot up it should automatically start tty1 with your user. You can
use normal profile scripts to `startx` etc.

Check out [this](https://wiki.archlinux.org/index.php/Getty#Automatic_login_to_virtual_console) for more info and details.
