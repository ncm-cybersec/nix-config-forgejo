# ---------------------------------------------------
# Nixos System Services
# ---------------------------------------------------

{ pkgs, pkgsUnstable, ... }:

{
  # Enable Avahi/mDNS for network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
    };
  };

  # Enable Flatpak
  services.flatpak.enable = true;

  # Required to install flatpak
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "kde"
        ];
      };
    };
  };

  # Enable OpenRGB udev
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

}
