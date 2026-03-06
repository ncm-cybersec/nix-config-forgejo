# ---------------------------------------------------
# Display Manager & NVIDIA GPU Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

{
  # Keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable X11 windowing system
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.autoLogin.user = "nixadmin";

  # NVIDIA 3060 GPU
  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.open = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
}
