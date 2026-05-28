# ------------------------------------------------------------------------
# Nixos Top-Level Flake w/ Multiple Input Channels & BinaryCaches
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
          "electron-38.8.4"
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
