{
  description = "Nick's NixOS Conf with Flakes & Home Manager'";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

  outputs = inputs@{ nixpkgs, home-manager, vicinae, ... }: {
     nixosConfigurations = {
       nixadmin = nixpkgs.lib.nixosSystem {
         modules = [
           ./configuration.nix

           home-manager.nixosModules.home-manager
           {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.extraSpecialArgs = { inherit vicinae; };
             home-manager.users.nixadmin = import ./home.nix;
             home-manager.backupFileExtension = "backup";
           }
         ];
       };
     };
   };
 }
