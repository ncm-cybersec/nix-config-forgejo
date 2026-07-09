# ======================================================================================
# NixOS Multi-Host Architecture and CI/CD Using Only Native Nix Options
# ======================================================================================

{
  description = "NixOS Multi-Host Architecture with CI/CD";

  inputs = {
    # Nixpkgs Stable - Default Channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # Nixpkgs Unstable. System is on stable channel, but unstable is used for certain packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Antigravity 2.0
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Catppuccin Global Theme - Defined as a home-manager module and imported in home.nix
    catppuccin.url = "github:catppuccin/nix/release-26.05";
    # Home Manager - Defined as a nixos module
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # KWIN Effects Glass Flake Module for system theme
    kwin-effects-glass = {
      url = "github:4v3ngR/kwin-effects-glass";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NumtideLLM Agents - Flake module that packages common LLM agents and tools for NixOS
    llm-agents.url = "github:numtide/llm-agents.nix";
    # Nix Declarative Flatpaks - Declarative Flatpak management for applications that aren't in nixpkgs
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # Plasma-Manager - KDE Plasma Configuration Manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # PlasmaZones - Window tiling manager inspired by PowerToys FancyZones for KDE Plasma
    plasmazones.url = "github:fuddlesworth/PlasmaZones/v3.0.15";
    # SOPS Nix - Secrets management for NixOS. Defined as a nixosModule
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Vicinae - Local Desktop Search Runner
    vicinae.url = "github:vicinaehq/vicinae";
  };

  # Flake outputs passed to nixos configurations and home manager via specialArgs and extraSpecialArgs
  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable,
    antigravity-nix,
    catppuccin,
    home-manager, 
    kwin-effects-glass,
    llm-agents, 
    nix-flatpak, 
    plasma-manager, 
    plasmazones, 
    sops-nix, 
    vicinae, 
    ... 
  }@inputs:
  
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
    # Nixos Desktop - Hostname: nixadmin
    # ==========================================================================

    nixosConfigurations.nixadmin = nixpkgs.lib.nixosSystem {
      inherit system;
      # Special arguments passed to configuration.nix & nixosModules
      specialArgs = { 
        inherit self inputs pkgsUnstable; hostName = "nixadmin";
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
            # Hostname matches username for multiple hosts sharing home-manager configuration for uniformity across systems
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
        # Nix Declarative Flatpak configuration
        nix-flatpak.nixosModules.nix-flatpak
        # PlasmaZones window tiling manager for KDE Plasma
        plasmazones.nixosModules.default
        # SOPS configuration for secrets management
        sops-nix.nixosModules.sops
        # Vicinae configuration for local desktop search runner
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
        inherit self inputs pkgsUnstable; hostName = "nixpgadmin";
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
        # Nix Declarative Flatpak configuration
        nix-flatpak.nixosModules.nix-flatpak
        # PlasmaZones window tiling manager for KDE Plasma
        plasmazones.nixosModules.default
        # SOPS configuration for secrets management
        sops-nix.nixosModules.sops
        # Vicinae configuration for local desktop search runner
        vicinae.nixosModules.default 
      ];
    };  
  };
}
