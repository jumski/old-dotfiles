# add dotfiles/bin to $PATH

grep dotfiles /home/vagrant/.profile || {
  echo "PATH=/home/vagrant/dotfiles/bin:$PATH" >> /home/vagrant/.profile
}
