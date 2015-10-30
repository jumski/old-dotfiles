pip_package_installed() {
  package="$1"

  is_met() {
    pip show "$package" | grep Version
  }

  meet() {
    sudo pip install "$package"
  }
}
