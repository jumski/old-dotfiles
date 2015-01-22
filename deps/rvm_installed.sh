rvm_installed(){
  is_met() {
    source ~/.rvm/scripts/rvm && rvm --version
  }

  meet() {
    log "Installing rvm..."

    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable
  }
}

