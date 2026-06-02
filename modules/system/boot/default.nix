# ---------------------------------------------------
# Bootloader Configuration
# ---------------------------------------------------

{ pkgs, ... }:

{

  # Bootloader configuration; enabled systemd-boot for generation tracking (rEFInd will chainload this)
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      # EFI variables disabled to prevent systemd-boot from taking over rEFInd
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
  };

  # Add refind package so we can run `refind-install`
  environment.systemPackages = with pkgs; [
    refind
  ];

  # Use latest Zen kernel 7.0.10
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Kernel modules
  boot.kernelModules = [ "kvm-amd" "i2c-dev" "i2c-piix4" ];

  # ACPI / SMBus Conflict Fix for OpenRGB
  boot.kernelParams = [ "acpi_enforce_resources=lax" ];

  # Enable KVM virtualisation
  virtualisation.libvirtd.enable = true;

  # I2C kernel modules for openrgb
  hardware.i2c.enable = true;

}
