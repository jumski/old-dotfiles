apt_updated() {
  is_met() {
    sudo apt-get update -y
    true
  }
}
