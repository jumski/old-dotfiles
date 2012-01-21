
require 'bundler/setup'
ENV['BUNDLE_GEMFILE'] = File.join(ENV["DOTFILES_PATH"], 'Gemfile')
Bundler.require(:default, :pry)

require File.join(ENV['DOTFILES_PATH'], 'ruby', 'repl_macros.rb')
