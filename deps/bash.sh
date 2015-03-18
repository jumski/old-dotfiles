bash() {
  require file_linked bashrc $HOME/.bashrc
  require bash_completion_2.0

  bash_completion_2.0() {
    is_met() {
      dpkg -s bash-completion | grep 2.0
    }

    meet() {
      log Removing old bash-completion
      sudo apt-get purge bash-completion

      log Installing bash-completion 2.0
      sudo dpkg -i vendor/bash-completion_2.0-1_all.deb || log "OMG"

      # log GOT IT
      # log `dpkg -l bash-completion`
    }
  }
}
