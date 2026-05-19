# ---------------------------------------------------
# Nixos Syncthing Service
# ---------------------------------------------------

{ config, pkgs, pkgsUnstable, ... }:

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

    # Override all settings set from the GUI. This is necessary if I don't want to have changes made from the GUI apply.
    overrideDevices = true;
    overrideFolders = true;

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