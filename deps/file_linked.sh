file_linked() {
  src=$1
  dst=$2

  is_met() {
    abs_src=`readlink -f $src`

    test -h $dst && diff $abs_src $dst
  }

  meet() {
    abs_src=`readlink -f $src`

    log Linking \'$abs_src\' to \'$dst\'
    ln -sf $abs_src $dst || sudo ln -s $abs_src $dst
  }
}