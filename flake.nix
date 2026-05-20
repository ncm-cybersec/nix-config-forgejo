# ------------------------------------------------------------------------
# Nixos Top-Level Flake w/ Multiple Input Channels & Caches
# ------------------------------------------------------------------------

{
  description = "Nick's NixOS Top-Level Flake";

  inputs = {
    # Nixpkgs Stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # Nixpkgs Unstable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NumtideLLM Agents
    llm-agents.url = "github:numtide/llm-agents.nix";
    # SOPS Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Vicinae
    vicinae.url = "github:vicinaehq/vicinae";
  };

  # Channel outputs to be used by system modules 
  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, llm-agents, sops-nix, vicinae, ... }@inputs:
  
  let 
    system = "x86_64-linux";
    # Define nixpkgs-unstable as pkgsUnstable to be shared with configuration.nix and home.nix
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-37.10.3"
        ];
      };
    };
 
  in { 
    nixosConfigurations.nixadmin = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs pkgsUnstable; };
      # Configuration modules 
      modules = [
        # Core Configuration
        ./configuration.nix
        # Input channel binary caches
        ({ config, pkgs, ... }: {
          nix.settings.substituters = [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org"
            "https://cache.numtide.com"
            "https://vicinae.cachix.org"
          ];
          nix.settings.trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "cache.nixos.org-1:mCHdDbf9VMTLI1uSRunKadHYADjL5YhBJWhhSPK6QR0="
            "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
            "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
          ];
        })
        # Home Manager configuration for user
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs pkgsUnstable; };
          home-manager.users.nixadmin = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
        # SOPS configuration for secrets management
        sops-nix.nixosModules.sops
      ];
    };
  };
}
