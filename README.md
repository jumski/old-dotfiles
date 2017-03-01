# various hacks and improvements

## keepassx

```
sudo add-apt-repository ppa:eugenesan/ppa
apt update
apt install keepassx
```

## Hevc / H256 codec

```
sudo apt-add-repository ppa:strukturag/libde265
sudo apt-get update
sudo apt-get install gstreamer0.10-libde265 vlc-plugin-libde265
```

## intel i915 freeze

Use kernel boot flag `intel_idle.max_cstate=1`.
Edit `/etc/default/grub`:

```
GRUB_CMDLINE_LINUX_DEFAULT="intel_idle.max_cstate=1"
```

## Zenbook UX303UA wifi in "unmanaged" stage

Add this line to `/etc/modprobe.d/iwlwifi.conf`:

```
options iwlwifi wd_disable=0
```

## diff-highlight

```
sudo chmod +x /usr/local/share/git-core/contrib/diff-highlight/diff-highlight | less
```

## Zenbook UX303UA keyboard backlight

```
sudo chmod a+w /sys/class/leds/asus::kbd_backlight/brightness
echo 0 > /sys/class/leds/asus::kbd_backlight/brightness
echo 3 > /sys/class/leds/asus::kbd_backlight/brightness
# auto-set to 0 on startup
```

!!! chmoding is not enought, need to add udev rule because permissions
are overriden

Create following file `/etc/udev/rules.d/99-keyboard-leds.rules`

```
DEVPATH=="/devices/platform/asus-nb-wmi/leds/asus::kbd_backlight", RUN+="/bin/chmod 0666 /sys/class/leds/asus::kbd_backlight/brightness"
```

## Zenbook UX303UA brightness key not working

Edit /etc/default/grub

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
```

to

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pcie_aspm=force acpi_osi="
```

Reboot.
Create `/usr/share/X11/xorg.conf.d/20-backlight.conf` with contents:

```
Section "Device"
    Identifier "card0"
    Driver "intel"
    Option "Backlight" "intel_backlight"
    BusID "PCI:0:2:0"
EndSection
```

Reboot

## advanced power management (TLP)

http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html


## fix 2finger touchpad tap

gsettings set org.gnome.settings-daemon.peripherals.input-devices hotplug-command /home/jumski/dotfiles/bin/setup_input_devices

## fix too big tab/address bar in chrome

google-chrome --high-dpi-support=1 --force-device-scale-factor=1.5


## fix for bumblebee and kernel 4.2

KeepUnusedXServer=true in /etc/bumblebee/bumblebee.conf

source: https://forum.manjaro.org/index.php?topic=27156.0

## Intel Centrino Wifi card problem

Last line of `etc/modprobe.d/iwlwifi.conf` should land into `/etc/modprobe.d/iwlwifi.conf`
(full file included for brevity).

Then it's best to just restart.

## Pidgin Facebook

https://github.com/jgeboski/purple-facebook/wiki


## skype pulseaudio cracklings fix

```PULSE_LATENCY_MSEC=30 skype```

## speed up ubuntu tricks

http://itsfoss.com/speed-up-ubuntu-1310/


## movie subtitles downloader

```
sudo pip install subliminal
```

## Postgresql for local user

```
sudo su postgres -c createuser jumski
sudo su postgres -c "createdb jumski"
```

## supress postgres warnings

http://robots.thoughtbot.com/global-min-messages

## lubuntu 13.10 laptop_mode

Check ~/.config/lxsession/Lubuntu/desktop.conf.
Look for laptop_mode and see that it's set to 'yes':

```
[State]
laptop_mode=yes
```

## default browser
sudo update-alternatives --config x-www-browser

## tmux 1.8
http://garr.dl.sourceforge.net/project/tmux/tmux/tmux-1.8/tmux-1.8.tar.gz
$ sudo apt-get install libevent-dev libncurses-dev
$ autoreconf -fis
$ ./configure
& make
$ sudo make install

## mounting partitions from image file
Kpartx can be used to set up device mappings for the partitions of any partitioned block device. It is part of the Linux multipath-tools. With kpartx -l imagefile you get an overview of the partitions in the image file and with kpartx -a imagefile the partitions will accessible via /dev/mapper/loop0pX (X is the number of the partition). You can mount it now with mount /dev/mapper/loop0pX /mnt/ -o loop,ro. After unmounting you can disconnect the mapper devices with kpartx -d imagefile.

## smb + cups
http://www.tldp.org/HOWTO/Debian-and-Windows-Shared-Printing/printing_to_windows.html

## regional settings in LXDE
Preferences->Language Support->Regional Formats

## reduce swappiness
```
  sudo sysctl -w vm.swappiness=10
```

## fix for debugger-linecache bug @ 2.0.0
```
  gem install debugger-linecache -v 1.1.2 -- --with-ruby-include=$rvm_path/src/ruby-2.0.0-p0
```

## two finger scroll

use gpointing-device-settings

## vimproc after first install
```
  After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
```

## electrum bitcoin client
```
  sudo pip install http://electrum.ecdsa.org/Electrum-1.5.tar.gz
```

## dotjs
```bash
@reboot /home/jumski/dotfiles/vendor/dotjs-ubuntu/bin/djsd -d
```


## rubygems_cache

```bash
  $ mkdir ~/installed
  $ git clone git@github.com:akitaonrails/rubygems_proxy.git ~/installed/
```

## nginx for rubygems_cache

  install passenger with nginx, then:

```bash
  $ rm -rf /opt/nginx/conf
  $ ln -s $DOTFILES_PATH/conf/nginx /opt/nginx/conf
```

## magnet protocol (ktorrent)

```bash
  gconftool-2 -t string -s /desktop/gnome/url-handlers/magnet/command "/usr/bin/ktorrent %s"
  gconftool-2 -s /desktop/gnome/url-handlers/magnet/needs_terminal false -t bool
  gconftool-2 -t bool -s /desktop/gnome/url-handlers/magnet/enabled true
```

## libnotify for guard

```
  apt-get install libgtkmm-2.4-dev libnotify-bin
```

## install dropbox

```
  cd ~ && wget -O - http://www.dropbox.com/download?plat=lnx.x86_64 | tar xzf -
  .dropbox-dist/dropboxd
```
