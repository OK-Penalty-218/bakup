#!/bin/bash

# Define target folders
BIN_DIR="/usr/local/bin"
CONFIG_DIR="/etc/bakup"

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit 1
fi

# Create necessary directories
echo "Creating directories..."
mkdir -p "$CONFIG_DIR"

# Move backup scripts to /usr/local/bin
echo "Installing backup scripts to $BIN_DIR..."
cp scripts/* "$BIN_DIR"
chmod +x "$BIN_DIR"/*

# Move all other files to /etc/bakup
echo "Installing configuration files to $CONFIG_DIR..."
cp config/config.json "$CONFIG_DIR"

# Add crontab jobs
echo "Setting up automated crontab backup jobs..."
(crontab -l 2>/dev/null; echo "0 4 * * 7  $BIN_DIR/bakup-weekly") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * * $BIN_DIR/bakup-daily") | crontab -
(crontab -l 2>/dev/null; echo "0 * * * * $BIN_DIR/bakup-hourly") | crontab -

echo "Installation complete."
