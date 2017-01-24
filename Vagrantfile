# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y build-essential libncurses5-dev libssl-dev
    apt-get install -y exuberant-ctags git bc

    dpkg --add-architecture i386

    apt-get update
    apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
  SHELL
end
