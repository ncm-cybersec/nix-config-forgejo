{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./conf_imports/boot/boot.nix
      ./conf_imports/graphics/graphics.nix
      ./conf_imports/hardware/hardware.nix
      ./conf_imports/networking/networking.nix
      ./conf_imports/packages/packages.nix
      ./conf_imports/services/services.nix
    ];


  networking.hostName = "nixadmin"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixadmin = {
    isNormalUser = true;
    description = "nixadmin";
    extraGroups = [ "networkmanager" "wheel" "podman" "adbusers" "libvirtd" "kvm" "i2c" ];
    shell = pkgs.bash;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  environment.shells =  with pkgs; [ bashInteractive ];

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
