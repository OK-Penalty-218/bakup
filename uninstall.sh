#!/bin/bash

TARGET_DIR="/usr/local/bin"

# Ensure the user has sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./uninstall.sh)"
  exit 1
fi

# Remove scripts
echo "Removing scripts from $TARGET_DIR..."
rm -f "$TARGET_DIR/bakup" "$TARGET_DIR/bakup-autoremove" "$TARGET_DIR/bakup-purge"
rm -f "$TARGET_DIR/bakup-hourly" "$TARGET_DIR/bakup-daily" "$TARGET_DIR/bakup-weekly"
rm -f "$TARGET_DIR/su-bakup-hourly" "$TARGET_DIR/su-bakup-daily" "$TARGET_DIR/su-bakup-weekly"

# Remove crontab jobs
echo "Removing crontab jobs..."
crontab -l | grep -v "$TARGET_DIR/bakup-weekly" | crontab -
crontab -l | grep -v "$TARGET_DIR/bakup-daily" | crontab -
crontab -l | grep -v "$TARGET_DIR/bakup-hourly" | crontab -

echo "Uninstallation complete."
