#!/usr/bin/env bash

echo "Installing rsync"
sudo apt-get update
sudo apt-get install rsync
echo "Merging files/ with /"
sudo rsync -avh files/ /

echo "Installing Resilio Sync"
mkdir rslsync
cd rslsync
wget https://download-cdn.resilio.com/stable/linux-arm/resilio-sync_arm.tar.gz
tar -xzvf resilio-sync_arm.tar.gz
sudo mv rslsync /usr/bin
cd ..

sudo ln -s /lib/arm-linux-gnueabihf/ld-linux.so.3 /lib/ld-linux.so.3
sudo systemctl enable resilio-sync

#echo "Generating SSL certificate"
#ssh-keygen -t rsa
# Move to `/etc/ssl/certs/raspi.crt` and `/etc/ssl/private/raspi.key`, resp.

echo "Mounting data drive"
sudo mkdir /mnt/exti
sudo bash -c "echo '/etc/sda1 /mnt/exti ext4 defaults,noatime 0 0' >> /etc/fstab"
sudo mount -a

echo "Starting Resilio Sync"
sudo systemctl start resilio-sync
