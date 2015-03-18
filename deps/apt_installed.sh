apt_installed() {
  # https://github.com/ilikenwf/apt-fast
  names="$@"

  is_met() {
    log dpkg -s $names
    dpkg -s $names
  }

  meet() {
    log sudo apt-get install -y --force-yes $names
    sudo apt-get install -y $names
  }
}
