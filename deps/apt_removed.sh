apt_removed() {
  names="$@"

  is_met() {
    ! dpkg -s $names
  }

  meet() {
    sudo apt-get purge -y $names
  }
}
