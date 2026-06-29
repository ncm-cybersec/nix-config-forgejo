# ==========================================================================
# Syncthing Service Configuration - Host 2
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

    user = "nixpgadmin"; 
    group = "users";
    dataDir = "/home/nixpgadmin/Homelab";
    configDir = "/home/nixadmin/.config/syncthing";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      gui = {
        user = "nixpgadmin";
        password = config.sops.secrets.syncthing_gui_password.path;
      };

      devices = {
        "Desktop" = { 
          id = "FPMFDBM-C7ZQX2H-SUBB43X-Y6UBSEW-VOJCBA2-F5SSJFS-NF3UMRY-F4EVVAQ"; 
        };
      };
      
      folders = {
        "Homelab" = {
          id = "homelab-sync-id"; 
          path = "/home/nixpgadmin/Homelab"; 
          devices = [ "Desktop" ]; 
        };
      };
    };
  };
}
