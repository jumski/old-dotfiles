node_installed() {
  require nvm_installed

  is_met() {
    source ~/.nvm/nvm.sh &&
      nvm use 5 2>&1 >/dev/null &&
      npm help 2>&1 >/dev/null
  }

  meet() {
    source ~/.nvm/nvm.sh &&
      nvm use 5 2>&1 >/dev/null &&
      nvm install 5 2>&1 >/dev/null
  }
}
