# ==========================================================================
# Bootloader Configuration - Currently using systemd-boot (UEFI)
#
# GRUB config is kept below (commented out) for reference.
# ==========================================================================

{ 
  pkgs, 
  ... 
}: 

{

  # Kernel module for managing BIOS settings & updating HP firmware
  environment.systemPackages = with pkgs; [
    
    efibooteditor
    efibootmgr
    efitools
    i2c-tools
    linuxPackages.hpuefi-mod
    
  ];

  # Boot options
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    # Use latest Zen kernel 7.0.10
    kernelPackages = pkgs.linuxPackages_zen;
    
    # Kernel modules
    kernelModules = [ 
      "i2c-dev"          # I2C device support for OpenRGB
      "i2c-piix4"        # SMBus for Ryzen/OpenRGB
      "kvm-amd"          # KVM virtualization
      "uvcvideo"         # Webcam support
      "videobuf2_v4l2"   # Video buffer for webcam
    ];

    # ACPI/SMBus conflict fix for OpenRGB
    kernelParams = [ 
      "acpi_enforce_resources=lax" 
    ];
    
    supportedFilesystems = [
      "fuse"
    ];
  };

  # Hardware Modules
  hardware = {
    
    # I2C kernel modules for openrgb
    i2c.enable = true;
    
    # Allow unfree firmware
    enableAllFirmware = true;
    
    # Drivers for Razer devices
    openrazer = {
      enable = true;
      batteryNotifier = {
        enable = true;
        percentage = 33;
      };
    };
  };
  
  # Enable KVM virtualisation
  virtualisation.libvirtd.enable = true;



  # GRUB kept for reference (NOT active)
  #boot.loader.grub = {
  #  enable = true;
  #  efiSupport = true;
  #  device = "nodev";
  #  useOSProber = true;   # auto-detects Manjaro / Windows
  #  splashImage = "/home/nixadmin/nix-config/assets/emperor.png";
  #  extraEntries = ''
  #    menuentry "Manjaro Linux" {
  #      insmod part_gpt
  #      insmod fast
  #      insmod chain
  #      search --no-floppy --fs-uuid --set=root 6B9A-BB79
  #      chainloader /EFI/manjaro/grubx64.efi
  #    }
  #  '';
  #};

}
