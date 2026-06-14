# ==========================================================================
# Nixos Top-Level Flake w/ Multiple Input Channels & BinaryCaches
# ==========================================================================

{
  description = "Nick's NixOS Top-Level Flake";

  inputs = {
    
    # Nixpkgs Stable - Default Channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    # Nixpkgs Unstable. System is on stable channel, but unstable is used for certain packages receiving rapid updates. See home.nix, /modules/system/packages/system/default.nix, or
    # /modules/user/kdepackages/default.nix for examples.
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Catppuccin Global Theme
    catppuccin.url = "github:catppuccin/nix/release-26.05";

    # Home Manager - Declared as a module, allowing me to simply run "nix flake update" & "sudo nixos-rebuild switch" without any flags. 
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # KWIN Effects Glass Flake Module - Aesthetic
    kwin-effects-glass = {
      url = "github:4v3ngR/kwin-effects-glass";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NumtideLLM Agents - Awesome flake module that packages common LLM agents and tools for NixOS that are not currently in Nixpkgs.
    llm-agents.url = "github:numtide/llm-agents.nix";
    
    # Nix Declarative Flatpaks - Declarative Flatpak management for a couple of applications that aren't in nixpkgs, or provide more frequent updates than nixpkgs stable/unstable.
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # SOPS Nix - Secrets management for NixOS.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Vicinae - Local Desktop Search Runner
    vicinae.url = "github:vicinaehq/vicinae";
  };

  # Channel outputs to be used by system modules 
  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable,
    catppuccin,
    home-manager, 
    kwin-effects-glass,
    llm-agents, 
    nix-flatpak, 
    sops-nix, 
    vicinae, 
    ... 
  }@inputs:
  
  let 
    system = "x86_64-linux";
    
    # Define nixpkgs-unstable as pkgsUnstable to be passed to configuration.nix and home.nix
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
          home-manager.users.nixadmin = {
            imports = [
              ./home.nix
              catppuccin.homeModules.catppuccin
            ];
          };
          home-manager.backupFileExtension = "backup";
        }
        
        # Nix Declarative Flatpak configuration
        nix-flatpak.nixosModules.nix-flatpak
        
        # SOPS configuration for secrets management
        sops-nix.nixosModules.sops

        # Vicinae configuration for local desktop search runner
        vicinae.nixosModules.default 
      ];
    };
  };
}
