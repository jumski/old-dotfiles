
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
    . $DOTFILES_PATH/bash/git-completion.bash
fi

[ -f $HOME/.local_variables ] && source $HOME/.local_variables
# [ -f $DOTFILES_PATH/bash/bundler-exec.sh ] && source $DOTFILES_PATH/bash/bundler-exec.sh

# java home
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

# wrk home
export WRK_HOME=$DOTFILES_PATH/vendor/wrk
export PATH="$PATH:$WRK_HOME/bin"

# readline settings
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# enable keychain
eval `keychain --eval --agents ssh --inherit local-once --nolock`

# add identity if not set
if ! ssh-add -l 1>/dev/null;
then
  ssh-add
fi

