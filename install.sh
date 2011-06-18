#!/bin/bash

if [ -f "$HOME/.bashrc" ]; then
	mv "$HOME/.bashrc" "$HOME/.bashrc.old"
fi

if [ -f "$HOME/.bash_aliases" ]; then
	mv "$HOME/.bash_aliases" "$HOME/.bash_aliases.old"
fi

if [ -f "$HOME/.bash_colors" ]; then
	mv "$HOME/.bash_colors" "$HOME/.bash_colors.old"
fi

if [ -f "$HOME/tmux.conf" ]; then
	mv "$HOME/tmux.conf" "$HOME/tmux.conf.old"
fi

if [ -f "$HOME/gitconfig" ]; then
	mv "$HOME/gitconfig" "$HOME/gitconfig.old"
fi

ln -s "$PWD/bashrc.sh" "$HOME/.bashrc"
ln -s "$PWD/bash_aliases.sh" "$HOME/.bash_aliases"
ln -s "$PWD/bash_colors.sh" "$HOME/.bash_colors"
ln -s "$PWD/tmux.conf" "$HOME/tmux.conf"
ln -s "$PWD/gitconfig" "$HOME/.gitconfig"