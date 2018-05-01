[ -z "$PS1" ] && return

export DOTFILES_PATH=~/dotfiles/

## LOAD SCRIPTS
source $DOTFILES_PATH/bash/variables.sh
source $DOTFILES_PATH/bash/setup_terminal.sh
source $DOTFILES_PATH/bash/aliases.sh
source $DOTFILES_PATH/bash/functions.sh

if [ "$TERM" != "cygwin" ]; then
  source $DOTFILES_PATH/bash/colors.sh

  [[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"
  nvm use default

  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  source ~/.chruby-default-gems/chruby-default-gems.sh
  export DEFAULT_GEMFILE="$DOTFILES_PATH/Gemfile"

  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
fi # cygwin

# source .local_variables if present
if [ -f $HOME/.local_variables ]; then
  source $HOME/.local_variables
fi

source $DOTFILES_PATH/bash/h.sh

export PATH="$PATH:$DOTFILES_PATH/bin"
