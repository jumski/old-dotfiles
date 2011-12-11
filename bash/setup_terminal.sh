
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
