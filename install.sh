#!/bin/bash

echo 'Installing scripts'
export DOTFILES_PATH=~/dotfiles

ln -s --force "$DOTFILES_PATH/bashrc" "$HOME/.bashrc"
ln -s --force "$DOTFILES_PATH/tmux.conf" "$HOME/.tmux.conf"
ln -s --force "$DOTFILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s --force "$DOTFILES_PATH/gitignore_global" "$HOME/.gitignore_global"
ln -s --force "$DOTFILES_PATH/vim/vimrc" "$HOME/.vimrc"
ln -s --force "$DOTFILES_PATH/gemrc" "$HOME/.gemrc"
ln -s --force "$DOTFILES_PATH/irbrc" "$HOME/.irbrc"
ln -s --force "$DOTFILES_PATH/pryrc" "$HOME/.pryrc"
ln -s --force "$DOTFILES_PATH/ackrc" "$HOME/.ackrc"
ln -s --force "$DOTFILES_PATH/agignore" "$HOME/.agignore"
ln -s --force "$DOTFILES_PATH/kderc" "$HOME/.kderc"
ln -s --force "$DOTFILES_PATH/vromerc" "$HOME/.vromerc"
ln -s --force "$DOTFILES_PATH/xhotkeys" "$HOME/.xhotkeys"
ln -s --force "$DOTFILES_PATH/vendor/dircolors.256dark" "$HOME/.dircolors"
ln -s --force -T "$DOTFILES_PATH/tmuxinator" "$HOME/.tmuxinator"
ln -s --force -T "$DOTFILES_PATH/dotjs" "$HOME/.js"
ln -s --force -T "$DOTFILES_PATH/irssi" "$HOME/.irssi"
ln -s --force "$DOTFILES_PATH/Xdefaults" "$HOME/.Xdefaults"
ln -s --force "$DOTFILES_PATH/sh-todo" "$HOME/.sh-todo"

if [ -d $HOME/.kde/share/apps/konsole ]; then
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/konsoleui.rc" "$HOME/.kde/share/apps/konsole/konsoleui.rc"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/solarized_dark.colorscheme" "$HOME/.kde/share/apps/konsole/solarized_dark.colorscheme"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-main.profile" "$HOME/.kde/share/apps/konsole/tmux-main.profile"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-guard.profile" "$HOME/.kde/share/apps/konsole/tmux-guard.profile"
fi

function log() {
  echo "-- ${1}"
}

# install git if missing
which git 2>/dev/null >/dev/null || sudo apt-get install -y git

# install curl if missing
which curl 2>/dev/null >/dev/null || sudo apt-get install -y curl

# init submodules
git submodule update --init

# install vendor debs
has_20_bash_completion() {
  dpkg -l | grep bash-completion | awk '{print $3}' | grep '2.0'
}
if ! has_20_bash_completion; then
  log 'Intalling bash-completion 2.0'
  sudo apt-get purge bash-completion &&
  sudo dpkg -i $DOTFILES_PATH/vendor/bash-completion_2.0-1_all.deb
fi

# link chromium to fake google-chrome for some apps
if ! which google-chrome && which chromium-browser; then
  sudo ln -s $(which chromium-browser) /usr/bin/google-chrome
fi

# set up rvm
if [ ! -d $HOME/.rvm ]; then
  #log 'Installing RVM'
  curl -L https://get.rvm.io | bash -s stable --ruby

  log 'Installing RVM requirements'
  sudo $(rvm requirements|grep -A1 "# For Ruby"|grep "ruby:"|cut -c9-|sed 's/install/install -y/g')

  log 'Installing ruby-falcon'
  rvm get head && rvm reinstall 1.9.3-perf --patch falcon

  log 'Coping rvm global.gems'
  cp $DOTFILES_PATH/.rvm-global.gems $HOME/.rvm/gemsets/global.gems

  source bashrc
  rvm use 1.9.3-perf --default
fi

# copy local_variables sample, if not present
if [ ! -f $HOME/.local_variables ]; then
  cp $DOTFILES_PATH/bash/local_variables.sample $HOME/.local_variables
fi

# make git-dude dir
test -d $HOME/.git-dude || mkdir $HOME/.git-dude

(which ack-grep && ! which ack) && sudo ln -s /usr/bin/ack-grep /usr/bin/ack
(which python && ! which fu) && (cd vendor/fu && sudo python setup.py install)

# install wget
if ! which wget ; then
  sudo apt-get install wget
fi

# install dropbox
if ! which dropbox; then
  sudo dpkg -i vendor/debs/dropbox_1.6.0_amd64.deb
  dropbox start -i &
fi
if [ -d $HOME/Dropbox ] && [ ! -d $HOME/dropbox ]; then
  ln -s --force $HOME/Dropbox/ $HOME/dropbox
fi

# install silver searcher
if ! which ag; then
  sudo dpkg -i vendor/debs/the-silver-searcher_0.14-1_amd64.deb
fi

# install elasticsearch
if [ ! -d /etc/elasticsearch ]; then
  sudo dpkg -i vendor/debs/elasticsearch-0.90.2.deb
fi

# install vagrant
if ! which vagrant; then
  sudo dpkg -i vendor/debs/vagrant*.deb
fi

if ! which mosh; then
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

# vundle
if [ ! -d ~/.vim/bundle/vundle ]; then
  echo "Vundle not found - installing"
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim -se -c BundleInstall -c qa
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
if ! which supervisord; then
  sudo apt-get install -y supervisor
fi
if [ -f /etc/rc3.d/S20supervisor ]; then
  sudo /etc/init.d/supervisor stop
  sudo update-rc.d -f supervisor remove
fi

echo 'Load bashrc'
source ~/dotfiles/bashrc
source ~/dotfiles/bash/aliases.sh
