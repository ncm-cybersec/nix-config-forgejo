#!/usr/bin/env zsh

# ==========================================================================
# Git Stage & Commit ZSH Script
# By N1x_Cybersec
#
# - ZSH script to automate updating Warp AppImage via gearlever cli
# - Warp receives frequent updates, with nixpkgs unstable lagging behind on new releases.
# - This script is useful for keeping it up to date via the AppImage directly from the Warp API.
#
# ==========================================================================


# Exit immediately if a command exits with a non-zero status
set -e

URL="https://app.warp.dev/download?package=appimage"
TMP_FILE="/tmp/Warp.AppImage"

echo "Downloading the latest Warp AppImage..."
curl -L -sS "$URL" -o "$TMP_FILE"

echo "Making AppImage executable..."
chmod +x "$TMP_FILE"

TARGET_APPIMAGE="$HOME/AppImages/warp.appimage"

if [ -f "$TARGET_APPIMAGE" ]; then
    echo "Overwriting existing Warp AppImage..."
    mv -f "$TMP_FILE" "$TARGET_APPIMAGE"
else
    echo "Error: Warp AppImage not found at $TARGET_APPIMAGE"
    echo "Please ensure Warp is integrated using Gear Lever first."
    exit 1
fi
echo "Cleaning up temporary files..."
rm -f "$TMP_FILE"

echo "Warp update completed successfully!"
