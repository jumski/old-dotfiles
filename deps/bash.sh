bash() {
  require file_linked bashrc $HOME/.bashrc
  require has_20_bash_completion

  has_20_bash_completion() {
    is_met() {
      dpkg -l | grep bash-completion | awk '{print $3}' | grep '2.0'
    }

    meet() {
      log intalling bash-completion 2.0
      sudo apt-get purge bash-completion &&
      sudo dpkg -i ../vendor/bash-completion_2.0-1_all.deb
    }
  }
}
