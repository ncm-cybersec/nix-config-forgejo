# ==========================================================================
# Flatpak Configuration (via nix-flatpak flake)
# ==========================================================================

{ 
  pkgs, 
  ... 
}:

{
  
  # The xdg block is required to install flatpak on systems using window compositors, or installing flatpaks on a per-user basis. This system uses the nix-flatpak flake module (see flake.nix line 119) to declare flatpaks. The nix option services.flatpak.enable is supposed to handle xdg, but it is defined here anyway as a fallback because xdg is required for flatpak to integrate with the host system.
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
