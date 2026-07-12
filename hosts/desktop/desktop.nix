# ==========================================================================
# Desktop Environment & NVIDIA GPU Configuration
# ==========================================================================

{ 
  config,
  pkgs, 
  ... 
}:

{

  # Enable PlasmaZones window tiling manager 
  programs = {
    plasmazones.enable = true;
    
    # Enable GTK pixbuf loader for Electron apps to display svg
    gdk-pixbuf.modulePackages = [
      pkgs.librsvg
    ];
  };

  # Desktop environment configuration
  services = {
    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    
      defaultSession = "plasma";
      autoLogin.user = "nixadmin";
    };
  
    xserver = {
      enable = true; 
      videoDrivers = [
        "nvidia" 
      ];
      
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
  
  # Force Qt/Electron apps to use Wayland/GBM, set env var for GTK to use vulkan renderer
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  # NVIDIA GeForce RTX 3060 12GB GPU
  hardware = {
    graphics.enable32Bit = true;  

    nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
