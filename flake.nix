# ---------------------------------------------------
# Nixos w/ Flakes, Home Manager, and Multiple Inputs
# ---------------------------------------------------

{
  description = "Nick's NixOS Conf with Flakes & Home Manager'";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    vicinae.url = "github:vicinaehq/vicinae";
  };

    nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, llm-agents, vicinae, ... }@inputs:
  
  let 
    system = "x86_64-linux";

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
      
      modules = [
           ./configuration.nix
           home-manager.nixosModules.home-manager
           {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.extraSpecialArgs = { inherit inputs pkgsUnstable; };
             home-manager.users.nixadmin = import ./home.nix;
             home-manager.backupFileExtension = "backup";
           }
         ];
       };
     };

}
