rvm_ruby_installed() {
  require rvm_installed

  version=$1

  source_rvm() {
    log Sourcing ~/.rvm/scripts/rvm
    source ~/.rvm/scripts/rvm
  }

  is_met() {
    source_rvm

    rvm list | grep $version
  }

  meet() {
    source_rvm

    log Installing $version
    rvm install $version
  }
}
