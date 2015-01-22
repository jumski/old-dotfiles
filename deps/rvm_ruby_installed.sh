rvm_ruby_installed() {
  version=$1

  is_met() {
    rvm list | grep $version
  }

  meet() {
    log Installing $version
    rvm install $version
  }
}
