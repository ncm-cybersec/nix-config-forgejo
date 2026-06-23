# ======================================================================================
# Nixos Top-Level Flake w/ Multiple Input Channels & BinaryCaches
#
# - Refactored for multiple hosts sharing the same repo, each with their own
#   host-specific configuration, shared system modules, and a shared home-manager
#   configuration for uniformity across systems.
# - System (configuration.nix) and User (home.nix) modules are imported using
#   a conditional list based on config.networking.hostName, defined by lib.optionals.
# - Defining username and hostname as the same value across top-level flake.nix, home.nix,  
#   and respective configuration.nix allows nixos-rebuild to intelligently detect hosts,
#   enforce locked inputs, and atomically build top-level configurations using "nixos-rebuild #   switch" without any flags.
#
# - SOPS is used for secrets management, and a CI pipeline has been implemented using only
#   nix-native options, and a scripted nixos-upgrade service to sync changes between hosts.
#
# - This is the most involved NixOS project I have attempted thus far, and any thoughts 
#   or suggestions for improvement are welcome! I am workshopping a name for the CI; 
#   maybe something like "nixsync" or "ntvenix"?
# 
# ======================================================================================

{
  description = "Nick's NixOS Top-Level Flake";

  inputs = {
    # Nixpkgs Stable - Default Channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # Nixpkgs Unstable. System is on stable channel, but unstable is used for certain packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    catppuccin,
    home-manager, 
    kwin-effects-glass,
    llm-agents, 
    nix-flatpak, 
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
  
  # nixosConfigurations.nixadmin attribute is defined to match the hostname of the machine to allow for multiple machines to use the same flake, each with its own configuration, by simply changing the hostname attribute

  # nixos-rebuild is intelligent enough to detect this attribute, enforce locked inputs instead of using channels, detect home-manager as a nixos module, and rebuild the entire system through "sudo nixos-rebuild switch" without any flags
  
  in { 

    # ==========================================================================
    # Nixos Desktop - Hostname: nixadmin
    # ==========================================================================

    nixosConfigurations.nixadmin = nixpkgs.lib.nixosSystem {
      inherit system;
      # Special arguments passed to configuration.nix & nixosModules
      specialArgs = { 
        inherit self inputs pkgsUnstable; 
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
            username = "nixadmin";          
          };
          home-manager.users.nixadmin = {
            imports = [
              ./home.nix
              catppuccin.homeModules.catppuccin
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
        inherit self inputs pkgsUnstable; 
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
            username = "nixpgadmin";          
          };
          home-manager.users.nixpgadmin = {
            imports = [
              ./home.nix
              catppuccin.homeModules.catppuccin
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
