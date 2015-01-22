rvm_ruby_used() {
  version=$1

  require rvm_ruby_installed $version

  is_met() {
    ruby --version | grep $version
  }

  meet() {
    log Switching to ruby $version
    rvm use $version
  }
}
