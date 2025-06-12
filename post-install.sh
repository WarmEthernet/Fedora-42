#!/usr/bin/env bash
## Fedora 42 Post Install Script ##
# Author: WarmEthernet

set -e

# Ensure script is not run as root
if [ "$EUID" -eq 0 ]; then
  echo "Please run this script as a normal user, not root."
  exit 1
fi

# Inform the user and prompt for sudo
echo "This script needs sudo access. You may be prompted for your password."
if ! sudo -v; then
  echo "Failed to get sudo privileges."
  exit 1
fi

# Keep sudo alive in background
# Use shorter sleep interval to avoid terminal hang on quick scripts
KEEP_SUDO_ALIVE() {
  while true; do
    sudo -n true
    sleep 10
  done
}

KEEP_SUDO_ALIVE &
SUDO_KEEPALIVE_PID=$!

# Ensure cleanup on exit
cleanup() {
  kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
  wait "$SUDO_KEEPALIVE_PID" 2>/dev/null
}
trap cleanup EXIT

# ---- Your logic starts here ----
echo "Installing Base Packages......."

sudo dnf install -y vim pip3 gnome-tweaks kitty fastfetch bat dnf-plugins-core  # Replace with actual package names

echo "Installing Repositories for Extra Packages......."

# Brave Browser
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

echo "Installing Apps from Extra Repos and other sources......."

sudo dnf install -y brave-browser

pip3 install pywal16

pip3 install --upgrade gnome-extensions-cli

flatpak install -y com.mattjakeman.ExtensionManager


echo "Installing Extensions........"

gext install accent-directories@taiwbi.com
gext install custom-command-toggle@storageb.github.com
gext install dash-to-dock@micxgx.gmail.com
gext install desktop-cube@schneegans.github.com
gext install openbar@neuromorph

