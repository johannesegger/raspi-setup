#!/usr/bin/env bash

echo "Setting up static IP address"
sudo bash -c "echo '
iface eth0 inet static
    address 192.168.0.14
    network 192.168.0.0
    netmask 255.255.255.0
    broadcast 192.168.0.255
    gateway 192.168.0.1' >> /etc/network/interfaces"

echo "Installing rsync"
sudo apt-get install rsync
echo "Merging files/ with /"
sudo rsync -avh files/ /

echo "Installing Resilio Sync"
mkdir rslsync
cd rslsync
wget https://download-cdn.resilio.com/stable/linux-arm/resilio-sync_arm.tar.gz
tar -xzvf resilio-sync_arm.tar.gz
sudo mv rslsync /usr/bin
sudo update-rc.d rslsync defaults
cd ..

echo "Mounting data drive"
sudo mkdir /mnt/exti
sudo bash -c "echo '/etc/sda1 /mnt/exti ext4 defaults,noatime 0 0' >> /etc/fstab"
sudo mount -a

echo "Starting Resilio Sync"
sudo ln -s /lib/arm-linux-gnueabihf/ld-linux.so.3 /lib/ld-linux.so.3
sudo service rslsync start
