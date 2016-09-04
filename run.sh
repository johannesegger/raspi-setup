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
sudo rsync -avh files /

echo "Installing btsync"
mkdir btsync
cd btsync
wget https://download-cdn.getsync.com/stable/linux-arm/BitTorrent-Sync_arm.tar.gz
tar -xzvf BitTorrent-Sync_arm.tar.gz
sudo mv btsync /usr/bin
sudo update-rc.d btsync defaults
cd ..

echo "Mounting data drive"
sudo bash -c "echo '/etc/sda1 /mnt/exti ext4 defaults 0 0' >> /etc/fstab"
sudo mount -a

echo "Starting btsync"
sudo service btsync start
