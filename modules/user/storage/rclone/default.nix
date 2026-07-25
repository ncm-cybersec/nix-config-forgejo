# ==========================================================================
# Home Manager Rclone Conf - Desktop & Laptop
# ==========================================================================

{ 
  config,
  pkgs,
  ... 
}:

{

  home.packages = with pkgs; [
    rclone
    remote-exec
    rsync
  ];
  
  sops.secrets = {
    rclone-gd = {
      sopsFile = ../../../../secrets/storage/rclone-gd.yaml;
      key = "RCLONE_CONFIG_PASS";
    };
    
    rclone-od = {
      sopsFile = ../../../../secrets/storage/rclone-od.yaml;
      key = "RCLONE_CONFIG_PASS";
    };
  };
  
  # Mount GoogleDrive remote as systemd service
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Mount Google Drive";
      After = [ "network-online.target" "sops-nix.service" ];
      Wants = [ "network-online.target" "sops-nix.service" ];
    };
    
    Service = {
      EnvironmentFile = [ "-${config.sops.secrets.rclone-gd.path}" ];
      Environment = [ "PATH=/run/wrappers/bin:$PATH" ];
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${config.home.homeDirectory}/mnt/GoogleDrive";
      ExecStart = "${pkgs.rclone}/bin/rclone mount googledrive: ${config.home.homeDirectory}/mnt/GoogleDrive --vfs-cache-mode full --allow-other --poll-interval 15s";
      ExecStop = "/run/wrappers/bin/fusermount -u ${config.home.homeDirectory}/mnt/GoogleDrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    
    Install.WantedBy = [ "default.target" ];
  };

  # Mount OneDrive remote as systemd service
  systemd.user.services.rclone-onedrive = {
    Unit = {
      Description = "Mount OneDrive";
      After = [ "network-online.target" "sops-nix.service" ];
      Wants = [ "network-online.target" "sops-nix.service" ];
    };
    
    Service = {
      Environment = [ "PATH=/run/wrappers/bin:$PATH" ];
      EnvironmentFile = [ "-${config.sops.secrets.rclone-od.path}" ];
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${config.home.homeDirectory}/mnt/OneDrive";
      ExecStart = "${pkgs.rclone}/bin/rclone mount onedrive: ${config.home.homeDirectory}/mnt/OneDrive --vfs-cache-mode full --allow-other --exclude '/Personal Vault/**'";
      ExecStop = "/run/wrappers/bin/fusermount -u ${config.home.homeDirectory}/mnt/OneDrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    
    Install.WantedBy = [ "default.target" ];
  };
}
