#!/usr/bin/env bash

echo "Installing rsync"
sudo apt-get update
sudo apt-get install rsync
echo "Merging files/ with /"
sudo rsync -avh files/ /

echo "Installing Resilio Sync"
# https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux
echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
wget -qO - https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install resilio-sync
sudo sed -i '/WantedBy=multi-user\.target/c\WantedBy=default.target' /usr/lib/systemd/user/resilio-sync.service
sudo systemctl enable resilio-sync

#echo "Generating SSL certificate"
#ssh-keygen -t rsa
# Move to `/etc/ssl/certs/raspi.crt` and `/etc/ssl/private/raspi.key`, resp.

echo "Mounting data drive"
sudo mkdir /mnt/exti
sudo bash -c "echo '/etc/sda1 /mnt/exti ext4 defaults,noatime 0 0' >> /etc/fstab"
sudo mount -a

echo "Starting Resilio Sync"
systemctl --user start resilio-sync
