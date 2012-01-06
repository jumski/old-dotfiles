require 'rubygems'
require 'rake'

DOTFILES_PATH="~/dotfiles"

task :install do
  %(bashrc tmux.conf gitconfig vimrc gemrc irbrc).each do |name|
    link_to_home file
  end

  OTHER_LINKABLES.each_with_index do |file, destination|
    next if file.nil?

    FileUtils.mkdir_p destination
    FileUtils.rm "~/#{destination}/#{file}"
    FileUtils.ln_s "#{file}" "~/#{destination}/#{file}"
  end
end

OTHER_LINKABLES = {
  'vendor/dircolors.256dark' => '.dircolors',
  'vendor/kde/share/apps/konsole/konsoleui.rc' => 'vendor/kde/share/apps/konsole/konsoleui.rc',
  'vendor/kde/share/apps/konsole/jumshell.profile' => 'vendor/kde/share/apps/konsole/jumshell.profile',
  'vendor/kde/share/apps/konsole/solarized_dark.colortheme' => 'vendor/kde/share/apps/konsole/solarized_dark.colortheme',
}

def link_to_home(file)
  home_path = "~/.#{file}"
  FileUtils.rm home_path
  FileUtils.ln_s file, home_path 
end
