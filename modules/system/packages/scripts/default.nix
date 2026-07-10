# ==========================================================================
# System Scripts and Automated Timers
# ==========================================================================

{ 
  config,
  pkgs,
  lib,
  self,
  ... 
}: 

let
  
  # Define scripts as local Nix variables
  plasma-sync = pkgs.writers.writePython3Bin "plasma-sync" { 
    libraries = [ ]; 
    flakeIgnore = [ "E265" "E302" "E305" "E501" "F401" "W291" "W292" "W293" ]; 
  } (builtins.readFile "${self}/scripts/plasma-sync.py");

  git-stage-commit = pkgs.writeShellScriptBin "git-stage-commit" (builtins.readFile "${self}/scripts/git-stage-commit.zsh");
  
  nixos-upgrade-failed = pkgs.writeShellScriptBin "nixos-upgrade-failed" (builtins.readFile "${self}/scripts/nixos-upgrade-failed.zsh");
  
  update-netcatty = pkgs.writeShellScriptBin "update-netcatty" (builtins.readFile "${self}/scripts/update-netcatty.zsh");

  update-warp = pkgs.writeShellScriptBin "update-warp" (builtins.readFile "${self}/scripts/update-warp.zsh");

in

{
  
  # Add scripts to systemPackages for manual usage via terminal
  environment.systemPackages = [ 
    plasma-sync
    git-stage-commit
    nixos-upgrade-failed
    update-netcatty
    update-warp
  ];
  
  # Systemd service to notify user of failed NixOS upgrade
  systemd.services."nixos-upgrade-failed@" = {
    description = "Notify user of failed NixOS upgrade on %i";
    script = "${nixos-upgrade-failed}/bin/nixos-upgrade-failed %i";
    path = with pkgs; [ systemd gnused sudo libnotify ];
  };

}