#!/bin/bash

export BLUBASE_DIR=~/work/blu/base
cd $BLUBASE_DIR;

tmux start-server

tmux new-session -d -s blubase
tmux source-file ~/tmux.conf

tmux new-window -tblubase -n server
tmux new-window -tblubase -n console
tmux new-window -tblubase -n vim
tmux new-window -tblubase -n bash
tmux kill-window -t 0

tmux send-keys -tblubase:1 "script/server" C-m
tmux send-keys -tblubase:2 "script/console" C-m
tmux send-keys -tblubase:3 "vim -c Gstatus" C-m
tmux send-keys -tblubase:4 "git wtf" C-m

tmux select-window -tblubase:4
tmux attach-session -d -tblubase
