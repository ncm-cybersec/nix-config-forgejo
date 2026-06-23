# ==========================================================================
# NixOS Laptop Configuration:
# - HP Pavilion Gaming Laptop
#   - AMD Ryzen 5 4600H w/ Radeon iGPU
#   - NVIDIA GeForce GTX 1650 4GB
#   - 32GB DDR4 RAM
# ==========================================================================


{ 
  config,
  lib,
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

  # SOPS configuration for access to secrets.yaml for forgejo repository access
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt"; 

  sops.secrets.forgejo_ssh_config = {
    # Writes the secret directly to the root user's SSH config folder at boot.
    path = "/root/.ssh/config";
  };

  # Pull latest changes from forgejo before rebuilding to ensure that the additional host pulls changes from the central repo so that it's local configuration stays in sync
  systemd.services.nixos-upgrade.serviceConfig.ExecStartPre = "${pkgs.git}/bin/git -C /etc/nixos pull";

  # Auto-upgrade flake from self-hosted forgejo repository
  system.autoUpgrade = {
    enable = true;
    
    # "flake" instructs NixOS to look at a git repository rather than traditional channels
    flake = "git+ssh://git@{ config.sops.secrets.forgejo_ssh_config.path; }/nas_forgejoadmin/nixos-config.git#nixlaptop";
    
    # Run intervals every day at midnight
    dates = "00:00"; 
    
    # Options passed during the rebuild phase; auto-update nixpkgs dependencies.
    flags = [
      "--update-input" "nixpkgs"
    ];
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
