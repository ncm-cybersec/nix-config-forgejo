# ==========================================================================
# Nixos Top-Level Flake w/ Multiple Input Channels & BinaryCaches
# ==========================================================================

{
  description = "Nick's NixOS Top-Level Flake";

  inputs = {
    
    # Nixpkgs Stable - Default Channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    # Nixpkgs Unstable. System is on stable channel, but unstable is used for certain packages receiving rapid updates. See home.nix, /modules/system/packages/system, or
    # /modules/user/kdepackages for examples.
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Catppuccin Global Theme - Defined as a home-manager module and imported in home.nix (line 112). Module options defined in /modules/user/theme.
    catppuccin.url = "github:catppuccin/nix/release-26.05";

    # Home Manager - Defined as a nixos module (lines 102-116), allowing me to simply run "nix flake update" & "sudo nixos-rebuild switch" without any flags. 
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # KWIN Effects Glass Flake Module for system theme. Added as an input to /modules/system/theme.
    kwin-effects-glass = {
      url = "github:4v3ngR/kwin-effects-glass";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NumtideLLM Agents - Flake module that packages common LLM agents and tools for NixOS that are not currently in Nixpkgs, added as an input to /modules/user/llmagents.
    llm-agents.url = "github:numtide/llm-agents.nix";
    
    # Nix Declarative Flatpaks - Declarative Flatpak management for applications that aren't in nixpkgs, or provide more frequent updates than nixpkgs stable/unstable. Defined as a nixosModule (line 119) and added as an input to /modules/system/packages/system.
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # PlasmaZones - Window tiling manager inspired by PowerToys FancyZones for KDE Plasma. Defined as a nixosModule (line 126) and imported as a program in /modules/system/desktop.
    # Flake input pinned to release v3.0.15, as nixpkgs stable or unstable does not currently support KWIN 6.7. 
    plasmazones.url = "github:fuddlesworth/PlasmaZones/v3.0.15";

    # SOPS Nix - Secrets management for NixOS. Defined as a nixosModule (line 129) and added as an input to /modules/system/security.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Vicinae - Local Desktop Search Runner. Defined as a nixosModule (line 132)for low-level system access and permissions, then imported in /modules/user/utilities/vicinae as a homeModule for access to custom options.
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
    
    # System primarily uses nixpkgs stable, but defines nixpkgs-unstable as pkgsUnstable, passing it to configuration.nix using specialArgs, and home.nix using extraSpecialArgs (lines 106-107). This allows stable and unstable packages to be safely mixed. See home.nix, /modules/system/packages/system/default.nix, /modules/user/llmagents for examples.
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config = {
        # Allow proprietary packages
        allowUnfree = true;
        
        # Allow specific insecure packages (required for certain apps like warp-terminal)
        permittedInsecurePackages = [
          "electron-38.8.4"
          "electron-39.8.10"
        ];
        
      };
    };
  
  # nixosConfigurations.nixadmin attribute is defined to match the hostname of the machine (defined as "networking.hostName = "nixadmin";" in configuration.nix), to allow for multiple machines to use the same flake, each with its own configuration, by simply changing the hostname attribute. For example, if you want to use the flake on a new machine, change the hostname attributes in flake.nix, configuration.nix, and home.nix to the new machine's hostname and run "sudo nixos-rebuild switch". Existing System/User Modules can be removed if needed by commenting out the relevant imports in /modules/system/default.nix, and /modules/user/default.nix. 
  
  # nixos-rebuild is intelligent enough to detect this attribute, enforce locked inputs instead of using channels (flake.lock from running "nix flake update"), detect home-manager as a nixos module (see below), and rebuild the entire system through "sudo nixos-rebuild switch" without any flags.
  
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
            # Hostname matches username, required for multiple hosts to share my home-manager configuration for uniformity across systems.
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
            # Hostname matches username, required for multiple hosts to share my home-manager configuration for uniformity across systems.
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
