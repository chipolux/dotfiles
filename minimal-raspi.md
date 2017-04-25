# Setting Up Minimal Raspberry Pi 3


## Imaging SD Card
Get minibian [here](https://minibianpi.wordpress.com/setup/).

Extract and use `dd` to copy it to a SD card.

* OSX
    * `diskutil list`
    * `diskutil unmountDisk /dev/disk*`
    * `sudo dd if=minibian.img of=/dev/rdisk* bs=32m`
* Linux
    * `df` to find removable disk, usually /dev/sdd
    * `umount <path to disk>`
    * `sudo dd bs=4M if=minibian.img of=<path to disk>`

Slap the SD card in the pi and boot it up. As found on the minibian site, by default
there is only the `root` account with password `raspberry`, you will want to change
this quickly.

Expand the disk:
Edit partitions using `fdisk /dev/mmcblk0`, list them with `p`, delete the 2nd one
with `d`, then re-create it with `n` as a primary partition, starting at the offset
you saw in the `p` list, and ending at the end of the drive (leave it blank). Then
use `w` to write, you'll get an error like `Device or resource busy`, that's fine.
Now reboot so that new partition table takes effect. Once you're back in use
`resize2fs /dev/mmcblk0p2` to expand the filesystem to fit the partition. You can
verify using `df -h`!

Cleanup:
If you've mounted the disk on a macOS machine it may have left a `.Trash` folder
on the boot partition, it can be removed.


## Initial OS Setup
This will probably take a long time but it's best to make sure everything is
up to date: `apt-get update && apt-get dist-upgrade`

Install sudo: `apt-get install sudo`

Edit `/etc/sudoers/` to let sudo group not require password (if you want):
`%sudo  ALL=(ALL:ALL) NOPASSWD:ALL`

Create a user, `adduser some-guy` for example.

Add the your user to the sudo group: `usermod -a -G sudo some-guy`

Disable root ssh login: `vi /etc/ssh/sshd_config` and `PermitRootLogin no`

Change root password using `passwd`, or disable lock the root account like `passwd -l root`

***From this point on, do everything with the user you created with `sudo` rights instead of root!***

Install apt-utils, `apt-get install apt-utils`

Configure locals: `dpkg-reconfigure locales`

Configure keyboard: `dpkg-reconfigure keyboard-configuration`

Configure timezone: `dpkg-reconfigure tzdata`

Install python: `apt-get install python3` (currently this is 3.4.2)

Install pip: `wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py`

For GUI, look at minimal-ubuntu setup, but the jist is `apt-get install xorg`,
setup a profiles `~/.xinitrc` to run a GUI app (or install a window manager),
then edit an accounts `~/.profile` to `startx &> /dev/null`.


# Keep X App Alive
Setup the profile that will run the app to have a `~/.xinitrc` like:
```
while true; do
    python3 app.py
done
```


# Keep Screen Awake
If your screen blacks/blanks out after a period of inactivity and you don't like
that you can add this to your `/etc/X11/xorg.conf`
```
Secion "Monitor"
    Identifier "Monitor0"
    Option "DPMS" "false"
EndSection

Section "ServerLayout"
    Identifier "ServerLayout0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
    Option "BlankTime" "0"
EndSection
```

Alternatively you could add this to your `.xinitrc`
```
xset s off
xset -dpms
```


# Set Background Image For X
Ensure you have `feh` installed: `sudo apt-get install feh`
Then in your `~/.xinitrc` you can do: `feh --bg-fill /path/to/img`


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

Clean out logs `sudo rm -rf /var/log/*`


# Minimizing Power Consumption
Disable HDMI by adding `/usr/bin/tvservice -o` to `/etc/rc.local`


# Disabling Warning Overlays
If you know what you're doing and don't like the under-voltage and over-temp
warnings you can use add `avoid_warnings=1` to `/boot/config.txt`, set it to 2
to disable warnings and allow turbo during low voltage.


# Minimizing Startup
Disable login messages by creating `~/.hushlogin`

Disable startx messages with redirection `startx &> /dev/null`

To disable the boot messages, replace `console=tty1` with `console=null quiet` in `/boot/cmdline.txt`

To disable non-critical kernal log messages add `loglevel=3` to `/boot/cmdline.txt`

To disable the raspberry logos add `logo.nologo` to the end of `/boot/cmdline.txt`

To disable the boot splash screen add `disable_splash=1` to `/boot/config.txt`


# Enabling Hardware Video Acceleration
If you get `libEGL warning: DRI2 failed to authenticate` when starting a GUI app
then there is a bad version of libEGL and/or libGLESv2 on the system. Find them,
`sudo find / -name "*libEGL*"` and `"*libGLESv2*"` then overwrite them with
symlinks to the proper versions:
```
sudo ln -sf /opt/vc/lib/libEGL.so    /usr/lib/arm-linux-gnueabihf/libEGL.so.1
sudo ln -sf /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2
```
Finally run `sudo ldconfig` then reboot.

That might just let you get to a 'failed to open vchiq device' error, you should
ensure that your users have access to /dev/vchiq. Do this:
Create `/etc/udev/rules.d/10-vchiq-permissions.rules` with the contents:
```
SUBSYSTEM=="vchiq",GROUP="video",MODE="0660"
```
Then add your users to the video group: `sudo usermod -a -G video kiosk`

Finally if you get 'failed to add service - already in use' on startx then there
is probably not enough memory assigned for the gpu. Edit `/boot/config.txt` and
set `gpu_mem` to something like 64 or 128. I've had no problems yet with either.


# Getting PyQt5 For EGLFS
LeanDog provides a source for Qt5.7, SIP, and PyQt5.7 using EGLFS on Raspbian.
https://gist.github.com/garyjohnson/f041d2274dccd6641c51

First ensure that the EGLFS binaries are accessible at the expected locations for Qt.
```
ln -fs /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1.0.0
ln -fs /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0
```

Then add `deb http://apt.leandog.com/ jessie main` to `/etc/apt/sources.list` and
run `apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BDCBFB15`.

Ensure that you don't have `python3-pyqt5`, `qt5-default`, etc. installed.

Then, `apt-get update` and `apt-get install qt5 sip pyqt5`!


# Input Access Under EGLFS
If you use EGLFS you'll need to ensure the user of your app is able to access
the actual input devices. If you don't you will get several permissions errors
relating to `/dev/input*` devices as well as not being able to interact with
your app!

You can fix this using udev rules, create a new rule in `/etc/udev/rules.d`
like `10-input.rules`, inside it you should have this:
`SUBSYSTEM=="input",GROUP="input",MODE="660"`

Then just ensure your user is in the input group, `usermod -a -G input kiosk`.


# Disabling Virtual Terminal Switching
To disable the `Ctrl-Alt-F{1..6}` virtual terminal switching open/create
`/etc/X11/xorg.conf` and add this:
```
Section "ServerFlags"
    Option "DontVTSwitch" "true"
EndSection
```

# Upside Down Video
If the case or stand you're using for a display holds your screen such that
everything is upside down, just add this to `/boot/config.txt`:
```
lcd_rotate=2
```
You can adjust that rotation for other orientations as well.


# Disable Serial Port Console
By default minibian/raspbian will start a console for use via a serial connection.
You might not want this enabled when locking down the system.

Remove the `console=ttyAMA0,115200 kgdboc=ttyAMA0,115200` options from `/boot/cmdline.txt`

Remove the following lines from `/etc/inittab`:
```
#Spawn a getty on Raspberry Pi serial line
T0:23:respawn:/sbin/getty -L ttyAMA0 115200 vt100
```


# Controlling Touch Display
The display is controlled via a raw sys interface in `/sys/class/backlight/rpi_backlight`.

You can power the display off with `echo 1 > /sys/class/backlight/rpi_backlight/bl_power`

Back on with `echo 0 > /sys/class/backlight/rpi_backlight/bl_power`

You can adjust the brightness through a range of 0-255 with `echo 128 > /sys/class/backlight/rpi_backlight/brightness`

You may not have access to those files though, if that's the case add the file
`/etc/udev/rules.d/backlight-permissions.rules` with this:
```
SUBSYSTEM=="backlight",RUN+="/bin/chmod 666 /sys/class/backlight/%k/brightness /sys/class/backlight/%k/bl_power"
```


# PyQt5 App Gotchas
The easiest and most reliable way of getting PyQt5 and Python 3 on your
minibian system is to use the repositories.
```
sudo apt-get install python3-dev
sudo apt-get install python3-pyqt5
```

If you need/want to display SVG images you will need the SVG lib: `sudo apt-get install libqt5svg5`


# Enabling Camera
To enabled the raspi-camera edit your `/boot/config.txt` to contain `start_x=1`

Then you can take pictures like `raspistill -t 1 -n -o picture.jpg`

You can also use things like `apt-get install python3-picamera` to programmatically
control the camera.
