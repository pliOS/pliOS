# pliOS

To build pliOS in a Vagrant VM (recommended), run:
```sh
cd wherever/you/want/to/build/plios

git clone https://github.com/pliOS/pliOS

vagrant up
vagrant ssh
```

And inside the VM, run:

```sh
cd /vagrant

./build/configure

make
```

If you don't want to use Vagrant, run the following commands on a linux machine:

```sh
apt-get update
apt-get install -y build-essential libncurses5-dev libssl-dev
apt-get install -y exuberant-ctags git bc

dpkg --add-architecture i386

apt-get update
apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386

cd wherever/you/want/to/build/plios

git clone https://github.com/pliOS/pliOS

./build/configure

make
```
