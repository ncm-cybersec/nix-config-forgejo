# ---------------------------------------------------
# Nixos Syncthing Service
# ---------------------------------------------------

{ config, pkgs, ... }:

{
  # Enable Syncthing with declarative configuration	
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder.
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