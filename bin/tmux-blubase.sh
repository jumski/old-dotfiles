#!/bin/bash

export SERVER_COMMAND="script/server thin"
export CONSOLE_COMMAND="script/console"

tmux-rails.sh ~/work/blu/base blubase thin
