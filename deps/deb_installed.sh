  dpkg_finds() {
    name=$1
    dpkg -r $name | grep " ii " 2>&1 >/dev/null
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
