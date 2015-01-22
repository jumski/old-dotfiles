bundle_installed(){
  version=$1

  require rvm_ruby_used $version

  # rvm_use() {
  #   rvm use ruby-$version
  # }

  is_met() {
    bundle check
  }

  meet() {
    bundle install
  }
}
