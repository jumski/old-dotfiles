
mkcd /tmp/dotfiles-install

confirm "Rename gnome Applications-Places-System menus ?"
if [ $? -eq 0 ]
then
  msgfmt $DOTFILES_PATH/gnome/replace-app-places-system
  sudo mv messages.mo /usr/share/locale-langpack/en/LC_MESSAGES/gnome-panel-2.0.mo
  pkill gnome-panel
fi

confirm "Install gnome-solarized color theme ?"
if [ $? -eq 0 ]
then
  git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git
  cd gnome-terminal-colors-solarized
  ./install.sh
fi
