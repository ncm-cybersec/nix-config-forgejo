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
  home.packages = with pkgs; [
    age
    sops
  ];

  # Configure secrets
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml; 
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt"; 
    
    secrets = {

      git_config_user = {
        path = "${config.home.homeDirectory}/.config/git/git_config_user";
      };
      forgejo_desktop_ssh_config = {
      };
      forgejo_ssh_config = {
        path = "/var/lib/sops-nix/key.txt";
      };
      syncthing_gui_password = {
        path = "${config.home.homeDirectory}/.config/syncthing/syncthing_gui_password";
      };
    };
  };
}
