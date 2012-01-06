require 'rubygems'
require 'rake'
require 'fileutils'
require 'pry'

LINKABLES = {
  'vendor/dircolors.256dark' => '~/.dircolors',
  'vendor/kde/share/apps/konsole/*' => '~/.kde/share/apps/konsole/%',
  %w(bashrc tmux.conf gitconfig vimrc gemrc irbrc) => '~/.%'
}

DOTFILES_PATH = ENV["DOTFILES_PATH"]

task :install do
  LINKABLES.each do |path, destination|
    # puts
    # puts path.inspect

    next if path.nil?

    if path.include?('*')
      Dir.glob("#{DOTFILES_PATH}/#{path}").each do |file|
        link_to file, destination
      end
    elsif path.respond_to?(:each)
      path.each do |file|
        link_to file, destination
      end
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

  # puts file
  # puts destination_path
  `ln -s #{file} #{destination_path}`
  # %x[ ln -s #{destination_path}

  # FileUtils.ln_s "#{DOTFILES_PATH}/#{file}" destination_path
end
