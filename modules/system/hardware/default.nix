# ==========================================================================
# Time, Bluetooth, Printing, OpenRGB & Pipewire Configuration
# ==========================================================================

{ 
  pkgs, 
  ... 
}: 

{

  environment.systemPackages = with pkgs; [
    
    bluez-tools
    input-leap
    pavucontrol
    polychromatic
    
  ];

  # Time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;     
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # Hardware Services
  services = {
    
    # CUPS & epson print drivers
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        epson-escpr2
      ];
    };

    # Enable OpenRGB udev
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };

    # Pipewire
    pulseaudio.enable = false;
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
  
  # Realtimekit for low-latency audio
  security.rtkit.enable = true;

}
