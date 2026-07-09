# ======================================================================================
# NixOS Multi-Host Architecture and CI/CD Using Only Native Nix Options
# ======================================================================================
{
  description = "NixOS Multi-Host Architecture with CI/CD";

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
    # Global Theme - Defined as a home-manager module & imported in home.nix
    catppuccin.url = "github:catppuccin/nix/release-26.05";
    # Home Manager - Defined as a nixos module
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Flake Module for system theme
    kwin-effects-glass = {
      url = "github:4v3ngR/kwin-effects-glass";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Numtide's LLM Agents - common LLM agents and tools for NixOS
    llm-agents.url = "github:numtide/llm-agents.nix";
    # Local LLM Inference via llama.cpp, vLLM, or sglang
    llmhop = {
      url = "github:mirkolenz/llmhop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Declarative Flatpak management for applications that aren't in nixpkgs
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # KDE Plasma Configuration Manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # Window tiling manager inspired by PowerToys FancyZones for KDE Plasma
    plasmazones.url = "github:fuddlesworth/PlasmaZones/v3.0.15";
    # Secrets management for NixOS. Defined as a nixosModule
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
  } @ inputs: let
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
