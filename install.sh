#!/bin/bash
present()     { which $1 2>&1 >/dev/null; }
missing()     { ! present $1; }
apt_install() { log installing "$@" via apt-get; sudo apt-get install -y "$@"; }
on_windows()  { [ "$TERM" = "cygwin" ]; }
on_linux()    { ! on_windows ; }
log()         { echo " -- $@"; }

echo Installing dotfiles

log Linking dotfiles
export DOTFILES_PATH=~/dotfiles

ln -s --force "$DOTFILES_PATH/bashrc" "$HOME/.bashrc"
ln -s --force "$DOTFILES_PATH/tmux.conf" "$HOME/.tmux.conf"
ln -s --force "$DOTFILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s --force "$DOTFILES_PATH/gitignore_global" "$HOME/.gitignore_global"
ln -s --force "$DOTFILES_PATH/vim/vimrc" "$HOME/.vimrc"
ln -s --force "$DOTFILES_PATH/psqlrc" "$HOME/.psqlrc"
ln -s --force "$DOTFILES_PATH/gemrc" "$HOME/.gemrc"
ln -s --force "$DOTFILES_PATH/irbrc" "$HOME/.irbrc"
ln -s --force "$DOTFILES_PATH/pryrc" "$HOME/.pryrc"
ln -s --force "$DOTFILES_PATH/ackrc" "$HOME/.ackrc"
ln -s --force "$DOTFILES_PATH/agignore" "$HOME/.agignore"
ln -s --force "$DOTFILES_PATH/kderc" "$HOME/.kderc"
ln -s --force "$DOTFILES_PATH/vromerc" "$HOME/.vromerc"
ln -s --force "$DOTFILES_PATH/xhotkeys" "$HOME/.xhotkeys"
ln -s --force "$DOTFILES_PATH/vendor/dircolors.256dark" "$HOME/.dircolors"
ln -s --force "$DOTFILES_PATH/bundle" "$HOME/.bundle"
sudo ln -s --force "$DOTFILES_PATH/bin/bitwig" "/usr/bin/"

if on_linux; then
  ln -s --force -T "$DOTFILES_PATH/tmuxinator" "$HOME/.tmuxinator"
  ln -s --force -T "$DOTFILES_PATH/dotjs" "$HOME/.js"
  ln -s --force -T "$DOTFILES_PATH/irssi" "$HOME/.irssi"
fi # on_linux

ln -s --force "$DOTFILES_PATH/Xdefaults" "$HOME/.Xdefaults"
ln -s --force "$DOTFILES_PATH/sh-todo" "$HOME/.sh-todo"

if [ -d $HOME/.kde/share/apps/konsole ]; then
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/konsoleui.rc" "$HOME/.kde/share/apps/konsole/konsoleui.rc"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/solarized_dark.colorscheme" "$HOME/.kde/share/apps/konsole/solarized_dark.colorscheme"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-main.profile" "$HOME/.kde/share/apps/konsole/tmux-main.profile"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-guard.profile" "$HOME/.kde/share/apps/konsole/tmux-guard.profile"
fi

if on_linux; then
  present git || apt_install git
  present curl || apt_install curl

  # init submodules
  git submodule update --init

  # install vendor debs
  has_20_bash_completion() {
    dpkg -l | grep bash-completion | awk '{print $3}' | grep '2.0' 2>&1 >/dev/null
  }
  if ! has_20_bash_completion; then
    log intalling bash-completion 2.0
    sudo apt-get purge bash-completion &&
    sudo dpkg -i $DOTFILES_PATH/vendor/bash-completion_2.0-1_all.deb
  fi

  # link chromium to fake google-chrome for some apps
  if missing google-chrome && present chromium-browser; then
    sudo ln -s $(which chromium-browser) /usr/bin/google-chrome
  fi

  # set up rvm
  if [ ! -d $HOME/.rvm ]; then
    log installing rvm
    curl -L https://get.rvm.io | bash -s stable --ruby

    log installing rvm requirements
    sudo $(rvm requirements|grep -A1 "# For Ruby"|grep "ruby:"|cut -c9-|sed 's/install/install -y/g')

    cp $DOTFILES_PATH/.rvm-global.gems $HOME/.rvm/gemsets/global.gems

    log installing ruby falcon
    rvm get head && rvm reinstall 1.9.3-perf --patch falcon

    source bashrc
    rvm use 1.9.3-perf --default
  fi
fi # on_linux

# copy local_variables sample, if not present
if [ ! -f $HOME/.local_variables ]; then
  cp $DOTFILES_PATH/bash/local_variables.sample $HOME/.local_variables
fi

if on_linux; then
  (present ack-grep && missing ack) && sudo ln -s /usr/bin/ack-grep /usr/bin/ack
  (present python && missing fu) && (cd vendor/fu && sudo python setup.py install)

  present wget || apt_install wget

  if missing dropbox; then
    sudo dpkg -i vendor/debs/dropbox_1.6.0_amd64.deb
    dropbox start -i &
  fi
  if [ -d $HOME/Dropbox ] && [ ! -d $HOME/dropbox ]; then
    ln -s --force $HOME/Dropbox/ $HOME/dropbox
    ln -s --force $HOME/dropbox/projects $HOME/projects
  fi

  # install silver searcher
  present ag || sudo dpkg -i vendor/debs/the-silver-searcher_0.14-1_amd64.deb

  # install elasticsearch
  # if [ ! -d /etc/elasticsearch ]; then
  #   sudo dpkg -i vendor/debs/elasticsearch-0.90.2.deb
  # fi

  present vagrant || sudo dpkg -i $HOME/dropbox/linux/debs/vagrant*.deb

  if missing mosh; then
    sudo apt-get install -y python-software-properties
    sudo add-apt-repository -y ppa:keithw/mosh
    sudo apt-get update -y
    sudo apt-get install -y mosh
  fi

  # openbox
  if [ -d $HOME/.config/openbox ]; then
    ln -s --force $DOTFILES_PATH/conf/openbox/lubuntu-rc.xml $HOME/.config/openbox/
    ln -s --force $DOTFILES_PATH/conf/startup.desktop $HOME/.config/autostart/
  fi

  if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    vim -c ":NeoBundleInstall" -c ":qa"
  fi
  mkdir -p $HOME/.vim-tmp

  # fonts
  FONT_DIR=$HOME/.fonts
  FONT_PATH=$FONT_DIR/Monaco_Linux-Powerline.ttf
  if [ ! -f $FONT_PATH ]; then
    mkdir $FONT_DIR
    wget https://gist.github.com/raw/1634235/d1e0dd8b745a7868444ecb0d1d6cdb593249f9d5/Monaco_Linux-Powerline.ttf -O $FONT_PATH
    fc-cache -vf
  fi

  # local user supervisor
  mkdir -p $HOME/tmp
  mkdir -p $HOME/log/supervisor
  if missing supervisord; then
    sudo apt-get install -y supervisor
  fi
  if [ -f /etc/rc3.d/S20supervisor ]; then
    sudo /etc/init.d/supervisor stop
    sudo update-rc.d -f supervisor remove
  fi

  if missing current_ruby; then
    rvm wrapper 1.9.3 current ruby
  fi

  if missing node; then
    log installing node
    sudo apt-get install python-software-properties python g++ make
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get install nodejs -y
  fi
fi # on_linux

echo 'Load bashrc'
source ~/dotfiles/bashrc
source ~/dotfiles/bash/aliases.sh
