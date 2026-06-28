# ==========================================================================
# Home Manager Rclone Conf - Desktop
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
  
  # Mount Google Drive using rclone via systemd service
  systemd.user.services.rclone-gdrive = {
    Unit.Description = "Mount Google Drive";
    Service = {
      Environment = [
        "PATH=/run/wrappers/bin:$PATH"
      ];
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/nixadmin/mnt/gdrive";
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: /home/nixadmin/mnt/gdrive --vfs-cache-mode full --poll-interval 15s";
      ExecStop = "/run/wrappers/bin/fusermount -u /home/nixadmin/mnt/gdrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    Install.WantedBy = [ "default.target" ];
  };

  # Mount OneDrive using rclone via systemd service
  systemd.user.services.rclone-onedrive = {
    Unit.Description = "Mount OneDrive";
    Service = {
      Environment = [
        "PATH=/run/wrappers/bin:$PATH"
      ];
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/nixadmin/mnt/onedrive";
      ExecStart = "${pkgs.rclone}/bin/rclone mount onedrive: /home/nixadmin/mnt/onedrive --vfs-cache-mode full";
      ExecStop = "/run/wrappers/bin/fusermount -u /home/nixadmin/mnt/onedrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    Install.WantedBy = [
      "default.target" 
    ];
  };
}
