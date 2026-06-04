# ==========================================================================
# Display Manager & NVIDIA GPU Configuration
# ==========================================================================

{ 
  config, 
  pkgs, 
  ... 
}:

{
  # Enable X11, Wayland, nvidia, and GTK's pixbuf loader for Electron apps to display svg
  services.xserver = {
    enable = true; 
    videoDrivers = [
      "nvidia" 
    ]; 
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Force Qt and Electron apps to use the proper Wayland/GBM backends, and set env var for GTK to use vulkan renderer
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    QT_QUICK_BACKEND = "vulkan";
  };

  # Enable GTK's pixbuf loader for Electron apps to display svg
  programs.gdk-pixbuf.modulePackages = [
    pkgs.librsvg
  ];

  # Enable Plasma 6 (KDE)
  services.desktopManager.plasma6.enable = true;

  # Enable SDDM display manager, Wayland, and auto-login 
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "plasma";
    autoLogin.user = "nixadmin";
  };

  # Enable 32 bit GPU drivers
  hardware.graphics.enable32Bit = true;  

  # NVIDIA GeForce RTX 3060 12GB GPU
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

}
