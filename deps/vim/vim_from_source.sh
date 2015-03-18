vim_from_source() {
  require apt_installed \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python-dev \
    ruby-dev \
    mercurial

  is_met() {
    vim --version | grep 7.4
  }

  meet() {
    log Removing some old packages...
    sudo apt-get remove -y vim vim-runtime gvim

    cd `mktemp -d`

    log Cloning vim repo...
    hg clone https://code.google.com/p/vim/
    cd vim
    ./configure --with-features=huge \
      --enable-multibyte \
      --enable-rubyinterp \
      --enable-pythoninterp \
      --with-python-config-dir=/usr/lib/python2.7/config \
      --enable-perlinterp \
      --enable-luainterp \
      --enable-gui=gtk2 --enable-cscope --prefix=/usr

    log Compiling vim...
    make VIMRUNTIMEDIR=/usr/share/vim/vim74
    sudo make install
  }
}

