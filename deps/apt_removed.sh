apt_removed() {
  name=$1

  is_met() {
    ! dpkg -s $name | grep "ii " 2>&1 >/dev/null
  }

  meet() {
    sudo apt-get purge -y $name
  }
}
