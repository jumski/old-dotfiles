# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = 'trusty-amd64-dev'
  # config.vm.box = 'ubuntu-14.04-amd64'
  # config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/trusty-server-cloudimg-amd64-juju-vagrant-disk1.box"

  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.memory = "2048"
  end

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./", "/home/vagrant/dotfiles"

  config.vm.provision "shell", path: 'provision.sh'
end
