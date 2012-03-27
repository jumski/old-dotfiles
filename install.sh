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
ln -s --force "$DOTFILES_PATH/vendor/dircolors.256dark" "$HOME/.dircolors"
ln -s --force "$DOTFILES_PATH/tmuxinator" "$HOME/.tmuxinator"
ln -s --force "$DOTFILES_PATH/dotjs" "$HOME/.js"

mkdir -p "$HOME/.kde/share/apps/konsole"
ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/konsoleui.rc" "$HOME/.kde/share/apps/konsole/konsoleui.rc"
ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/solarized_dark.colorscheme" "$HOME/.kde/share/apps/konsole/solarized_dark.colorscheme"
ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-main.profile" "$HOME/.kde/share/apps/konsole/tmux-main.profile"
ln -s --force "$DOTFILES_PATH/vendor/kde/share/apps/konsole/tmux-guard.profile" "$HOME/.kde/share/apps/konsole/tmux-guard.profile"

mkdir -p $HOME/.vim-tmp

echo 'Load bashrc'
source ~/dotfiles/bashrc
source ~/dotfiles/bash/aliases.sh
