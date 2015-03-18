vim() {
# sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
# sudo update-alternatives --config vi
# sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
# sudo update-alternatives --config vim
# sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
# sudo update-alternatives --config editor

  require vim_from_source
  require vim_tmp_dir
  # require YouCompleteMe_compiled
  # require NeoBundle_installed

  NeoBundle_installed() {
    require apt_installed curl

    is_met() {
      vim -c :NeoBundleLog -c :q
    }

    meet() {
      curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
    }
  }

  vim_tmp_dir() {
    dir=$HOME/.vim-tmp
    is_met() { test -d $dir; }
    meet()   { mkdir -p $dir; }
  }

  # YouCompleteMe_compiled() {
  #   require repo_cloned https://github.com/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe
  #
  #   is_met() {
  #
  #   }
  # }

  # NeoBundle_installed() {
  #   require file_linked vim/vimrc $HOME/.vimrc
  #
  #   neobundle_path=~/.vim/bundle/neobundle.vim
  #
  #   is_met() {
  #     [[ -d $neobundle_path ]]
  #   }
  #   meet() {
  #     mkdir -p ~/.vim/bundle
  #     git clone https://github.com/Shougo/neobundle.vim $neobundle_path
  #     vim -c ":NeoBundleInstall" -c ":qa"
  #   }
  #
  # }
}
