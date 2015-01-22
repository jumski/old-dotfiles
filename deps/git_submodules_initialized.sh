git_submodules_initialized() {
  require apt_installed git

  is_met() {
    git submodule status | egrep -v "^-"
  }

  meet() {
    git submodule update --init
  }
}
