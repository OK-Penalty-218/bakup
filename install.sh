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
echo "Setting up crontab jobs..."
(crontab -l 2>/dev/null; echo "0 * * * * $TARGET_DIR/script1.sh") | crontab -
(crontab -l 2>/dev/null; echo "30 2 * * * $TARGET_DIR/script2.sh") | crontab -

echo "Installation complete."
