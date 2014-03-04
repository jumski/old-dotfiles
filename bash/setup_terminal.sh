
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=50000
HISTFILESIZE=200000
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# disable flow control shortcuts (C-Q and C-S)
stty -ixon -ixoff

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
    . $DOTFILES_PATH/bash/git-completion.bash
    if [ -f /usr/share/doc/tmux/examples/bash_completion_tmux.sh ]; then
      . /usr/share/doc/tmux/examples/bash_completion_tmux.sh
    fi
fi

[ -f $HOME/.local_variables ] && source $HOME/.local_variables
# [ -f $DOTFILES_PATH/bash/bundler-exec.sh ] && source $DOTFILES_PATH/bash/bundler-exec.sh

# added by travis gem
[ -f /home/jumski/.travis/travis.sh ] && source /home/jumski/.travis/travis.sh

# java home
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

# wrk home
export WRK_HOME=$DOTFILES_PATH/vendor/wrk
export PATH="$PATH:$WRK_HOME/bin"

# readline settings
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# enable keychain
which keychain 2>&1 >/dev/null && eval `keychain --eval --agents ssh --inherit local-once --nolock`

# add identity if not set
ssh_add_cmd=ssh-add
[ "$TERM" = "cygwin" ] && ssh_add_cmd=ssh-add.exe
if ! $ssh_add_cmd -l 1>/dev/null;
then
  $ssh_add_cmd
fi

