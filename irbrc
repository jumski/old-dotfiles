
require 'bundler'
ENV['BUNDLE_GEMFILE'] = File.join(ENV["DOTFILES_PATH"], 'Gemfile')
Bundler.require(:default)

require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true

require File.join(ENV['DOTFILES_PATH'], 'ruby', 'repl_macros.rb')


# use pry everywhere
# This script comes from Pry Everywhere by Luca Pette
# http://lucapette.com/pry/pry-everywhere/

# https://github.com/carlhuda/bundler/issues/183#issuecomment-1149953
if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  if global_gemset
    all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
    all_global_gem_paths.each do |p|
      gem_path = "#{p}/lib"
      $LOAD_PATH << gem_path
    end
  end
end

# Use Pry everywhere
# require "rubygems"
# require 'pry'
# Pry.start
# exit
