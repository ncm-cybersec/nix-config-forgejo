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
      "adb"
      "git"
      "kvm"
      "libvirtd"
      "networkmanager"
      "podman"
      "video"
      "wheel"
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
      "electron-38.8.4"
      "electron-39.8.10"
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

  # SOPS configuration to retrieve secrets & access forgejo repo
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    
    secrets.forgejo_ssh_config = {
      path = "/root/.ssh/config";
    };
  };

  # Pull latest changes from forgejo before rebuild to maintain sync with remote
  systemd.services.nixos-upgrade = {
    onFailure = [ "nixos-upgrade-failed@%H.service" ];
    
    preStart = ''
      ${pkgs.git}/bin/git config --global --add safe.directory /home/nixpgadmin/nix-config
    '';
    
    serviceConfig.ExecStartPre = "${pkgs.git}/bin/git -C /home/nixpgadmin/nix-config pull --ff-only";
  };

  # Auto-upgrade flake from self-hosted forgejo repository
  system.autoUpgrade = {
    enable = true;

    # "flake" instructs NixOS to look at a git repository
    flake = "git+ssh://forgejo-upgrade/nas_forgejoadmin/nix-config.git#nixpgadmin";

    # Run intervals daily at midnight
    dates = "00:00";

    #flags = [

    #];
  };
  
  # Set memory limits to prevent rebuild failures
  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "22G";
    MemoryMax = "26G";
    Nice = "19";
  };
 
  system.stateVersion = "25.11";
}
