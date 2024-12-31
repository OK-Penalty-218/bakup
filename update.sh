#!/bin/bash

# Define target folders
TARGET_DIR="/usr/local/bin"
CONFIG_DIR="/etc/bakup"

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit 1
fi

# Removing old backup scripts
echo "Removing backup scripts from $TARGET_DIR..."
rm -f "$TARGET_DIR/backup" "$TARGET_DIR/backup-autoremove" "$TARGET_DIR/backup-purge" \
      "$TARGET_DIR/backup-daily" "$TARGET_DIR/backup-weekly" "$TARGET_DIR/backup-hourly"

# Updating backup scripts to /usr/local/bin
echo "Installing backup scripts to $TARGET_DIR..."
cp scripts/* "$TARGET_DIR"
chmod +x "$TARGET_DIR"/*

# Move all other files to /etc/bakup
echo "Installing configuration files to $CONFIG_DIR..."
cp config/config.json "$CONFIG_DIR"
echo "Update complete."
