
# require 'bundler'
# ENV['BUNDLE_GEMFILE'] = File.join(ENV["DOTFILES_PATH"], 'Gemfile')
# Bundler.require(:default)

require 'irb/completion'
require 'awesome_print'
require 'rubygems'
require File.join(ENV['DOTFILES_PATH'], 'ruby', 'repl_macros.rb')
require File.join(ENV['DOTFILES_PATH'], 'ruby', 'list_of_models.rb')

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:HISTORY_FILE] = '~/.irb_history'
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1024
