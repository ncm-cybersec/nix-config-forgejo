# ==========================================================================
# System Scripts and Automated Timers
# ==========================================================================

{ 
  config,
  pkgs,
  lib,
  self,
  hostName,
  ... 
}: 

let
  # Dynamically determine active user based on hostName
  currentExecutionUser = if hostName == "nixadmin" then "nixadmin" else "nixpgadmin";

  # Define scripts as local Nix variables
  plasma-sync = pkgs.writers.writePython3Bin "plasma-sync" { 
    libraries = [ ]; 
    flakeIgnore = [ "E265" "E302" "E305" "E501" "F401" "W291" "W292" "W293" ]; 
  } (builtins.readFile "${self}/scripts/plasma-sync.py");

  git-stage-commit = pkgs.writeShellScriptBin "git-stage-commit" (builtins.readFile "${self}/scripts/git-stage-commit.zsh");
  
  update-netcatty = pkgs.writeShellScriptBin "update-netcatty" (builtins.readFile "${self}/scripts/update-netcatty.zsh");

  update-warp = pkgs.writeShellScriptBin "update-warp" (builtins.readFile "${self}/scripts/update-warp.zsh");
in
{
  # Add scripts to systemPackages for manual usage via terminal
  environment.systemPackages = [ 
    plasma-sync
    git-stage-commit
    update-netcatty
    update-warp
  ];

  # Define systemd automated timers
  systemd.services = {
    
    # Runs update-netcatty daily at 10:00 PM
    timer-update-netcatty = {
      description = "Daily update for Netcatty Appimage";
      serviceConfig = {
        Type = "oneshot";
        User = currentExecutionUser;
        # Explicitly set $HOME 
        Environment = [ "HOME=/home/${currentExecutionUser}" ];
      };
      script = "${lib.getExe update-netcatty}";
      startAt = "*-*-* 22:00:00"; 
    };

    # Runs update-warp daily at 10:05 PM
    timer-update-warp = {
      description = "Daily update for Warp Appimage";
      serviceConfig = {
        Type = "oneshot";
        User = currentExecutionUser;
        Environment = [ "HOME=/home/${currentExecutionUser}" ];
      };
      script = "${lib.getExe update-warp}";
      startAt = "*-*-* 22:05:00"; 
    };

    # Runs plasma-sync daily at 10:15 PM
    timer-plasma-sync = {
      description = "Daily capture of Plasma settings changes";
      serviceConfig = {
        Type = "oneshot";
        User = currentExecutionUser;
        Environment = [ "HOME=/home/${currentExecutionUser}" ];
      };
      script = "${lib.getExe plasma-sync}";
      startAt = "*-*-* 22:15:00"; 
    };

  };

}