git_submodules_initialized() {
  is_met() {
    git submodule status | egrep -v "^-"
  }

  meet() {
    git submodule update --init
  }
}
