require 'rubygems'
require 'rake'
require 'fileutils'
require 'pry'

# LINKABLES = {
#   # 'vendor/dircolors.256dark' => '~/.dircolors',
#   # 'vendor/kde/share/apps/konsole/*' => '~/.kde/share/apps/konsole/%',
#   %w(bashrc tmux.conf gitconfig vimrc gemrc irbrc) => '~/.%'
# }
linkable :source      => 'vendor/dircolors.256dark',
         :destination => '~/.dircolors'
linkable :source      => 'vendor/kde/share/apps/konsole/*',
         :destination => '~/.kde/share/apps/konsole/%'
linkable :source %w(bashrc tmux.conf gitconfig vimrc gemrc irbrc) => '~/.%'

DOTFILES_PATH = ENV["DOTFILES_PATH"]

task :install do
  LINKABLES.each do |source, destination|
    # puts
    # puts path.inspect

    next if source.nil?

    if source.include?('*')
      Dir.glob("#{DOTFILES_PATH}/#{source}").each do |path|
        link_to path, destination
      end
    elsif source.respond_to?(:each)
      source.each {|path| link_to path, destination}
    else
      link_to path, destination
    end
  end
end

# if % is found in destination, put file name instead
# and link to this path
#
# otherwise link to destination/file
def link_to(file, destination)
  if destination.include?('%')
    destination_path = destination.gsub('%', File.basename(file))
  else
    destination_path = "#{destination}"
  end

  puts file
  puts destination_path
  # `ln -s #{file} #{destination_path}`
  # %x[ ln -s #{destination_path}

  # FileUtils.ln_s "#{DOTFILES_PATH}/#{file}" destination_path
end
