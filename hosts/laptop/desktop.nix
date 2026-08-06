# ==========================================================================
# Desktop Environment, KDE Plasma, & AMD/NVIDIA Hybrid Graphics Configuration
# ==========================================================================

{ 
  config,
  ... 
}: 

{

  # Enable PlasmaZones window tiling manager
  programs.plasmazones = {
    enable = true;
  };
  
  # Desktop environment configuration
  services = { 
    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
      };
      
      defaultSession = "plasma";
      autoLogin.user = "nixpgadmin";
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
  
  # AMD/NVIDIA Hybrid Graphics
  hardware = { 
    graphics = {
      enable = true;
      enable32Bit = true; 
    };

    nvidia = {
      modesetting.enable = true;

      # Power Management: turns off dGPU when not in use
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Configure PRIME Hybrid graphics
      prime = {
      
        # nvidia-offload utility shell script
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        # Bus IDs for hybrid graphics, verify using: lspci | grep -E "VGA|3D"
        amdgpuBusId = "PCI:5:0:0";  
        nvidiaBusId = "PCI:1:0:0";  
      };
    };
  };

  # Enable laptop power management, thermal throttling
  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = true;
  };

  # Optimize battery life
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  
  # Forces background LLM services to utilize dGPU
  systemd.services."llmhop-llama-cpp@" = {
    environment = {
      "__NV_PRIME_RENDER_OFFLOAD" = "1";
      "__NV_PRIME_RENDER_OFFLOAD_PROVIDER" = "NVIDIA-G0";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
      "__VK_LAYER_NV_optimus" = "NVIDIA_only";
    };
  };
}
