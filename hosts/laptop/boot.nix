# ==========================================================================
# Bootloader Configuration
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

  # Systemd-boot
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
    
    # Use LTS Kernel
    kernelPackages = pkgs.linuxPackages_6_12;

    # Additional kernel module options
    kernelModules = [
      "kvm-amd" 
      "amdgpu" 
    ];

    kernelParams = [
      # AMD driver for power management
      "amd_pstate=active"        
      # Power savings on idle PCIe lanes
      "pcie_aspm=force"          
      # NVIDIA VRAM sleep threshold optimization
      "nvidia.NVreg_DynamicPowerManagementVideoMemoryThreshold=200" 
    ];
    
    supportedFilesystems = [
      "fuse"
    ];
  };

  # Enable KVM virtualisation
  virtualisation.libvirtd.enable = true;

}
