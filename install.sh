#!/bin/bash

# Define the target folder
TARGET_DIR="/usr/local/bin"

# Ensure the user has sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit 1
fi

# Copy scripts to the target folder
echo "Copying scripts to $TARGET_DIR..."
mkdir -p "$TARGET_DIR"
cp scripts/* "$TARGET_DIR"
chmod +x "$TARGET_DIR"/*

# Add crontab jobs
echo "Setting up automated crontab backup jobs..."
(crontab -l 2>/dev/null; echo "0 4 * * 7  $TARGET_DIR/bakup-weekly") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * * $TARGET_DIR/bakup-daily") | crontab -
(crontab -l 2>/dev/null; echo "0 * * * * $TARGET_DIR/bakup-hourly") | crontab -

echo "Installation complete."
