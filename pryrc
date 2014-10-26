
require File.join(ENV['DOTFILES_PATH'], 'ruby', 'repl_macros.rb')
require File.join(ENV['DOTFILES_PATH'], 'ruby', 'list_of_models.rb')
Pry.config.theme = 'solarized'

Pry.config.commands.alias_command "sm", "show-method"
Pry.config.commands.alias_command "s", "show-method"
Pry.config.commands.alias_command "w", "whereami"
