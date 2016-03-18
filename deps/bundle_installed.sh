bundle_installed(){
  version=$1

  require rvm_ruby_installed $version
  require apt_installed imagemagick

  is_met() {
    source ~/.rvm/scripts/rvm &&
      rvm use ruby-$version &&
      bundle check
  }

  meet() {
    source ~/.rvm/scripts/rvm &&
      rvm use ruby-$version &&
      gem install bundler &&
      bundle install
  }
}
