apt_installed() {
  name=$1

  is_met() {
    dpkg_finds $name
  }

  meet() {
    sudo apt-get install -y $name
  }
}
