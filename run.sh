#!/bin/bash

echo "Creating directories"
mkdir -p ./sync/.sync
mkdir -p ./sync/data

echo "Copying config"
cp config.json ./sync/config.json

# echo "Starting container"
# docker run -d --name sync \
#     -p 80:8888 \
#     -p 55555 \
#     -v /usr/share/sync/:/usr/share/sync/ \
#     --restart unless-stopped \
#     resilio/sync

echo "Installing Resilio Sync"
mkdir rslsync
pushd rslsync
wget https://download-cdn.resilio.com/stable/linux-arm/resilio-sync_arm.tar.gz
tar -xzvf resilio-sync_arm.tar.gz
sudo mv rslsync /usr/bin
popd

echo "Starting Resilio Sync"
sudo systemctl enable resilio-sync
sudo systemctl start resilio-sync
