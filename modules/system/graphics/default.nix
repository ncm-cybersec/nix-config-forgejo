# ---------------------------------------------------
# Display Manager & NVIDIA GPU Configuration
# ---------------------------------------------------

{ config, pkgs,... }:

{
  # Enable X11, Wayland, nvidia, and GTK's pixbuf loader for Electron apps to display svg
  services.xserver = { 
    enable = true; 
    videoDrivers = ["nvidia"]; 
    xkb = {
      layout = "us";
      variant = "";
    };
    gdk-pixbuf.modulePackages = [ 
      pkgs.librsvg 
    ];
  };

  # Enable Plasma 6 (KDE)
  services.desktopManager.plasma6.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "plasma";
    autoLogin.user = "nixadmin";
  };

  # NVIDIA GeForce RTX 3060 12GB GPU
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

}
