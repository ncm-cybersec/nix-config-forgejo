# ==========================================================================
# Nixos Top-Level Flake w/ Multiple Input Channels & BinaryCaches
# ==========================================================================

{
  description = "Nick's NixOS Top-Level Flake";

  inputs = {
    
    # Nixpkgs Stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    # Nixpkgs Unstable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # NumtideLLM Agents
    llm-agents.url = "github:numtide/llm-agents.nix";
    
    # Nix Declarative Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # SOPS Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Vicinae
    vicinae.url = "github:vicinaehq/vicinae";
  };

  # Channel outputs to be used by system modules 
  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    nixpkgs-unstable, 
    llm-agents, 
    nix-flatpak, 
    sops-nix, 
    vicinae, 
    ... 
  }@inputs:
  
  let 
    system = "x86_64-linux";
    # Define nixpkgs-unstable as pkgsUnstable to be shared with configuration.nix and home.nix
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
 
  in { 
    nixosConfigurations.nixadmin = nixpkgs.lib.nixosSystem {
      inherit system;
      
      # Pass inputs and pkgsUnstable to modules
      specialArgs = { 
        inherit inputs pkgsUnstable; 
      };
      
      # Configuration modules 
      modules = [
        
        # Core Configuration
        ./configuration.nix
        
        # Home Manager configuration for user
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { 
            inherit inputs pkgsUnstable; 
          };
          home-manager.users.nixadmin = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
        
        # Nix Declarative Flatpak configuration
        nix-flatpak.nixosModules.nix-flatpak
        
        # SOPS configuration for secrets management
        sops-nix.nixosModules.sops
      ];
    };
  };
}
