{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # NixOS Hardware / OS Configuration

  # NixOS NVIDIA GPU Graphics/Drivers Configuration

  # 1. Essential for NVIDIA drivers
  nixpkgs.config.allowUnfree = true;

  # 2. Graphics and Driver Setup
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Bootloader - Disable systemd-boot
  boot.loader.systemd-boot.enable = false;

  # Bootloader - Enable/Configure Grub
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

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Kernel Modules
  boot.kernelModules = [ "kvm-amd" "i2c-dev" "i2c-piix4" ];
  # Enable KVM virtualisation
  virtualisation.libvirtd.enable = true;
  # I2C Kernel Modules for OpenRGB
  hardware.i2c.enable = true;

  networking.hostName = "nixadmin"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable Bluetooth Support
  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      # Shows battery charge of connected devices on supported
      # Bluetooth adapters. Defaults to 'false'.
      Experimental = true;
      # When enabled other devices can connect faster to us, however
      # the tradeoff is increased power consumption. Defaults to
      # 'false'.
      FastConnectable = true;
    };
    Policy = {
      # Enable all controllers when they are found. This includes
      # adapters present on start as well as adapters that are plugged
      # in later on. Defaults to 'true'.
      AutoEnable = true;
      };
    };
  };

  # Bluetooth GUI Manager
  services.blueman.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NixOS User Configuration - Will be added to Home-Manager

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixadmin = {
    isNormalUser = true;
    description = "nixadmin";
    extraGroups = [ "networkmanager" "wheel" "podman" "adbusers" "libvirtd" "kvm" "i2c" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable ADB/Scrcpy
  programs.adb.enable = true;

  # Enable kdeconnect
  programs.kdeconnect.enable = true;

  # Enable virt-manager
  programs.virt-manager.enable = true;

  # Fastfetch | lolcat for bash startup
  programs.bash.shellAliases = {
  # This doesn't just create an alias;
  # it ensures the tools are available and defined in the shell environment.
  fastf = "fastfetch | lolcat";
  };

  # Force the command to run at the very end of the bashrc
  programs.bash.promptInit = ''
    fastfetch | lolcat
  '';

  # enable appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # ---------------------------------------------------
  # NixOS - system packages
  # ---------------------------------------------------

  environment.systemPackages = with pkgs; [

     # Applications
     distrobox
     distroshelf
     podman
     podman-compose
     podman-desktop
     qemu
     # QEMU UEFI support
     (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
     virt-manager

     # System
     bat
     cargo
     cmake
     deadnix
     dbus
     direnv
     gdb
     git
     gparted
     i2c-tools
     libvirt
     llvm
     manix
     nfs-utils
     nix-index
     nix-remplate
     nix-tree
     nix-update
     nixpkgs-fmt
     nixpkgs-review
     nodejs_24
     openrgb-with-all-plugins
     pavucontrol
     perl
     python3
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # NixOS System Services Configuration

  # List services that you want to enable:

  # Podman virtualisation
  virtualisation = {
  containers.enable = true;
  podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Podman container registries
  virtualisation.containers.registries.search = [
    "docker.io"
    "quay.io"
    "ghcr.io"
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable OpenRGB udev
  services.hardware.openrgb.enable = true;

  # Enable Avahi/mDNS for network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
    };
  };

  # Enable Vicinae service and autostart
  # Vicinae launcher service
  systemd.user.services.vicinae = {
  description = "Vicinae desktop launcher server";
  wantedBy = [ "graphical-session.target" ];
  after = [ "graphical-session.target" ];

  serviceConfig = {
    Type = "simple";
    Environment = "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/%u/bin";
    ExecStart = "${pkgs.vicinae}/bin/vicinae server";
    Restart = "on-failure";
    RestartSec = 5;
   };
  };

  # NixOS Network Configuration

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    9300  # Packet / Quick Share
    53317 # Localsend
  ];

  networking.firewall.allowedUDPPorts = [
    5353 # Avahi / MDNS, enabled by services.avahi ^
    53317 # Localsend
  ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
