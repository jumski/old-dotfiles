
# require 'bundler'
# ENV['BUNDLE_GEMFILE'] = File.join(ENV["DOTFILES_PATH"], 'Gemfile')
# Bundler.require(:default)

require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true

require File.join(ENV['DOTFILES_PATH'], 'ruby', 'repl_macros.rb')
require File.join(ENV['DOTFILES_PATH'], 'ruby', 'list_of_models.rb')
