#!/bin/bash
export BLUBASE_DIR=$1
cd $BLUBASE_DIR;

SESSION_NAME=$2

ssh-add 

tmux start-server

tmux new-session -d -s $SESSION_NAME -n server
tmux new-window -t$SESSION_NAME -n console
tmux new-window -t$SESSION_NAME -n vim
tmux new-window -t$SESSION_NAME -n bash

tmux send-keys -t$SESSION_NAME:1 "$SERVER_COMMAND" C-m
tmux send-keys -t$SESSION_NAME:2 "$CONSOLE_COMMAND" C-m
tmux send-keys -t$SESSION_NAME:3 "vim" C-m
tmux send-keys -t$SESSION_NAME:4 "git wtf" C-m

tmux select-window -t$SERVER_OPTIONS:4
tmux attach-session -d -t$SESSION_NAME