
# creates new temp dir and opens new tmux window
scr(){
  if [ -z "$TMUX" ]; then
    echo "Please start tmux first!"
    exit 1
  fi

  local scratch_base_dir="$HOME/scratch"
  local current_date=$(date +%Y-%m-%d--%H:%M)
  local new_scratch_dir="${scratch_base_dir}/${current_date}"

  if [ -n "$1" ]; then
    local scratch_title=$( echo "$1" | sed 's/[^a-zA-Z0-9_-]/_/g')
    local new_scratch_dir+="--${scratch_title}"

    local window_title="scratch: ${scratch_title}"
  else
    local window_title="scratch"
  fi

  mkdir -p $new_scratch_dir
  echo ln -sf $new_scratch_dir/ $scratch_base_dir/current
  # ln -sf $new_scratch_dir/ $scratch_base_dir/current

  tmux new-window -n "$window_title" "cd ${new_scratch_dir}; bash -i"
}
cdscr() { cd ~/scratch/*$1*; }

stage() {
  git fetch -a &&
    git rebase master &&
    git push -f &&
    cap staging deploy

  alert
}

# jet-pack bootstrapper
# see: https://github.com/raul/jet-pack
jp()
{
  if [ "$1" == "" ]; then
    echo "Usage:  jp <YOUR-APP-NAME>"
  else
    git clone git://github.com/raul/jet-pack.git $1
    cd $1
    rm -rf .git
    bundle
    git init .
    git add *
    git add .gitignore
    git commit -a -m"jet-pack boilerplate"
  fi
}

mux-edit() {
  SESSION="$1"
  if [ "$SESSION" == "" ]; then
    SESSION=`tmux_current_session`
  fi
  vim ~/dotfiles/tmuxinator/$SESSION.yml;
}

# rspec - runn all, but fail if bad factories
allspec() {
  local command
  command="rspec --fail-fast spec/factories_spec.rb spec/ ; alert"

  if [ -S .zeus.sock ]; then
    echo "running using Zeus"
    zeus $command
  else
    echo "running bare rspec"
    $command
  fi

}

sizes() { du --max-depth=1 -h .; }
dux() { du -kchxa -d 1 . | sort -h; }

# workflow enhancements ..............................
mkcd()      { mkdir $1 && cd $1; }
coltree()   { tree -C $@ | less -R; }
..()        { cd .. ; }
...()       { cd ../.. ; }
-()         { cd -; }
p()         { pgrep -fl "$1"; }
killflash() { pkill -f flashplugin; }
killjackd() { pkill --signal QUIT -f jackd; }
rtfm()      { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }
fname()     { find . -iname "*$@*"; }
repeat() {
  n=$1
  i=0
  shift

  echo "Repeating \`$@\` $n times"
  echo

  while [ $(( i += 1 )) -le $n ]
  do
    echo "= Run #$i ($@)"
    eval "$@"
  done
}
loop() {
  i=0

  echo "Looping \`$@\`"
  echo

  while true; do
    i=$((i += 1 ))
    echo "= Iteration #$i ($@)"
    eval "$@"
  done
}
retry() {
  while ! "$@"; do sleep 1; done
}

# apt .....................................
function s { apt-cache search "$@" | sort | less; }
function i {
  if ! grep "$1" $DOTFILES_PATH/conf/deb_list; then
    sudo apt-get install $1
    echo "$1" >> $DOTFILES_PATH/conf/deb_list
  fi
}

# others ....................................
drop_caches() { sudo sync && sudo echo 3 | sudo tee /proc/sys/vm/drop_caches; }

# ruby related ..............................
init_zeus() {
  cp $DOTFILES_PATH/zeus_custom_plan.rb custom_plan.rb
  echo " > copied custom_plan.rb"
  cp $DOTFILES_PATH/zeus.json ./
  echo " > copied zeus.json"

  echo "custom_plan.rb" >> .gitignore
  echo "zeus.json" >> .gitignore
  echo " > added to gitignore"
}
killzeus() {
  ps ax|grep zeus|grep -v grep|awk '{print $1}'|xargs kill -9
  test -S .zeus.sock && rm .zeus.sock
  reset
}
precompile() {
  git rm -rfq public/assets; rake assets:precompile RAILS_ENV=production && git add public/assets
}

# big stuff ................................
list-colors() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i} ";
  done
}

confirm() {
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


### BACKUPZZZ
single_backup() {
  mv /mnt/loop1/jumski/$1/ /home/jumski/$1/
}
multi_backup() {
  for name in $*
  do
    single_backup $name
  done
}

histgrep() { history | grep "$1" | sort -uh; }

cdproject() {
  if [ -z "$1" ]; then
    project_name=$(basename `pwd`)
  else
    project_name="$1"
  fi

  cd ~/projects/$project_name
}

cdwork() {
  if [ -z "$1" ]; then
    project_name=$(basename `pwd`)
  else
    project_name="$1"
  fi

  cd ~/work/$project_name
}

parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}


prefix_with_dates() {
  awk '{ print strftime("%Y-%m-%d %H:%M:%S"), $0; fflush(); }'
}
