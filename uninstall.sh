#!/bin/bash

TARGET_DIR="/usr/local/bin"

# Ensure the user has sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./uninstall.sh)"
  exit 1
fi

# Remove scripts
echo "Removing scripts from $TARGET_DIR..."
rm -f "$TARGET_DIR/script1.sh" "$TARGET_DIR/script2.sh"

# Remove crontab jobs
echo "Removing crontab jobs..."
crontab -l | grep -v "$TARGET_DIR/script1.sh" | crontab -
crontab -l | grep -v "$TARGET_DIR/script2.sh" | crontab -

echo "Uninstallation complete."
