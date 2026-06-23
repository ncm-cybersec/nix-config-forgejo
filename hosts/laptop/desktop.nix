# ==========================================================================
# Desktop Environment, KDE Plasma, & AMD/NVIDIA Hybrid Graphics Configuration
# ==========================================================================

{ 
  config,
  inputs, 
  pkgs, 
  ... 
}: 

{

  # ==========================================================================
  # Desktop Environment - KDE Plasma, Wayland
  # ==========================================================================

  # Enable Plasma 6 (KDE)
  services.desktopManager.plasma6.enable = true;

  # Enable SDDM display manager, Wayland, and auto-login 
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "plasma";
    autoLogin.user = "nixpgadmin";
  };
  
  # Enable PlasmaZones window tiling manager flake module
  programs.plasmazones = {
    enable = true;
  };

  # Enable X11
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

  # ==========================================================================
  # AMD/NVIDIA Hybrid Graphics Configuration
  # ==========================================================================

  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
  };

  hardware.nvidia = {
    # Modesetting is required for modern desktop environments 
    modesetting.enable = true;

    # Power Management: Completely turns off the dGPU when not in use
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # Use the proprietary driver package. 
    open = false;

    # Enable the NVIDIA Settings control panel dashboard
    nvidiaSettings = true;

    # Package version matching 6.12 LTS kernel
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Configure PRIME Hybrid graphics
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # Provides the 'nvidia-offload' utility shell script
      };

      # Bus IDs for hybrid graphics, verify these values using: lspci | grep -E "VGA|3D"
      amdgpuBusId = "PCI:5:0:0";  
      nvidiaBusId = "PCI:1:0:0";  
    };
  };

  # ==========================================================================
  # Power Management
  # ==========================================================================

  # Enable laptop power management, thermald to handle thermal throttling
  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = true;
  };

  # Optimize battery life
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

}
