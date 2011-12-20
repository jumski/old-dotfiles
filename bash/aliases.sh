
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

## CUSTOM ALIASES
alias ack=ack-grep

alias jungletrain="mocp -l http://stream2.jungletrain.net:8000"
alias bassdrive="mocp -l http://shouthostdirect13.streams.bassdrive.com:8202"
alias livednb="mocp -l http://173.236.56.82:8006"
alias iwayhigh="mocp -l http://70.38.71.74:8000"
alias groovesalad="mocp -l http://streamer-ntc-aa06.somafm.com:80/stream/1018"
alias spacestationsoma="mocp -l http://207.200.96.231:8012"
alias ambientdrones="mocp -l http://srv3.electro-music.com:8500/"

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias tmux="tmux -f ~/tmux.conf"
alias compile_tags="ctags -R --exclude=.git --exclude=log * $GEM_HOME/gems/*"
alias realias="source $DOTFILES_PATH/bash/aliases.sh && echo 'reloaded .bash/aliases.sh'"

alias s="apt-cache search "
alias i="sudo apt-get install "

alias fav="~/various/fav"
function nowplayin {
  mocp -i | grep SongTitle | awk {'gsub("SongTitle: ", ""); print $0'}
}

alias skype="LD_PRELOAD=/usr/lib32/libv4l/v4l1compat.so skype"

alias ack=ack-grep

alias ssh-maroko="ssh -t -p 60022 jumski@dev.jumski.com ssh root@127.0.0.1 -p 9999"
# alias vpnbluair="ssh svnbluair exec telnet localhost 7505"
vpnbluair="ssh svnbluair \"echo 'status' | nc localhost 7505\""

alias shoes=/home/jumski/shoes/dist/shoes

function showsizes {
  du --max-depth=1 $1 | sort -n -r
}

function killflash {
  ps ax|grep flashplugin|grep -v grep|awk {'print $1'}|xargs kill
}

function mkcd {
  mkdir $1 && cd $1
}

function list-colors {
  for i in {0..255} ; do printf "\x1b[38;5;${i}mcolour${i}\n"; done
}

function show_regex {
  printf "\e[31m===================================================================\n"
  printf "\e[31m======================== \e[33m$1\e[31m ====================\n"
  printf "\e[31m===================================================================\e[0m\n"
  echo ""
}

# szukaj w app/
function f {
  show_regex "$1"
  ack-grep "$1" app/$2
}
# szukaj definicji ("def metoda") w app
function fm {
  f "def $1" $2
#  f "(def $1|define_method\(:$1|alias_method :$1)" $2
}
# szukaj wywołania (".metoda" lub "metoda")
function fc {
  f "[^def][\.|\s]+$1" $2
}

# szukaj w public/javascripts
function fj {
  show_regex "$1"
  ack-grep "$1" public/javascripts/$2
}
# szukaj deklaracji ("funkcja =") 
function fjm {
  fj "($1 = function|function $1\()" $2
}
# szukaj wywołania ("funkcja(")
function fjc {
  fj "$1\(" $2
}

function gitlogger {
  git log --pretty="%ad - %h - %s" --date=short --author=Wojtek --after="2011-07-$1" --before="2011-07-$2" --no-merges
}

function p {
  ps ax|grep -i $1
}

function work_blubase {
  rvm use 1.8.7 && rvm gemset use blubase
}

function work_antykwariat {
  rvm use 1.9.2 && rvm gemset use rails308 && cd ~/antykwariat && ll
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

function start-vbox-blubase {
  vboxmanage discardstate squeeze
  vboxmanage snapshot squeeze restore "ports forwarded"
  vboxheadless -s squeeze
}

function vbox-forward-port {
  name=$1
  host_port=$2
  guest_port=$3
  protocol=TCP

  vboxmanage setextradata $name "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/HostPort" $host_port
  vboxmanage setextradata $name "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/GuestPort" $guest_port
  vboxmanage setextradata $name "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/Protocol" $protocol

  vboxmanage setextradata $name "VBoxInternal/Devices/e1000/0/LUN#0/Config/ssh/HostPort" $host_port
  vboxmanage setextradata $name "VBoxInternal/Devices/e1000/0/LUN#0/Config/ssh/GuestPort" $guest_port
  vboxmanage setextradata $name "VBoxInternal/Devices/e1000/0/LUN#0/Config/ssh/Protocol" $protocol
}

function show_migration() {
  server=$1
  migration=$2

  ssh $server cat /srv/www/bluBase/current/db/migrate/$migration*
}
alias xevx="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"

function vol() {
  VOLUME="$1"0
  echo "volume set to $VOLUME"
  amixer set Master $VOLUME
}

alias synergys="synergys --config $DOTFILES_PATH/synergy.conf --daemon -l ~/.synergy.log"
