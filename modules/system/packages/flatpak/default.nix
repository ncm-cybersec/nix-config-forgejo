# ---------------------------------------------------
# Flatpak
# ---------------------------------------------------

{ pkgs, pkgsUnstable, ... }:

{

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

}
