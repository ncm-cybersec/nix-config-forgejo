# ==========================================================================
# NixOS DesktopSystem Configuration:
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
  imports = [
    ./boot.nix
    ./desktop.nix
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
      "git"
      "podman"
      "adb"
      "librechat"
      "meilisearch"
      "libvirtd"
      "kvm"
      "i2c"
    ];
    
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  
  # Enable unfree packages, CUDA support, and configure NVIDIA drivers
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
      "pnpm-10.29.2"
    ];
  };

  # Nix Settings
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      
      trusted-users = [
        "nixadmin"
        "root"
        "@wheel"
      ];
      
      # Build optimization settings
      max-jobs = "auto";
      cores = 0;
      commit-lockfile-summary = "Update flake inputs/flake.lock";
      warn-dirty = false;
    };
    
    # Garbage collection every Sunday at 3pm
    gc = {
      automatic = true;
      dates = "Sun *-*-* 15:00:00";
      options = "--delete-older-than 15d";
    };
    
    # Optimise the Nix store every Saturday at 4pm
    optimise = {
      automatic = true;
      dates = "Sat *-*-* 16:00:00";
    };
  };
  
  # Resolve "too many open files" error
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "524288";
    }
    
    { 
      domain = "*";
      type = "hard";
      item = "nofile"; 
      value = "1048576";
    }
  ];

  # Allow root to access the flake git repo
  systemd.services.nixos-upgrade = {
    onFailure = [ "nixos-upgrade-failed@%H.service" ];
    
    preStart = ''
      ${pkgs.git}/bin/git config --global --add safe.directory /home/nixadmin/nix-config
    '';
  };

  # Automatically install system updates daily at 11pm
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "23:00";
    flake = "git+file:///home/nixadmin/nix-config";
  };
  
  # Set memory limits to prevent rebuild failures
  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "38G";
    MemoryMax = "42G";
    Nice = "19";
  };

  system.stateVersion = "25.11";
}
