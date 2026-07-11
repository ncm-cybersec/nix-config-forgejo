# ======================================================================================
# N1x_Cybersec - NixOS Workstation & Home Lab Control Center
# ======================================================================================

{
  description = "NixOS Multi-Host Architecture & Nix Native CI/CD (Nixsync)";

  # Binary caches
  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
      "https://catppuccin.cachix.org"
      "https://cache.numtide.com"
      "https://cuda-maintainers.cachix.org"
      "https://vicinae.cachix.org"
    ];
    
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
  
  inputs = {
    # Default Channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # Nixpkgs unstable is safely mixed with stable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Antigravity 2.0
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Global Theme
    catppuccin.url = "github:catppuccin/nix/release-26.05";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # System Theme Effects
    kwin-effects-glass = {
      url = "github:4v3ngR/kwin-effects-glass";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Numtide's LLM Agents - common LLM agents and tools for NixOS
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
    # Local LLM Inference via llama.cpp, vLLM, or sglang
    llmhop = {
      url = "github:mirkolenz/llmhop";
    };
    # Declarative Flatpak management for applications unavailable in nixpkgs
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # KDE Plasma Configuration Manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # Window tiling manager inspired by PowerToys FancyZones
    plasmazones.url = "github:fuddlesworth/PlasmaZones/v3.0.15";
    # Secrets management for NixOS
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Local Desktop Search Runner
    vicinae.url = "github:vicinaehq/vicinae";
  };

  # Flake outputs passed to config.nix & home.nix via specialArgs and extraSpecialArgs
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    antigravity-nix,
    catppuccin,
    home-manager,
    kwin-effects-glass,
    llm-agents,
    llmhop,
    nix-flatpak,
    plasma-manager,
    plasmazones,
    sops-nix,
    vicinae,
    ...
  } @ inputs: 
  
  let
    
    system = "x86_64-linux";
    # Define nixpkgs-unstable as pkgsUnstable
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config = {
        # Allow proprietary packages
        allowUnfree = true;
        # Allow specific insecure packages
        permittedInsecurePackages = [
          "electron-38.8.4"
          "electron-39.8.10"
        ];       
      };
    };
    
  in {
    
    # ==========================================================================
    # NixOS Desktop - Hostname: nixadmin
    # ==========================================================================

    nixosConfigurations.nixadmin = nixpkgs.lib.nixosSystem {
      inherit system;
      # Special arguments passed to configuration.nix & nixosModules
      specialArgs = {
        inherit self inputs pkgsUnstable;
        hostName = "nixadmin";
      };
      # Configuration modules
      modules = [
        # Core Configuration
        ./hosts/desktop/configuration.nix
        # Home Manager configuration for user
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit inputs pkgsUnstable;
            # Hostname matches username for multiple hosts sharing home-manager configuration
            hostName = "nixadmin";
            username = "nixadmin";
          };
          home-manager.users.nixadmin = {
            imports = [
              ./home.nix
              catppuccin.homeModules.catppuccin
              plasma-manager.homeModules.plasma-manager
            ];
          };
        }
        llmhop.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        plasmazones.nixosModules.default
        sops-nix.nixosModules.sops
        vicinae.nixosModules.default
      ];
    };

    # ==========================================================================
    # Nixos Laptop - Hostname: nixpgadmin
    # ==========================================================================

    nixosConfigurations.nixpgadmin = nixpkgs.lib.nixosSystem {
      inherit system;
      # Special arguments passed to configuration.nix & nixosModules
      specialArgs = {
        inherit self inputs pkgsUnstable;
        hostName = "nixpgadmin";
      };
      # Configuration modules
      modules = [
        # Core Configuration
        ./hosts/laptop/configuration.nix
        # Home Manager configuration for user
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit inputs pkgsUnstable;
            # Hostname matches username for multiple hosts sharing home-manager configuration for uniformity across systems
            hostName = "nixpgadmin";
            username = "nixpgadmin";
          };
          home-manager.users.nixpgadmin = {
            imports = [
              ./home.nix
              catppuccin.homeModules.catppuccin
              plasma-manager.homeModules.plasma-manager
            ];
          };
        }
        llmhop.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        plasmazones.nixosModules.default
        sops-nix.nixosModules.sops
        vicinae.nixosModules.default
      ];
    };
  };
}
