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

  # Kernel module for managing BIOS settings and updating firmware for HP devices
  environment.systemPackages = with pkgs; [
    linuxPackages.hpuefi-mod
  ];

  # systemd-boot
  boot.loader = {
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
  boot.kernelPackages = with pkgs; [
    linuxPackages_zen
  ];

  # Kernel modules
  boot.kernelModules = [ 
    "kvm-amd"    # KVM virtualization
    "i2c-dev"    # I2C device support - required for OpenRGB
    "i2c-piix4"  # SMBus for Ryzen - required for OpenRGB
  ];

  # ACPI / SMBus Conflict Fix for OpenRGB
  # Allows OpenRGB to access i2c/SMBus devices (including motherboard RGB, RAM modules, and fans)
  boot.kernelParams = [ 
    "acpi_enforce_resources=lax" 
  ];

  # Enable KVM virtualisation
  virtualisation.libvirtd.enable = true;

  # I2C kernel modules for openrgb
  hardware.i2c.enable = true;

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
