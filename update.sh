#!/bin/bash

# Define target folders
TARGET_DIR="/usr/local/bin"
CONFIG_DIR="/etc/bakup"

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit 1
fi

# Remove old backup scripts
echo "Removing backup scripts from $TARGET_DIR..."
rm -f "$TARGET_DIR/backup" "$TARGET_DIR/backup-autoremove" "$TARGET_DIR/backup-purge" \
      "$TARGET_DIR/backup-daily" "$TARGET_DIR/backup-weekly" "$TARGET_DIR/backup-hourly"
      
# Remove old configuration file
echo "Removing configuration file: $CONFIG_DIR/config.json"
echo "Remember to update your backup directory after update is complete."
rm -f "$CONFIG_DIR/config.json"

# Update backup scripts to /usr/local/bin
echo "Updating backup scripts to $TARGET_DIR..."
cp scripts/* "$TARGET_DIR"
chmod +x "$TARGET_DIR"/*

# Update all other files to /etc/bakup
echo "Updating configuration files to $CONFIG_DIR..."
cp config/config.json "$CONFIG_DIR"

echo "Update complete."
echo "Don't forget to update your backup directory in the config file located at: $CONFIG_DIR/config.json"
