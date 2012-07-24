#!/bin/bash

echo 'Installing scripts'
export DOTFILES_PATH=~/dotfiles

ln -s --force "$DOTFILES_PATH/bashrc" "$HOME/.bashrc"
ln -s --force "$DOTFILES_PATH/tmux.conf" "$HOME/.tmux.conf"
ln -s --force "$DOTFILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s --force "$DOTFILES_PATH/vim/vimrc" "$HOME/.vimrc"
ln -s --force "$DOTFILES_PATH/gemrc" "$HOME/.gemrc"
ln -s --force "$DOTFILES_PATH/irbrc" "$HOME/.irbrc"
ln -s --force "$DOTFILES_PATH/pryrc" "$HOME/.pryrc"
ln -s --force "$DOTFILES_PATH/ackrc" "$HOME/.ackrc"
ln -s --force "$DOTFILES_PATH/kderc" "$HOME/.kderc"
ln -s --force "$DOTFILES_PATH/vromerc" "$HOME/.vromerc"
ln -s --force "$DOTFILES_PATH/xhotkeys" "$HOME/.xhotkeys"
ln -s --force "$DOTFILES_PATH/vendor/dircolors.256dark" "$HOME/.dircolors"
ln -s --force "$DOTFILES_PATH/tmuxinator" "$HOME/.tmuxinator"
ln -s --force "$DOTFILES_PATH/dotjs" "$HOME/.js"

if [ -d $HOME/.kde/share/apps/konsole ]; then
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/konsoleui.rc" "$HOME/.kde/share/apps/konsole/konsoleui.rc"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/solarized_dark.colorscheme" "$HOME/.kde/share/apps/konsole/solarized_dark.colorscheme"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-main.profile" "$HOME/.kde/share/apps/konsole/tmux-main.profile"
  ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-guard.profile" "$HOME/.kde/share/apps/konsole/tmux-guard.profile"
fi

# copy local_variables sample, if not present
if [ ! -f $HOME/.local_variables ]; then
  cp $DOTFILES_PATH/bash/local_variables.sample $HOME/.local_variables
fi

# install wget
if ! which wget ; then
  sudo apt-get install wget
fi

# openbox
if [ -d $HOME/.config/openbox ]; then
  ln -s --force $DOTFILES_PATH/conf/openbox/lubuntu-rc.xml $HOME/.config/openbox/
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

echo 'Load bashrc'
source ~/dotfiles/bashrc
source ~/dotfiles/bash/aliases.sh
