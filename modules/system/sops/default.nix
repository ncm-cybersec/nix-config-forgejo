# ==========================================================================
# SOPS Secrets Management - System
# ==========================================================================

{ 
  config,
  pkgs,
  inputs,
  ... 
}:

{

  # Import sops-nix system module
  imports = [
    inputs.sops-nix.nixosModules.sops 
  ];

  # Install the sops CLI tool 
  home.packages = with pkgs; [
    age
    sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt"; 
    
    secrets = {
      
      syncthing_gui_password = {
        path = "${config.home.homeDirectory}/.config/syncthing/syncthing_gui_password";
        neededForUsers = true; 
      };
    };
  };
}
