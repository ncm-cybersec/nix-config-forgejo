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
  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt"; 
    
    secrets = {

      syncthing_gui_pass = {
        neededForUsers = true; 
      };
    };
  };
}
