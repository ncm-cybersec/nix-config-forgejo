# ======================================================================================
# N1x_Cybersec - NixOS Workstation & Home Lab Control Center
# ======================================================================================

{
  description = "NixOS Multi-Host Architecture & Nix Native CI/CD (Nixsync)";

  # Binary caches
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
      "https://catppuccin.cachix.org"
      "https://cache.numtide.com"
      "https://vicinae.cachix.org"
    ];
    
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    catppuccin.url = "github:catppuccin/nix/release-26.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    kwin-effects-glass = {
      url = "github:4v3ngR/kwin-effects-glass";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
    
    llmhop = {
      url = "github:mirkolenz/llmhop";
    };
    
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    
    plasmazones.url = "github:fuddlesworth/PlasmaZones/v3.0.15";
    
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
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
    
    # Refactored to streamline host configs
    system = "x86_64-linux";
    
    # Define nixpkgs-unstable as pkgsUnstable
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-39.8.10"
          "pnpm-10.29.2"
        ];       
      };
    };
    
    # Define hosts and configuration paths
    hosts = {
      nixadmin = {
        configPath = ./hosts/desktop/configuration.nix; 
        username = "nixadmin";
        isDesktop = true;
      };
      
      nixpgadmin = {
        configPath = ./hosts/laptop/configuration.nix;  
        username = "nixpgadmin";
        isLaptop = true;
      };
    };
    
  in {
    
    # Programmatically define top-level nixosModules & homeModules
    nixosConfigurations = builtins.mapAttrs (hostName: hostCfg: nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit self inputs pkgsUnstable hostName;
      };
      
      modules = [
        # Dynamic Core Configuration based on host
        hostCfg.configPath
        
        # Shared Home Manager setup
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit inputs pkgsUnstable hostName;
            username = hostCfg.username;
          };
          
          # Dynamically set the username block
          home-manager.users."${hostCfg.username}" = {
            imports = [
              ./home.nix
              catppuccin.homeModules.catppuccin
              plasma-manager.homeModules.plasma-manager
            ]
            
            # Desktop homeModules
            ++ (nixpkgs.lib.lists.optionals (hostCfg ? isDesktop && hostCfg.isDesktop) [
              
            ])
            
            # Laptop homeModules
            ++ (nixpkgs.lib.lists.optionals (hostCfg ? isLaptop && hostCfg.isLaptop) [

            ]);
          };
        }
        
        # Shared global modules
        llmhop.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        plasmazones.nixosModules.default
        sops-nix.nixosModules.sops
        vicinae.nixosModules.default
      ]

        # Desktop nixosModules
        ++ (nixpkgs.lib.lists.optionals (hostCfg ? isDesktop && hostCfg.isDesktop) [

        ])

        # Laptop nixosModules
        ++ (nixpkgs.lib.lists.optionals (hostCfg ? isLaptop && hostCfg.isLaptop) [

        ]);
        
    }) hosts; 
  };
}
