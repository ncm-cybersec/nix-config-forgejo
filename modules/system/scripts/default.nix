# ==========================================================================
# System Scripts and Automated Timers
# ==========================================================================

{ 
  pkgs,
  self,
  ... 
}: 

let
  
  # Define scripts as local Nix variables
  git-stage-commit = pkgs.writeShellScriptBin "git-stage-commit" (builtins.readFile "${self}/scripts/git/git-stage-commit.zsh");

  nix-rebuild = pkgs.writers.writePython3Bin "nix-rebuild" { 
    libraries = [ ]; 
    flakeIgnore = [ "E265" "E302" "E305" "E501" "F841" "W291" "W292" "W293" ]; 
  } (builtins.readFile "${self}/scripts/nixos/nix-rebuild.py");
  
  nixos-upgrade-failed = pkgs.writeShellScriptBin "nixos-upgrade-failed" (builtins.readFile "${self}/scripts/nixos/nixos-upgrade-failed.zsh");
  
  plasma-sync = pkgs.writers.writePython3Bin "plasma-sync" { 
    libraries = [ ]; 
    flakeIgnore = [ "E265" "E302" "E305" "E501" "F401" "W291" "W292" "W293" ]; 
  } (builtins.readFile "${self}/scripts/kde/plasma-sync.py");
  
  update-appimages = (pkgs.writeShellScriptBin "update-appimages" ''
    echo "Starting automated daily AppImage updates..."
    update-copilot
    update-letta
    update-massCode
    update-msty_nexus
    update-mstystudio
    update-netcatty
    update-openwarp
    update-warp
    update-mstygo
    echo "AppImage updates completed."
  '');
  
  update-mstygo = (pkgs.writeShellScriptBin "update-mstygo" ''
    set -e
    PATH="${pkgs.coreutils}/bin:${pkgs.curl}/bin:${pkgs.gnugrep}/bin:${pkgs.gnused}/bin"
    
    TARGET_APPIMAGE="$HOME/Applications/MstyGo"
    TMP_FILE="/tmp/MstyGo.AppImage"
    DESKTOP_PATH="$HOME/.local/share/applications/mstygo.desktop"
    
    echo "=== Starting update for Msty Go ==="
    
    URL="https://go-assets.msty.ai/app/latest/linux/MstyGo_x86_64.AppImage"
    VERSION=$(date +%Y.%m.%d)
    
    echo "Downloading Msty Go..."
    curl -L -sS "$URL" -o "$TMP_FILE"
    chmod +x "$TMP_FILE"

    echo "Overwriting application binary..."
    mkdir -p "$(dirname "$TARGET_APPIMAGE")"
    mv -f "$TMP_FILE" "$TARGET_APPIMAGE"

    if [ -f "$DESKTOP_PATH" ]; then
        sed -i "s/^X-AppImage-Version=.*/X-AppImage-Version=$VERSION/" "$DESKTOP_PATH"
    fi

    echo "=== Msty Go update completed successfully! ==="
  '');

in

{
  
  # Add scripts to systemPackages for manual usage via terminal
  environment.systemPackages = [ 
    git-stage-commit
    nix-rebuild
    nixos-upgrade-failed
    plasma-sync
    update-appimages
    update-mstygo
  ];
  
  # Systemd service to notify user of failed NixOS upgrade
  systemd.services."nixos-upgrade-failed@" = {
    description = "Notify user of failed NixOS upgrade on %i";
    script = "${nixos-upgrade-failed}/bin/nixos-upgrade-failed %i";
    path = with pkgs; [ systemd gnused sudo libnotify ];
  };
  
  systemd.user.services."update-appimages" = {
    description = "Automated background update script for AppImages";
    path = [ pkgs.coreutils pkgs.curl pkgs.gnugrep pkgs.gnused pkgs.gawk pkgs.jq ];
    
    script = ''
      ${update-appimages}/bin/update-appimages
    '';
    
    serviceConfig = {
      Type = "oneshot";
      Nice = 19;
      CPUSchedulingPolicy = "idle";
    };
  };
  
  systemd.user.timers."update-appimages" = {
    description = "Timer for daily AppImage updates";
    wantedBy = [ "timers.target" ];
    
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00";
      Persistent = true;
      RandomizedDelaySec = "15m";
    };
  };
}