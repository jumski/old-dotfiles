vim() {
  require file_linked vim/vimrc $HOME/.vimrc
  require vim_tmp_dir
  require neobundle_installed

  neobundle_installed() {
    require vim_74_installed

    is_met() {
      [[ -d ~/.vim/bundle/neobundle.vim ]]
    }
    meet() {
      mkdir -p ~/.vim/bundle
      git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
      vim -c ":NeoBundleInstall" -c ":qa"
    }
  }

  vim_tmp_dir() {
    is_met() {
      test -d $HOME/.vim-tmp
    }
    meet() {
      mkdir -p $HOME/.vim-tmp
    }
  }

  vim_74_installed() {
    is_met() {
      which vim && vim --help | head -1 | grep 7.4
    }

    required_debs="libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial"
    unwanted_debs="vim vim-tiny vim-common vim-gui-common"

    meet() {
      log Installing stuff required to build vim: $required_debs
      sudo apt-get install $required_debs

      log Removing unwanted stuff: $unwanted_debs
      sudo apt-get remove $unwanted_debs

      cd `mkdtemp -d`
      hg clone https://code.google.com/p/vim/
      pushd vim
      ./configure --with-features=huge \
	--enable-multibyte \
	--enable-rubyinterp \
	--enable-pythoninterp \
	--with-python-config-dir=/usr/lib/python2.7/config \
	--enable-perlinterp \
	--enable-luainterp \
	--enable-gui=gtk2 --enable-cscope --prefix=/usr
      make VIMRUNTIMEDIR=/usr/share/vim/vim74
      sudo make install
    }
  }
}
