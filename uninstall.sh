#!/bin/bash

# Define the target folder and config directory
TARGET_DIR="/usr/local/bin"
CONFIG_DIR="/etc/bakup"

# Ensure the user has sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./uninstall.sh)"
  exit 1
fi

# Remove backup scripts
echo "Removing backup scripts from $TARGET_DIR..."
sudo rm -rf "$TARGET_DIR/*"

# Remove crontab jobs
echo "Removing crontab jobs..."
(crontab -l | grep -v -F "$TARGET_DIR") | crontab -

# Remove config directory
echo "Removing config directory $CONFIG_DIR..."
sudo rm -rf "$CONFIG_DIR"

# Confirm completion
echo "Uninstallation complete."
