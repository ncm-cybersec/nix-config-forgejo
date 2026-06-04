# ==========================================================================
# Home Manager Rclone Conf
# ==========================================================================

{ 
  config,
  pkgs,
  ... 
}:

{
  systemd.user.services.rclone-gdrive = {
  Unit.Description = "Mount Google Drive";
  Service = {
    Environment = [
      "PATH=/run/wrappers/bin:$PATH"
    ];
    ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: /home/nixadmin/mnt/gdrive --vfs-cache-mode full";
    ExecStop = "/run/wrappers/bin/fusermount -u /home/nixadmin/mnt/gdrive";
    Restart = "on-failure";
    RestartSec = "10s";
  };
  Install.WantedBy = [ "default.target" ];
};

systemd.user.services.rclone-onedrive = {
  Unit.Description = "Mount OneDrive";
  Service = {
    Environment = [
      "PATH=/run/wrappers/bin:$PATH"
    ];
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
