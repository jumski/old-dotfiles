echo 'bashrc' >> /tmp/wojtlog
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

  ## LOAD NVM and use node 5
  [[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"
  nvm use default

  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  source ~/.chruby-default-gems/chruby-default-gems.sh
  export DEFAULT_GEMFILE="$DOTFILES_PATH/Gemfile"
fi # cygwin

# source .local_variables if present
if [ -f $HOME/.local_variables ]; then
  source $HOME/.local_variables
fi

# add studio scripts binaries
if [[ -d ~/work/studio-scripts/bin ]]; then
  PATH=$PATH:~/work/studio-scripts/bin
fi

source $DOTFILES_PATH/bash/h.sh

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
