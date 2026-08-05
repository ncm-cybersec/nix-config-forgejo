# ==========================================================================
# Flatpak Configuration (via nix-flatpak flake)
# ==========================================================================

{ 
  pkgs, 
  ... 
}:

{
  
  environment.systemPackages = with pkgs; [
    warehouse
  ];

  # XDG is required if using window compositors, or installing flatpaks on a per-user basis
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

  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
      "org.garudalinux.firedragon"
      "com.github.tchx84.Flatseal"
      "io.github.giantpinkrobots.flatsweep"
      "com.rustdesk.RustDesk"
      "com.vixalien.sticky"
      "io.github.flattool.Warehouse"
    ];
  };
}
