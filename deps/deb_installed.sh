deb_installed() {
  dpkg_finds() {
    name=$1
    dpkg -s $name | grep "ii " 2>&1 >/dev/null
  }

  is_met() {
    dpkg_finds $name
  }

  dpkg_installed() {
    path=$1
    name=`basename --suffix='.deb' $1`

    is_met() {
      dpkg_finds $name
    }

    meet() {
      sudo dpkg -i $path
    }
  }

}
