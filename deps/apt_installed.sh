apt_installed() {
  name=$1

  is_met() {
    dpkg -s $name | grep "ii " 2>&1 >/dev/null
  }

  meet() {
    log Installing \'$name\' via apt-get
    sudo apt-get install -y $name
  }
}
