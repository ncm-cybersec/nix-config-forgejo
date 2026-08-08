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
  git-stage-commit = pkgs.writeShellScriptBin "git-stage-commit" (builtins.readFile "${self}/scripts/git-stage-commit.zsh");

  nixos-upgrade-failed = pkgs.writeShellScriptBin "nixos-upgrade-failed" (builtins.readFile "${self}/scripts/nixos-upgrade-failed.zsh");
  
  plasma-sync = pkgs.writers.writePython3Bin "plasma-sync" { 
    libraries = [ ]; 
    flakeIgnore = [ "E265" "E302" "E305" "E501" "F401" "W291" "W292" "W293" ]; 
  } (builtins.readFile "${self}/scripts/plasma-sync.py");
  
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
    echo "AppImage updates completed."
  '');

in

{
  
  # Add scripts to systemPackages for manual usage via terminal
  environment.systemPackages = [ 
    git-stage-commit
    nixos-upgrade-failed
    plasma-sync
    update-appimages
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