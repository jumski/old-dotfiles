install(){
  require apt_updated
  require git_submodules_initialized
  require bundle_installed 2.1.2

  require file_linked tmux.conf $HOME/.tmux.conf
  require file_linked gitconfig $HOME/.gitconfig
  require file_linked gitignore_global $HOME/.gitignore_global
  require file_linked psqlrc $HOME/.psqlrc
  require file_linked gemrc $HOME/.gemrc
  require file_linked irbrc $HOME/.irbrc
  require file_linked pryrc $HOME/.pryrc
  require file_linked ackrc $HOME/.ackrc
  require file_linked agignore $HOME/.agignore
  require file_linked kderc $HOME/.kderc
  require file_linked vromerc $HOME/.vromerc
  require file_linked xhotkeys $HOME/.xhotkeys
  require file_linked vendor/dircolors.256dark $HOME/.dircolors
  require file_linked bundle $HOME/.bundle
  require file_linked tmuxinator $HOME/.tmuxinator
  require file_linked dotjs $HOME/.js
  require file_linked irssi $HOME/.irssi
  require file_linked Xdefaults $HOME/.Xdefaults
  require file_linked sh-todo $HOME/.sh-todo
  require file_linked erdconfig $HOME/.erdconfig
  require file_linked inputrc $HOME/.inputrc

  require vim
  require bash

  require dropbox
}
