# various hacks and improvements

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
