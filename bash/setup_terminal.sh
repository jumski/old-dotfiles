
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=50000
HISTFILESIZE=200000
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export EDITOR=vim

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

if [ "$TERM" == "xterm" ]; then
  # No it isn't, it's gnome-terminal
  export TERM=xterm-256color
fi

case "$TERM" in
  xterm-color) color_prompt=yes
esac

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[ -f $DOTFILES_PATH/bash/bundler-exec.sh ] && source $DOTFILES_PATH/bash/bundler-exec.sh

# optimize ruby garbage collector
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

export PATH="$PATH:$DOTFILES_PATH/vendor/tmuxinator/bin/"
source $DOTFILES_PATH/vendor/tmuxinator/bin/tmuxinator_completion

# readline settings
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# add identity if not set
if ! ssh-add -l 1>/dev/null;
then
  ssh-add
fi

