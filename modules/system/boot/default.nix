# ---------------------------------------------------
# Bootloader Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

{
  # Disable systemd-boot
  boot.loader.systemd-boot.enable = false;

  # Grub
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
      splashImage = "/etc/nixos/emperor.png";

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

  # Use LTS kernel
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Kernel modules
  boot.kernelModules = [ "kvm-amd" "i2c-dev" "i2c-piix4" ];

  # ACPI / SMBus Conflict Fix for OpenRGB
  boot.kernelParams = [ "acpi_enforce_resources=lax" ];

  # Enable KVM virtualisation
  virtualisation.libvirtd.enable = true;

  # I2C kernel modules for openrgb
  hardware.i2c.enable = true;

}
