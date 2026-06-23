# ==========================================================================
# NixOS Laptop Configuration:
# - HP Pavilion Gaming Laptop
#   - AMD Ryzen 5 4600H w/ Radeon iGPU
#   - NVIDIA GeForce GTX 1650 4GB
#   - 32GB DDR4 RAM
# ==========================================================================


{ 
  pkgs,
  ... 
}: 

{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./hardware-configuration.nix
    ../../modules/system
  ];

  # Define system hostname
  networking.hostName = "nixpgadmin";

  # Define a user account.
  users.users.nixpgadmin = {
    isNormalUser = true;
    description = "nixpgadmin";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
      "adbusers"
      "libvirtd"
      "kvm"
      "video"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Enable experimental features
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "nixpgadmin"
      "@wheel"
    ];
  };

  # Allow root to access the flake git repo (my nix-config folder lives in home directory, and is symlinked into /etc/nixos, so this is required for auto-upgrade)
  systemd.services.nixos-upgrade = {
    preStart = ''
      git config --global --add safe.directory /home/nixpgadmin/nix-config
    '';
  };

  # Automatically install system updates daily at 11pm
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "23:00";
    flake = "git+file:///home/nixpgadmin/nix-config";
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
