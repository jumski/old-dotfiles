alias g=/usr/bin/gmate

alias jungletrain="mocp -l http://stream2.jungletrain.net:8000"
alias bassdrive="mocp -l http://shouthostdirect13.streams.bassdrive.com:8202"
alias livednb="mocp -l http://173.236.56.82:8006"
alias iwayhigh="mocp -l http://70.38.71.74:8000"
alias groovesalad="mocp -l http://streamer-ntc-aa06.somafm.com:80/stream/1018"
alias spacestationsoma="mocp -l http://207.200.96.231:8012"
alias realias="source ~/.bash_aliases && echo 'reloaded .bash_aliases'"

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias tmux="tmux -f ~/tmux.conf"
alias compile_tags="ctags -R --exclude=.git --exclude=log * $GEM_HOME/gems/*"
alias fav="~/various/fav"

function dotfiles_help {
	echo "========= dotfiles help"
	echo " -> solarized gnome terminal:"
	echo
	echo "    git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git"
	echo "    cd gnome-terminal-colors-solarized"
	echo "    ./install.sh"
	echo
	echo " -> dircolors-solarized"
	echo
	echo "    git clone git://github.com/huyz/dircolors-solarized.git"
	echo "    eval `dircolors /home/jumski/src/dircolors-solarized/dircolors.ansi-universal`"
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
