
## DEFAULT ALIASES
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias mkdir='mkdir -p'

alias g=git
alias gs="git status"
alias gd="git diff"
complete -o default -o nospace -F _git g
complete -o default -o nospace -F _git_status gs
complete -o default -o nospace -F _git_diff gd

coltree(){
  tree -C "$@" | less -R
}

alias updatedb="sudo updatedb"

## CUSTOM ALIASES
alias ack=ack-grep
alias g=git
alias tf="tail -100f"

alias jungletrain="mocp -l http://stream2.jungletrain.net:8000"
alias bassdrive="mocp -l http://shouthostdirect13.streams.bassdrive.com:8202"
alias livednb="mocp -l http://173.236.56.82:8006"
alias iwayhigh="mocp -l http://70.38.71.74:8000"
alias groovesalad="mocp -l http://streamer-ntc-aa06.somafm.com:80/stream/1018"
alias spacestationsoma="mocp -l http://207.200.96.231:8012"
alias ambientdrones="mocp -l http://srv3.electro-music.com:8500/"

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias compile_tags="ctags -R --exclude=.git --exclude=log * $GEM_HOME/gems/*"
alias realias="source $DOTFILES_PATH/bash/aliases.sh && echo 'reloaded .bash/aliases.sh'"

function s {
  apt-cache search "$@" | sort | less
}
function i {
  if ! grep "$1" $DOTFILES_PATH/conf/deb_list; then
    echo "$1" >> $DOTFILES_PATH/conf/deb_list
  fi

  sudo apt-get install $1
}

alias fav="~/various/fav"
alias favgrep="~/various/favgrep"

alias skype="LD_PRELOAD=/usr/lib32/libv4l/v4l1compat.so skype"

alias ssh-maroko="ssh -t -p 60022 jumski@dev.jumski.com ssh root@127.0.0.1 -p 9999"
vpnbluair="ssh svnbluair \"echo 'status' | nc localhost 7505\""

function killflash {
  ps ax|grep flashplugin|grep -v grep|awk {'print $1'}|xargs kill
}

function mkcd {
  mkdir $1 && cd $1
}
function .. {
  cd ..
}
function ... {
  cd ../..
}
function - {
  cd -
}

function list-colors {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i} ";
  done
}

function p {
  ps ax|grep -i $1
}

# ======================================================================
#
# Function: confirm
# Asks the user to confirm an action, If the user does not answer yes,
# then the script will immediately exit.
#
# Parameters:
# $@ - The confirmation message
#
# Examples:
# >  # Example 1
# >  # The preferred way to use confirm
# >  confirm Delete file1? && echo rm file1
# >
# >  # Example 2
# >  # Use the $? variable to examine confirm's return value
# >  confirm Delete file2?
# >  if [ $? -eq 0 ]
# >  then
# >      echo Another file deleted
# >  fi
# >
# >  # Example 3
# >  # Tell bash to exit right away if any command returns a non-zero code
# >  set -o errexit
# >  confirm Do you want to run the rest of the script?
# >  echo Here is the rest of the script
#
# ======================================================================

function confirm()
{
  echo -n "$@ "
  read -e answer
  for response in y Y yes YES Yes Sure sure SURE OK ok Ok t T tak Tak TAK
  do
    if [ "_$answer" == "_$response" ]
    then
      return 0
    fi
  done

  # Any answer other than the list above is considerred a "no" answer
  return 1
}

alias xevx="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"

function vol() {
  VOLUME="$1"0
  echo "volume set to $VOLUME"
  amixer set Master $VOLUME
}

gcd() {
  gem_require_path=$(gem which "$1")
  gem_require_folder=$(dirname "$gem_require_path")

  ls -la "$gem_require_folder"
  # cd "$gem_require_folder"
}

alias hth=html2haml

alias goprod="export RAILS_ENV=production; echo 'Rails.env set to production'"
alias godev="export RAILS_ENV=development; echo 'Rails.env set to development'"

precompile() {
  git rm -rfq public/assets; rake assets:precompile RAILS_ENV=production && git add public/assets
}
