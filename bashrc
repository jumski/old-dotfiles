
[ -z "$PS1" ] && return

export DOTFILES_PATH=~/dotfiles/

## LOAD SCRIPTS
. $DOTFILES_PATH/bash/variables.sh
. $DOTFILES_PATH/bash/setup_terminal.sh
source $DOTFILES_PATH/bash/aliases.sh
source $DOTFILES_PATH/bash/functions.sh

if [ "$TERM" != "cygwin" ]; then
  . $DOTFILES_PATH/bash/colors.sh
  export PATH=$PATH:$HOME/local/node/bin/:$DOTFILES_PATH/bin/:/home/jumski/various/bin/:$HOME/bin/

  ## LOAD RVM
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi # cygwin

# source .local_variables if present
if [ -f $HOME/.local_variables ]; then
  source $HOME/.local_variables
fi

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
