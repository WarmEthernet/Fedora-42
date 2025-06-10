#!/usr/bin/env bash
## Fedora 42 Post Install Script ##
# Author: WarmEthernet

# Prompt for sudo
if ! sudo -v; then
  echo "This script requires sudo privileges."
  exit 1
fi

# Keep sudo for script
(while true; do sudo -n true; sleep 60; done) 2>/dev/null &
SUDO_PID=$!

# Cleanup sudo on exit
trap 'kill $SUDO_PID' EXIT

# Install packages
echo "Installing Packages......."

sudo dnf install -y vim pip3 gnome-tweaks kitty brave-browser fastfetch bat pywal16 gnome-extensions-cli gnome-shell-extensions-app

# Install Flatpaks
#echo "Installing Flatpaks......."
#flatpak install
