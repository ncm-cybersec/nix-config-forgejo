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

  # Allow root to access the flake git repo (required for auto-upgrade)
  systemd.services.nixos-upgrade = {
    preStart = ''
      git config --global --add safe.directory /home/nixadmin/nix-config
    '';
  };

  # Automatically install system updates daily
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "23:00";
    flake = "git+file:///home/nixadmin/nix-config";
  };

  # Run garbage collection every Sunday at 3pm
  nix.gc = {
    automatic = true;
    dates = "Sun *-*-* 15:00:00";
    options = "--delete-older-than 15d";
  };

  # Optimise the Nix store (reduce disk usage) every Saturday at 4pm
  nix.optimise-store = {
    automatic = true;
    dates = "Sat *-*-* 16:00:00";
    options = "--max-keep 15d";
  };

  system.stateVersion = "25.11";

}
