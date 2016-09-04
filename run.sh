#!/usr/bin/env bash

echo "Expand filesystem using `raspi-config` (Launching raspi-config in 3 seconds)"
sleep 3
sudo raspi-config
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
