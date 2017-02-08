# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y build-essential git libguestfs-tools
    update-guestfs-appliance
    wget "https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64"
    install jq-linux64 /usr/bin/jq
    rm jq-linux64
  SHELL
end
