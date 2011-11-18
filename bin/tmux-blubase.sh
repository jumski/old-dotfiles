#!/bin/bash

export WORKING_DIR=~/blubase-files
cd $WORKING_DIR;

tmux start-server
tmux new-session -d -s blubase -n work

tmux new-window -tblubase:1 -n svnbluair
# tmux new-window -tblubase:2 -n test

tmux send-keys -tblubase:0 'cd $WORKING_DIR' C-m
tmux send-keys -tblubase:1 'ssh svnbluair' C-m
# tmux send-keys -tblubase:2 'cd $WORKING_DIR && bundle exec autotest -f' C-m

tmux select-window -tblubase:0
tmux attach-session -d -tblubase
