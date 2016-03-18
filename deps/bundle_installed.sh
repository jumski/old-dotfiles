bundle_installed(){
  version=$1

  require rvm_ruby_installed $version

  rvm_use() {
    source ~/.rvm/scripts/rvm &&
      rvm use ruby-$version
  }

  is_met() {
    rvm_use && bundle check
  }

  meet() {
    rvm_use && gem install bundler && bundle install
  }
}
