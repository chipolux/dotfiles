# Setting Up Minimal Raspberry Pi 3
Get miniban [here](https://minibianpi.wordpress.com/setup/).

Extract and use `dd` to copy it to a SD card.

* OSX
    * `diskutil list`
    * `diskutil unmountDisk /dev/disk*`
    * `sudo dd if=miniban.img of=/dev/rdisk* bs=32m`

Slap the SD card in the pi and boot it up.

Expand the disk:
Edit partitions using `fdisk /dev/mmcblk0`, list them with `p`, delete the 2nd one
with `d`, then re-create it with `n` as a primary partition, starting at the offset
you saw in the `p` list, and ending at the end of the drive (leave it blank). Then
use `w` to write, you'll get an error that the device is in use, is fine.
Now reboot so that new partition table takes effect. Once you're back in use
`resize2fs /dev/mmcblk0p2` to expand the filesystem to fit the partition. You can
verify using `df -h`!

This will probably take a long time but it's best to make sure everything is
up to date: `apt-get update && apt-get dist-upgrade`

Install sudo: `apt-get install sudo`

Edit `/etc/sudoers/` to let sudo group not require password (if you want):
`%sudo  ALL=(ALL:ALL) NOPASSWD:ALL`

Create a user, `adduser some-guy` for example.

Add the your user to the sudo group: `usermod -a -G sudo some-guy`

Disable root ssh login: `vi /etc/ssh/sshd_config` and `PermitRootLogin no`

Change root password using `passwd`

Install apt-utils, `apt-get install apt-utils`

Configure locals: `dpkg-reconfigure locales`

Configure keyboard: `dpkg-reconfigure keyboard-configuration`

Configure timezone: `dpkg-reconfigure tzdata`

Install python: `apt-get install python3` (currently this is 3.4.2)

Install pip: `wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py`

For GUI, look at minimal-ubuntu setup, but the jist is `apt-get install xorg`,
setup a profiles `~/.xinitrc` to run a GUI app (or install a window manager),
then edit an accounts `~/.profile` to `startx &> /dev/null`.


# Setting Up WiFi and Bluetooth
Install WiFi and Bluetooth firmware: `apt-get install firmware-brcm80211 pi-bluetooth`

Install wpa support: `apt-get install wpasupplicant`

Install some useful WiFi cmdline tools: `apt-get install wireless-tools`

You can scan for networks like: `sudo iwlist wlan0 scan | grep ESSID`

Now adjust your `/etc/network/interfaces` to contain:
```
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
```

And add a config in `/etc/wpa_supplicant/wpa_supplicant.conf`:
```
network={
    ssid="your ssid"
    psk="your password"
}
```

Then reboot and it should all setup automatically. If something doesn't work you
test it out by running `sudo ifup wlan0` and you should see what the issue is.

You may want to setup your `/etc/network/interfaces` so that `auto etho0` is `allow-hotplug eth0`
so that the system won't wait trying to raise the interface on boot.


# Duplicating SD
Remove the `/etc/udev/rules.d/70-persistent-net.rules` file so that it can recognize
the 'new' network adapters.

Remove `/etc/resolv.conf` so that it doesn't have any cached DNS servers, etc.

Remove `/var/log/auth.log`
Remove `/var/log/daemon.log`
Remove `/var/log/messages`
Remove `/var/log/syslog`


# Minimizing Power Consumption
Disable HDMI by adding `/usr/bin/tvservice -o` to `/etc/rc.local`


# Disabling Warning Overlays
If you know what you're doing and don't like the under-voltage and over-temp
warnings you can use add `avoid_warnings=1` to `/boot/config.txt`, set it to 2
to disable warnings and allow turbo during low voltage.


# Minimizing Startup
Disable login messages by creating `~/.hushlogin`

Disable startx messages with redirection `startx &> /dev/null`

To disable the boot messages, replace `console=tty1` with `console=tty3` in `/boot/cmdline.txt`

To disable non-critical kernal log messages add `loglevel=3` to `/boot/cmdline.txt`

To disable the raspberry logos add `logo.nologo` to the end of `/boot/cmdline.txt`

To disable the boot splash screen add `disable_splash=1` to `/boot/config.txt`


# Enabling Hardware Video Acceleration
If you get `libEGL warning: DRI2 failed to authenticate` then there is a bad version of libEGL
and/or libGLESv2 on the system. Find them, `sudo find / -name "*libEGL*"` and `"*libGLESv2*"`
then overwrite them with symlinks to the proper versions:
```
sudo ln -sf /opt/vc/lib/libEGL.so    /usr/lib/arm-linux-gnueabihf/libEGL.so.1
sudo ln -sf /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2
```
Finally run `sudo ldconfig` then reboot.

If you get 'failed to open vchiq device' you should ensure that your users have access to
/dev/vchiq. Do this:
Create `/etc/udev/rules.d/10-vchiq-permissions.rules` with the contents:
```
SUBSYSTEM=="vchiq",GROUP="video",MODE="0660"
```
Then add your users to the video group: `sudo usermod -a -G video kiosk`

If you get 'failed to add service - already in use' when startx then there is probably
not enough memory assigned for the gpu. Edit `/boot/config.txt` and adjust gpu_mem from 16 to
something like 64 or 128.
