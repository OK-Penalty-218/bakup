#!/bin/bash

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo npm remove -g @ok-penalty-218/ubuntu-bakup)"
  exit 1
fi

# Define the target folder and configuration directory
TARGET_DIR="/usr/local/bin"
CONFIG_DIR="/etc/bakup"

# Remove backup scripts
echo "Removing backup scripts from $TARGET_DIR..."
rm -f "$TARGET_DIR/backup" "$TARGET_DIR/backup-autoremove" "$TARGET_DIR/backup-purge" \
      "$TARGET_DIR/backup-daily" "$TARGET_DIR/backup-weekly" "$TARGET_DIR/backup-hourly"

# Remove configuration directory
if [ -d "$CONFIG_DIR" ]; then
  echo "Removing configuration directory: $CONFIG_DIR"
  rm -rf "$CONFIG_DIR"
else
  echo "Configuration directory not found: $CONFIG_DIR"
fi

# Removing local files
rm -R /usr/local/lib/node_modules/@ok-penalty-218/ubuntu-bakup

# Remove crontab entries related to backup
echo "Removing crontab jobs for backup..."
crontab -l 2>/dev/null | grep -v "$TARGET_DIR/backup-" | crontab -

echo "Uninstallation complete."
echo "Your backup files have not been affected; ensure crontab jobs have been removed by running 'sudo crontab -l'."
