
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

cdscr() {
  cd ~/scratch/*$1*
}

downloaded(){
  ifconfig ppp0 | grep 'RX bytes'
}

drop_caches() {
  sudo sync && sudo echo 3 | sudo tee /proc/sys/vm/drop_caches
}

rtfm() { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }

# ruby related
zeus_custom_plan() {
  cp $DOTFILES_PATH/zeus_custom_plan.rb custom_plan.rb
  echo " > copied custom_plan.rb"

  echo "custom_plan.rb" >> .gitignore
  echo " > added to gitignore"
}
