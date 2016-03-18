nvm_installed() {
  require apt_installed curl

  is_met() {
    source ~/.nvm/nvm.sh && nvm help 2>&1 >/dev/null
  }

  meet() {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
  }
}
