#!/usr/bin/env bash

echo "Installing rsync"
apt-get update
apt-get install rsync
echo "Merging files/ with /"
rsync -avh files/ /

echo "Installing Resilio Sync"
mkdir rslsync
cd rslsync
wget https://download-cdn.resilio.com/stable/linux-arm/resilio-sync_arm.tar.gz
tar -xzvf resilio-sync_arm.tar.gz
mv rslsync /usr/bin
cd ..

ln -s /lib/arm-linux-gnueabihf/ld-linux.so.3 /lib/ld-linux.so.3
systemctl enable resilio-sync

#echo "Generating SSL certificate"
#ssh-keygen -t rsa
# Move to `/etc/ssl/certs/raspi.crt` and `/etc/ssl/private/raspi.key`, resp.

echo "Mounting data drive"
mkdir /mnt/exti
bash -c "echo '/dev/sda1 /mnt/exti ext4 defaults,noatime 0 0' >> /etc/fstab"
mount -a

echo "Starting Resilio Sync"
systemctl start resilio-sync
