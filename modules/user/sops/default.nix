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

  # Import the sops-nix Home Manager module
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  # Install the sops CLI tool 
  home.packages = [
    pkgs.sops
  ];

  # Configure secrets
  sops = {
    defaultSopsFile = /home/nixadmin/nix-config/secrets/secrets.yaml; 
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt"; 
    
    secrets = {

      git_config_user = {
        path = "${config.home.homeDirectory}/.config/git/git_config_user";
      };
    };
  };
}
