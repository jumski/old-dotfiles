#!/bin/bash

echo 'Installing scripts'
export DOTFILES_PATH=~/dotfiles

rm -f "$HOME/.bashrc"
ln -s "$DOTFILES_PATH/bashrc.sh" "$HOME/.bashrc"

rm -f "$HOME/.tmux.conf"
ln -s "$DOTFILES_PATH/tmux.conf" "$HOME/.tmux.conf"

rm -f "$HOME/.gitconfig"
ln -s "$DOTFILES_PATH/gitconfig" "$HOME/.gitconfig"

rm -f "$HOME/.vimrc"
ln -s "$DOTFILES_PATH/vim/vimrc" "$HOME/.vimrc"

rm -f "$HOME/.gemrc"
ln -s "$DOTFILES_PATH/gemrc" "$HOME/.gemrc"

rm -f "$HOME/.irbrc"
ln -s "$DOTFILES_PATH/irbrc" "$HOME/.irbrc"

rm -f "$HOME/.dircolors"
ln -s "$DOTFILES_PATH/vendor/dircolors.256dark" "$HOME/.dircolors"

mkdir -p "$HOME/.kde/share/apps/konsole"
ln -s "$DOTFILES_PATH/vendor/kde/share/apps/konsole/konsoleui.rc" "$HOME/.kde/share/apps/konsole/konsoleui.rc"
ln -s "$DOTFILES_PATH/vendor/kde/share/apps/konsole/solarized_dark.colorscheme" "$HOME/.kde/share/apps/konsole/solarized_dark.colorscheme"
ln -s "$DOTFILES_PATH/vendor/kde/share/apps/konsole/jumshell.profile" "$HOME/.kde/share/apps/konsole/jumshell.profile"

echo 'Load bashrc'
source ~/dotfiles/bashrc.sh
source ~/dotfiles/bash/aliases.sh
