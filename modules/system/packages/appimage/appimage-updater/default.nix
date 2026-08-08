# ==========================================================================
# Appimage Module - Function to build Appimage Updater Scripts
# ==========================================================================

{
  pkgs,
  ...
}:

let
  
  # Reusable function to build AppManager Auto-Updater Scripts
  mkAppImageUpdater = { pkgs, name, jsonName, desktopFile, fetchLogic }:
    pkgs.writeShellScriptBin "update-${name}" ''
      set -e
      PATH="${pkgs.coreutils}/bin:${pkgs.curl}/bin:${pkgs.gnugrep}/bin:${pkgs.gnused}/bin:${pkgs.gawk}/bin:${pkgs.jq}/bin"

      JSON_FILE="$HOME/.local/share/app-manager/installations.json"
      TMP_FILE="/tmp/${name}.AppImage"
      TARGET_APPIMAGE="$HOME/Applications/${jsonName}"

      echo "=== Starting update for ${name} ==="
      
      # Export $URL and $VERSION variables
      ${fetchLogic}

      if [ -z "$URL" ] || [ -z "$VERSION" ]; then
          echo "Error: Failed to resolve download URL or Version for ${name}."
          exit 1
      fi

      echo "Downloading: $URL (Version: $VERSION)..."
      curl -L -sS "$URL" -o "$TMP_FILE"
      chmod +x "$TMP_FILE"

      echo "Overwriting existing application binary..."
      mkdir -p "$(dirname "$TARGET_APPIMAGE")"
      mv -f "$TMP_FILE" "$TARGET_APPIMAGE"

      # Update Desktop Shortcuts
      DESKTOP_PATH="$HOME/.local/share/applications/${desktopFile}"
      if [ -f "$DESKTOP_PATH" ]; then
          sed -i "s/^X-AppImage-Version=.*/X-AppImage-Version=$VERSION/" "$DESKTOP_PATH"
      fi

      # Update AppManager metadata
      if [ -f "$JSON_FILE" ]; then
          echo "Syncing data with AppManager installations.json..."
          CONTENT_LENGTH=$(stat -c%s "$TARGET_APPIMAGE")
          CHECKSUM=$(sha256sum "$TARGET_APPIMAGE" | awk '{print $1}')
          UPDATED_AT=$(date +%s000000)

          UPDATED_JSON=$(jq \
            --arg name "${jsonName}" \
            --arg ver "$VERSION" \
            --arg hash "$CHECKSUM" \
            --argjson size "$CONTENT_LENGTH" \
            --argjson ts "$UPDATED_AT" \
            '(.installations[] | select(.name == $name)) |= (
               .version = $ver | 
               .source_checksum = $hash | 
               .content_length = $size | 
               .updated_at = $ts
             )' "$JSON_FILE")
          
          echo "$UPDATED_JSON" > "$JSON_FILE"
      else
          echo "Warning: AppManager JSON configuration missing at $JSON_FILE"
      fi

      echo "=== ${name} update completed successfully! ==="
    '';
    
in

{
  
  environment.systemPackages = [
  
  # GitHub Copilot App (Shortlink Redirect)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "copilot";
    jsonName = "GitHubCopilot";
    desktopFile = "Github-Copilot.desktop";
    fetchLogic = ''
      URL=$(curl -sIL -o /dev/null -w "%{url_effective}" "https://gh.io/copilot-app-linux")
      VERSION=$(echo "$URL" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "latest")
    '';
  })
  
  # Letta (Direct Download Path)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "letta";
    jsonName = "Letta";
    desktopFile = "letta-code.desktop";
    fetchLogic = ''
      URL="https://download.letta.com/linux/appImage/x64"
      VERSION=$(date +%Y.%m.%d)
    '';
  })
  
  # massCode (GitHub Release API)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "massCode";
    jsonName = "massCode";
    desktopFile = "masscode.desktop";
    fetchLogic = ''
      RELEASE_DATA=$(curl -s https://api.github.com/repos/massCodeIO/massCode/releases/latest)
      URL=$(echo "$RELEASE_DATA" | grep -i "browser_download_url.*\.AppImage" | cut -d '"' -f 4 | head -n1)
      VERSION=$(echo "$URL" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n1)
    '';
  })

  # Msty Nexus (Direct Download Path)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "msty_nexus";
    jsonName = "Msty Nexus";
    desktopFile = "org.wails.mstynexus.desktop";
    fetchLogic = ''
      URL="https://nexus-assets.msty.ai/app/latest/linux/Msty-Nexus_x86_64.AppImage"
      VERSION=$(date +%Y.%m.%d)
    '';
  })

  # Msty Studio (Direct Download Path)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "mstystudio";
    jsonName = "MstyStudio";
    desktopFile = "mstystudio.desktop";
    fetchLogic = ''
      URL="https://next-assets.msty.studio/app/latest/linux/MstyStudio_x86_64.AppImage"
      VERSION=$(date +%Y.%m.%d) 
    '';
  })

  # Netcatty (GitHub Release API)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "netcatty";
    jsonName = "Netcatty";
    desktopFile = "netcatty.desktop";
    fetchLogic = ''
      RELEASE_DATA=$(curl -s https://api.github.com/repos/binaricat/Netcatty/releases/latest)
      URL=$(echo "$RELEASE_DATA" | grep "browser_download_url.*x86_64\.AppImage" | cut -d '"' -f 4)
      VERSION=$(echo "$URL" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n1 | sed 's/v//')
    '';
  })

  # Zap (GitHub Release API)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "openwarp";
    jsonName = "Zap";
    desktopFile = "dev.zap.Zap.desktop";
    fetchLogic = ''
      RELEASE_DATA=$(curl -s https://api.github.com/repos/zerx-lab/zap/releases/latest)
      URL=$(echo "$RELEASE_DATA" | grep "browser_download_url.*x86_64\.AppImage" | cut -d '"' -f 4)
      VERSION=$(echo "$URL" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n1 | sed 's/v//')
    '';
  })
  
  # Warp (Direct Download Path)
  (mkAppImageUpdater {
    inherit pkgs;
    name = "warp";
    jsonName = "Warp";
    desktopFile = "dev.warp.Warp.desktop";
    fetchLogic = ''
      URL=$(curl -sIL -o /dev/null -w "%{url_effective}" "https://app.warp.dev/download?package=appimage")
      VERSION=$(date +%Y.%m.%d)
    '';
  })
];

}
