file_linked() {
  src=$1
  dst=$2

  is_meet() {
    test -h $dst && diff $src $dst
  }

  meet() {
    ln -s $src $dst || sudo ln -s $src $dst
  }
}
