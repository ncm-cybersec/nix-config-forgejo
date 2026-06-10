# ==========================================================================
# SOPS Secrets Management Configuration
# ==========================================================================

{ 
  config, 
  pkgs, 
  inputs, 
  ... 
}: 

{

  # Install the sops CLI tool 
  home.packages = [
    pkgs.sops
  ];

  # Import the sops-nix Home Manager module
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # Configure secrets
  sops = {
    defaultSopsFile = /home/nixadmin/nix-config/secrets/secrets.yaml; 
    age.keyFile = "/home/nixadmin/.config/sops/age/keys.txt"; 
    
    secrets = {
      # ==========================================================================
      # Environment Variables
      # ==========================================================================
      HOME_NIXOS_PASSWORD = {
        path = "secrets.yaml";
        sops.age.ageKeyFile = "~/.config/sops/age/keys.txt";
      };
    };
  };
}
