
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
alias lh='ls --color=always -lasth | less -R'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias mkdir='mkdir -p'

alias g=hub
alias git=hub
alias gs="git status -sb"
alias gps="git push"
alias gd="git diff"
alias gcim="!git-cim"
alias gcim="commit"
alias t=tig
alias ts="tig status"
alias vi=vim
alias xo=xdg-open
complete -o default -o nospace -F _git g
complete -o default -o nospace -F _git_status gs
complete -o default -o nospace -F _git_diff gd

alias r=rspec

alias updatedb="sudo updatedb"

## CUSTOM ALIASES
alias ack=ack-grep
alias tf="tail -100f"
alias k9="kill -9 "
alias parallel="parallel --gnu"

alias visor="supervisorctl -c /home/jumski/dotfiles/conf/supervisord.conf"

alias biggest="du -hs * | sort -h | column -t"


alias jungletrain="mocp -l http://stream6.jungletrain.net:8000"
alias bassdrive="mocp -l http://shouthost.com.32-1.streams.bassdrive.com:8200"
alias livednb="mocp -l http://173.236.56.82:8006"
alias iwayhigh="mocp -l http://72.55.137.82:8000"
alias minimal_uziz="mocp -l http://stream.uzic.ch:9010/"
alias minimal_electropulse="mocp -l http://142.4.212.27:9998/"
alias minimal_toxors='mocp -l http://toxxor.de:8000/'
alias minimal_minimalmix='mocp -l http://sc3.24cast.pl:7756/'

alias soma_groovesalad="mocp -l http://mp3.somafm.com:80"
alias soma_sonicuniverse="mocp -l http://sfstream1.somafm.com:8600"
alias soma_suburbsofgoa="mocp -l http://sfstream1.somafm.com:8850"
alias soma_beatblender="mocp -l http://sfstream1.somafm.com:8384"
alias soma_thetrip="mocp -l http://sfstream1.somafm.com:2504"
alias soma_cliqhop="mocp -l http://mp2.somafm.com:2668"
alias soma_doomed="mocp -l http://sfstream1.somafm.com:8300"
alias soma_somaevents="mocp -l http://sfstream1.somafm.com:6200"
alias soma_dubstepbeyond="mocp -l http://mp4.somafm.com:8400"
alias soma_missioncontrol="mocp -l http://mp1.somafm.com:2020"
alias soma_streetlounge="mocp -l http://sfstream1.somafm.com:8500"
alias soma_dronezone="mocp -l http://mp4.somafm.com:80"
alias soma_spacestationsoma="mocp -l http://mp2.somafm.com:2666"
alias soma_ambientdrones="mocp -l http://srv3.electro-music.com:8500/"

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias compile_tags="ctags -R --exclude=.git --exclude=log * $GEM_HOME/gems/*"
alias realias="source $DOTFILES_PATH/bash/aliases.sh && echo 'reloaded .bash/aliases.sh'"

alias fav="~/various/fav"
alias favgrep="~/various/favgrep"

alias spreed='while read line; do for word in $line; do echo -en "\r\033[K          $word"; sleep 0.2; done; done; echo'
alias bigspreed='(while read line; do for word in $line; do clear; for i in `seq $(($(($LINES / 2)) - 4))`; do echo; done; figlet -w $COLUMNS $word; sleep 0.2; done; done; echo)'

alias skype="LD_PRELOAD=/usr/lib32/libv4l/v4l1compat.so skype"

alias ssh-maroko="ssh -t -p 60022 jumski@dev.jumski.com ssh root@127.0.0.1 -p 9999"
vpnbluair="ssh svnbluair \"echo 'status' | nc localhost 7505\""

alias xevx="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"

alias goprod="export RAILS_ENV=production; echo 'Rails.env set to production'"
alias godev="export RAILS_ENV=development; echo 'Rails.env set to development'"

alias joodo="lein joodo"

alias humandate="date +\"%Y-%m-%d\""

alias prettyjson="python -mjson.tool"

alias docker="sudo docker"
alias dockerlite="sudo dockerlite"
alias babushka="babushka --no-color"
alias coffeewatch="coffee -bcw"
alias karma="./node_modules/.bin/karma"

alias pgsizes='psql -c "SELECT pg_database.datname, pg_database_size(pg_database.datname), pg_size_pretty(pg_database_size(pg_database.datname)) FROM pg_database ORDER BY pg_database_size DESC;"'

alias bc="bc -l"


## logstash specific
disconf() {
  mv $1 $(basename --suffix=.conf $1)
}
enconf() {
  mv $1 ${1}.conf
}
