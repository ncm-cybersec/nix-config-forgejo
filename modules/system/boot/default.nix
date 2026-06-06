# ==========================================================================
# Bootloader Configuration - Currently using Grub
#
# rEFInd chainloading systemd-boot config is below (commented out)
# ==========================================================================

{ 
  pkgs, 
  ... 
}: 

{

  # Disable systemd-boot
  boot.loader.systemd-boot.enable = false;

  # Grub bootloader configuration
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      splashImage = "/home/nixadmin/nix-config/assets/emperor.png";

      # Manual Grub Menu entry for Manjaro on nvme1n1p1
      extraEntries = ''
        menuentry "Manjaro Linux" {
          insmod part_gpt
          insmod fast
          insmod chain
          search --no-floppy --fs-uuid --set=root 6B9A-BB79
          chainloader /EFI/manjaro/grubx64.efi
        }
      '';
    };
  };

  # Use latest Zen kernel 7.0.10
  boot.kernelPackages = pkgs.linuxPackages_zen;

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

  # ==========================================================================
  # rEFInd Bootloader Configuration - rEFInd chainloads systemd-boot
  # ==========================================================================

  # Bootloader configuration; enabled systemd-boot for generation tracking (rEFInd will chainload this)
  #boot.loader = {
    #systemd-boot.enable = true;
    #efi = {
      # EFI variables disabled to prevent systemd-boot from taking over rEFInd
      #canTouchEfiVariables = false;
      #efiSysMountPoint = "/boot";
    #};
  #};

  # Add refind package so we can run `refind-install`
  # See refindtheme.conf for custom theme and complete configuration steps for NixOS.
  #environment.systemPackages = with pkgs; [
    #refind
  #];

}
