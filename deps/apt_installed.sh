apt_installed() {
  names="$@"

  is_met() {
    log dpkg -s $names
    dpkg -s $names
  }

  meet() {
    log sudo apt-get install -y $names
    sudo apt-get install -y $names
  }
}
