# ---------------------------------------------------
# NixOS System Configuration
# ---------------------------------------------------

{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/system
    ];

  # Define system hostname
  networking.hostName = "nixadmin";

  # Define user account
  users.users.nixadmin = {
    isNormalUser = true;
    description = "nixadmin";
    extraGroups = [ "networkmanager" "wheel" "podman" "adbusers" "libvirtd" "kvm" "i2c" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Enable Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Increase maximum number of open files for user sessions to resolve 
  # "too many open files" error. Equivalent to running 
  # "ulimit -n 4096" command after flake update > nix rebuild.
  security.pam.loginLimits = [
    { domain = "*"; type = "soft"; item = "nofile"; value = "1048576"; }
    { domain = "*"; type = "hard"; item = "nofile"; value = "16777216"; }
  ];

  # Allow root to access the flake repo (required for auto-upgrade)
  programs.git.config.safe.directory = "/home/nixadmin/nix-config";

  # Automatically install system updates daily
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "23:00";
  };

  # Run garbage collection every Sunday at 3pm
  nix.gc = {
    automatic = true;
    dates = "Sun *-*-* 15:00:00";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "25.11";

}
