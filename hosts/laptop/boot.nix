# ==========================================================================
# Bootloader Configuration
# ==========================================================================

{
  config,
  pkgs,
  ...
}: 

{

  # Kernel module for managing BIOS settings and updating firmware for HP devices
  environment.systemPackages = with pkgs; [
    linuxPackages.hpuefi-mod
  ];  

  # Bootloader - systemd-boot
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

  # Use LTS Kernel
  boot.kernelPackages = with pkgs; [
    linuxPackages_6_12
  ];

  # Additional kernel module options
  boot.kernelModules = [
    # Essential for hardware-accelerated VMs (QEMU/KVM)
    "kvm-amd" 
    # Forces the integrated Radeon driver to initialize early
    "amdgpu" 
  ];

  boot.kernelParams = [
    # Forces the modern AMD driver for granular power management
    "amd_pstate=active"        
    # Forces Active State Power Management to save power on idle PCIe lanes
    "pcie_aspm=force"          
    # Optimizes NVIDIA VRAM sleep thresholds
    "nvidia.NVreg_DynamicPowerManagementVideoMemoryThreshold=200" 
  ];

  # Enable KVM virtualisation
  virtualisation.libvirtd.enable = true;

}
