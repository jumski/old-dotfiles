alias g=/home/jumski/gmate/g

alias jungletrain="mocp -l http://stream2.jungletrain.net:8000"
alias bassdrive="mocp -l http://shouthostdirect13.streams.bassdrive.com:8202"
alias livednb="mocp -l http://173.236.56.82:8006"
alias iwayhigh="mocp -l http://70.38.71.74:8000"
alias groovesalad="mocp -l http://streamer-ntc-aa06.somafm.com:80/stream/1018"
alias spacestationsoma="mocp -l http://207.200.96.231:8012"

function f {
  printf "\e[31m===================================================================\n"
  printf "\e[31m======================== \e[33m$1\e[31m ====================\n"
  printf "\e[31m===================================================================\e[0m\n"
  echo ""
  ack-grep "$1" app/$2
}

function fm {
  f "def $1" $2
}

function fc {
  f "(\.|\s+)$1" $2
}
