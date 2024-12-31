#!/bin/bash

# Define the target folder and config file location
TARGET_DIR="/usr/local/bin"
CONFIG_DIR="/etc/bakup"
CONFIG_FILE="./config/.config.json"

# Ensure the user has sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit 1
fi

# Check if jq is installed; if not, install it
if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Installing jq..."
  sudo apt-get update && sudo apt-get install -y jq
fi

# Copy scripts to the target folder
echo "Copying scripts to $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

# Check if the scripts already exist in the target directory
for script in scripts/*; do
  script_name=$(basename "$script")
  if [ -e "$TARGET_DIR/$script_name" ]; then
    echo "$script_name already exists in $TARGET_DIR. Skipping copy."
  else
    cp "$script" "$TARGET_DIR"
    chmod +x "$TARGET_DIR/$script_name"
    echo "Copied $script_name to $TARGET_DIR."
  fi
done

# Create /etc/bakup if it doesn't exist
echo "Creating $CONFIG_DIR..."
sudo mkdir -p "$CONFIG_DIR"

# Copy the .config.json file to /etc/bakup
echo "Copying config file to $CONFIG_DIR..."
sudo cp "$CONFIG_FILE" "$CONFIG_DIR/.config.json"

# Add crontab jobs, ensuring no duplicates
echo "Setting up automated crontab backup jobs..."
crontab -l | grep -v -F "$TARGET_DIR/bakup-weekly" | { cat; echo "0 4 * * 7 $TARGET_DIR/bakup-weekly"; } | crontab -
crontab -l | grep -v -F "$TARGET_DIR/bakup-daily" | { cat; echo "0 3 * * * $TARGET_DIR/bakup-daily"; } | crontab -
crontab -l | grep -v -F "$TARGET_DIR/bakup-hourly" | { cat; echo "0 * * * * $TARGET_DIR/bakup-hourly"; } | crontab -

# Confirm completion
echo "Installation complete. Backup scripts are now installed, and cron jobs are set."
