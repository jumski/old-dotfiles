
require File.join(ENV['DOTFILES_PATH'], 'ruby', 'repl_macros.rb')
require File.join(ENV['DOTFILES_PATH'], 'ruby', 'list_of_models.rb')
Pry.config.theme = 'solarized'

Pry.config.commands.alias_command "sm", "show-method"
