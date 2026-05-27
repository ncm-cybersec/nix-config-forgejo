# ---------------------------------------------------
# Display Manager & NVIDIA GPU Configuration
# ---------------------------------------------------

{ config, ... }:

{
  # Keymap 
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable X11, Wayland, and Plasma6
  services.xserver = { 
    enable = true; 
    videoDrivers = ["nvidia"]; 
  };

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
