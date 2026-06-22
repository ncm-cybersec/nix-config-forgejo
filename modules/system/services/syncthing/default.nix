# ==========================================================================
# Syncthing Service Configuration
# ==========================================================================

{ 
  config, 
  pkgs, 
  ... 
}:

{
  # Enable Syncthing with declarative configuration
  
  # Don't create default ~/Sync folder
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; 
  services.syncthing = {
    enable = true;
    package = pkgs.syncthing;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    user = "nixadmin";
    group = "users";
    configDir = "/home/nixadmin/.config/syncthing";

    settings = {
      devices = {
        
      };
      folders = {
        "Homelab" = {
          path = "/home/nixadmin/NCM_Cybersec/homelab";
        };
      };
    };
  };

}