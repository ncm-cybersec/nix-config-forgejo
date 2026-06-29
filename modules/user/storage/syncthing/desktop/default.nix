# ==========================================================================
# Syncthing Service Configuration
# ==========================================================================

{ 
  config, 
  pkgs, 
  ... 
}:

{

  sops.secrets.syncthing_gui_password = {
    neededForUsers = true;
  };

  # Enable Syncthing
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
      gui = {
        user = "nixadmin";
        password = config.sops.secrets.syncthing_gui_password.path;
      };

      devices = {
        "Laptop" = {
          id = "752JW4C-QUCT7PP-MVXSL7E-YHGM3YA-RPK3NKI-BWHU2GS-DM6PAVX-BH4LMAC";
        };        
      };

      folders = {
        "Homelab" = {
          id = "homelab-sync-id";
          path = "/home/nixadmin/Homelab";
          devices = [ "Laptop" ];
        };
      };
    };
  };
}