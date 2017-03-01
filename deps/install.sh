install(){
  # require apt_updated
  # require node_modules_installed
  # require file_linked node_modules/instant-markdown-d/instant-markdown-d bin/instant-markdown-d
  # require git_submodules_initialized
  # require bundle_installed 2.1.2

  require file_linked tmux.conf $HOME/.tmux.conf
  require file_linked gitconfig $HOME/.gitconfig
  require file_linked gitignore_global $HOME/.gitignore_global
  require file_linked psqlrc $HOME/.psqlrc
  require file_linked curlrc $HOME/.curlrc
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
  require file_linked Xresources $HOME/.Xresources
  require file_linked sh-todo $HOME/.sh-todo
  require file_linked erdconfig $HOME/.erdconfig
  require file_linked inputrc $HOME/.inputrc
  require file_linked psqlrc $HOME/.psqlrc
  require file_linked ansible.cfg $HOME/.ansible.cfg
  require file_linked vim/vimrc $HOME/.vimrc
  require file_linked $HOME/Dropbox/private/ssh-config $HOME/.ssh/config
  require file_linked dir_colors $HOME/.dir_colors

  #require vim
  # require bash

  # require dropbox
}
