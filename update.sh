#!/bin/bash

DOWLOAD_URL="https://discord.com/api/download?platform=linux&format=deb"
DOWNLOAD_PATH="/tmp/discord.deb"

# Superuser ??
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

set -e

bash stop.sh
wait

echo "Downloading lastest Discord version..."
wget -O "$DOWNLOAD_PATH" "$DOWLOAD_URL"
wait

echo "Installing Discord..."
dpkg -i "$DOWNLOAD_PATH" 
wait

echo "Fixing dependencies..."
apt-get install -f
wait

echo "Cleaning up..."
rm -f "$DOWNLOAD_PATH"
wait

bash start.sh
