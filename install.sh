#/bin/bash

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

echo 'Load bashrc'
source ~/dotfiles/bashrc.sh
source ~/dotfiles/bash/aliases.sh
