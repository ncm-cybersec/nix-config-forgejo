# ==========================================================================
# Flatpak
# ==========================================================================

{ 
  pkgs, 
  ... 
}:

{
  
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
    extraPortals = with pkgs;[
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk   
    ];
  };

  # Enable Flatpak
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "org.garudalinux.firedragon"
    ];
  };

}
