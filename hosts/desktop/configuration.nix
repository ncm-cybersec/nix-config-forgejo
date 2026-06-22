# ==========================================================================
# NixOS System Configuration:
# - HP Omen 45L Gaming Desktop
#   - AMD Ryzen 7 5800X 
#   - NVIDIA GeForce RTX 3060 12GB
#   - 64GB DDR4 RAM
# ==========================================================================

{ 
  pkgs,
  ... 
}: 

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system
    ];

  # Define system hostname
  networking.hostName = "nixadmin";

  # Define user account
  users.users.nixadmin = {
    isNormalUser = true;
    description = "nixadmin";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "podman" 
      "adbusers" 
      "libvirtd" 
      "kvm" 
      "i2c" 
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Enable Experimental Features and declare trusted users
  nix.settings = {
    experimental-features = [ 
      "nix-command" 
      "flakes" 
    ];
    trusted-users = [ 
      "nixadmin" 
      "root" 
      "@wheel" 
    ];
  };

  # Allow root to access the flake git repo (my nix-config folder lives in home directory, and is symlinked into /etc/nixos, so this is required for auto-upgrade)
  systemd.services.nixos-upgrade = {
    preStart = ''
      git config --global --add safe.directory /home/nixadmin/nix-config
    '';
  };

  # Automatically install system updates daily at 11pm
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
  nix.optimise = {
    automatic = true;
    dates = "Sat *-*-* 16:00:00";
  };

  system.stateVersion = "25.11";

}
