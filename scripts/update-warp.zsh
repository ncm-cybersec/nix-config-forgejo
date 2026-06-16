#!/usr/bin/env zsh

# Exit immediately if a command exits with a non-zero status
set -e

URL="https://app.warp.dev/get_warp?package=appimage"
TMP_FILE="/tmp/Warp.AppImage"

echo "Downloading the latest Warp AppImage..."
curl -L -sS "$URL" -o "$TMP_FILE"

echo "Making AppImage executable..."
chmod +x "$TMP_FILE"

echo "Updating Warp via Gear Lever CLI..."
# Check for native CLI alias or Flatpak runner depending on how Gear Lever was installed
if command -v gearlever &> /dev/null; then
    gearlever --update "$TMP_FILE"
elif command -v flatpak &> /dev/null && flatpak list | grep -q "it.mijorus.gearlever"; then
    flatpak run it.mijorus.gearlever --update "$TMP_FILE"
else
    echo "Error: Gear Lever CLI could not be found."
    exit 1
fi

echo "Cleaning up temporary files..."
rm -f "$TMP_FILE"

echo "Warp update completed successfully!"
