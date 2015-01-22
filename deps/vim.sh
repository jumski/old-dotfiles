vim() {
  require vim_from_source
  require vim_with_neobundle

  vim_with_neobundle() {
    require file_linked vim/vimrc $HOME/.vimrc
    require vim_tmp_dir

    neobundle_path=~/.vim/bundle/neobundle.vim

    is_met() {
      [[ -d $neobundle_path ]]
    }
    meet() {
      mkdir -p ~/.vim/bundle
      git clone https://github.com/Shougo/neobundle.vim $neobundle_path
      vim -c ":NeoBundleInstall" -c ":qa"
    }

    vim_tmp_dir() {
      is_met() {
	test -d $HOME/.vim-tmp
      }
      meet() {
	mkdir -p $HOME/.vim-tmp
      }
    }
  }
}
