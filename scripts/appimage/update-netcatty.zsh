#!/usr/bin/env zsh

# ==========================================================================
# Netcatty AppImage Update 
# By N1x_Cybersec
#
# - ZSH script to automate updating Netcatty AppImage via the github API.
# - Netcatty is not yet available for nixos via nixpkgs.
# - Script is defined system-wide in /modules/system/packages/scripts using 
#   pkgs.writeShellScriptBin.
#
# ==========================================================================

# Exit immediately if a command exits with a non-zero status
set -e

echo "Fetching latest Netcatty release URL..."
URL=$(curl -s https://api.github.com/repos/binaricat/Netcatty/releases/latest | grep "browser_download_url.*x86_64\.AppImage" | cut -d '"' -f 4)

if [ -z "$URL" ]; then
    echo "Error: Could not find the latest AppImage download URL."
    exit 1
fi

TMP_FILE="/tmp/Netcatty.AppImage"

echo "Downloading $URL..."
curl -L -sS "$URL" -o "$TMP_FILE"

echo "Making AppImage executable..."
chmod +x "$TMP_FILE"

TARGET_APPIMAGE="$HOME/AppImages/netcatty.appimage"

if [ -f "$TARGET_APPIMAGE" ]; then
    echo "Overwriting existing Netcatty AppImage..."
    mv -f "$TMP_FILE" "$TARGET_APPIMAGE"
else
    echo "Netcatty AppImage not found at $TARGET_APPIMAGE."
    echo "Moving to $TARGET_APPIMAGE."
    mkdir -p "$HOME/AppImages"
    mv -f "$TMP_FILE" "$TARGET_APPIMAGE"
fi

echo "Cleaning up temporary files..."
rm -f "$TMP_FILE"

echo "Updating desktop file version if present..."
VERSION=$(echo "$URL" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n1 | sed 's/v//')
DESKTOP_FILE="$HOME/.local/share/applications/netcatty.desktop"
if [ -f "$DESKTOP_FILE" ] && [ -n "$VERSION" ]; then
    sed -i "s/^X-AppImage-Version=.*/X-AppImage-Version=$VERSION/" "$DESKTOP_FILE"
fi

echo "Netcatty update completed successfully!"
