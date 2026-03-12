# ---------------------------------------------------
# Display Manager & NVIDIA GPU Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

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

  # NVIDIA 3060 GPU
  hardware.graphics.enable = true;

  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

}
