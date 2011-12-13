#!/bin/bash

export SERVER_COMMAND="rails server thin"
export CONSOLE_COMMAND="rails console"

tmux-rails.sh ~/work/spree spree
