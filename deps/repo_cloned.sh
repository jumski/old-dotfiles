repo_cloned() {
  require apt_installed git

  url=$1
  path=$2

  is_met() {
    cd $path && git status
  }

  meet() {
    git clone "$url" "$path"
  }
}
