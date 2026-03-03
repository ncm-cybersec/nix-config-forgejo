{ config, pkgs, ... }:

{
  imports = [


  ];

  home.username = "nixadmin";
  home.homeDirectory = "/home/nixadmin";

  # ---------------------------------------------------
  # Home Manager - nixadmin packages
  # ---------------------------------------------------

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # CLI tools
    gemini-cli
    github-copilot-cli
    github-desktop
    goose-cli
    ollama-cuda
    opencode

    # Core
    aria2
    binutils
    btop
    coreutils
    curlFull
    dnsutils
    ethtool
    fastfetch
    file
    iftop
    iotop
    iputils
    lolcat
    mtr
    nmap
    nvtopPackages.amd
    pciutils
    sysstat
    usbutils
    wget
    which
    xdg-utils

    # Dev
    android-studio
    android-tools
    antigravity

    # KDE
    hardinfo2
    kdePackages.dolphin-plugins
    kdePackages.gwenview
    kdePackages.isoimagewrier
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kalarm
    kdePackages.kamoso
    kdePackages.kate
    kdePackages.kbookmarks
    kdePackages.kcalc
    kdePackages.kcron
    kdePackages.kdeconnect-kde
    kdePackages.kdenlive
    kdePackages.kio
    kdePackages.kio-admin
    kdePackages.kio-extras
    kio-fuse
    kdePackages.kio-gdrive
    kdePackages.kruler
    kdePackages.ksystemlog
    kdePackages.partitionmanager
    kdePackages.sddm-kcm
    (python3.withPackages (ps: with ps; [
      dbus-python
      pygobject3
    ]))
    vlc
    wayland-utils

    # Productivity
    affine
    bluemail
    cherry-studio
    drawio
    libreoffice
    newelle
    newsflash
    thunderbird
    tor-browser
    vivaldi
    vivaldi-ffmpeg-codecs

    # Utilities
    ghostty
    kitty
    localsend
    netpeek
    packet
    proton-pass
    rclone
    vicinae
    waveterm
  ];

  # ---------------------------------------------------
  # Git
  # ---------------------------------------------------

  programs.git = {
    enable = true;
    userName = "nixadmin";
    userEmail = "nciampamartin@proton.me";
    extraConfig = {
      safe.directory = "/etc/nixos";
    };
  };

  # ---------------------------------------------------
  # Bash
  # ---------------------------------------------------

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    historyFileSize = 10000;
    historySize = 10000;

    initExtra = ''
      if [[ $- == *i* ]]; then
        exec ${pkgs.nushell}/bin/nu
      fi
    '';

    bashrcExtra = ''
        fastfetch | lolcat

        exec nu
    '';
  };

  # ---------------------------------------------------
  # Carapace
  # ---------------------------------------------------

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  # ---------------------------------------------------
  # Nushell
  # ---------------------------------------------------

  programs.nushell = {
    enable = true;
    # Optional: Add extra config or aliases here
    extraConfig = ''
       $env.config = {
         show_banner: false,
       }
    '';
    shellAliases = {
      ll = "ls -l";
      g = "git";
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nixos-rebuild switch --upgrade";
    };
  };

  # ---------------------------------------------------
  # Tmux
  # ---------------------------------------------------

  programs.tmux = {
    enable = true;
    shortcut = "a";
    clock24 = true;
    terminal = "screen-256color";
    historyLimit = 10000;

    extraConfig = ''
      # Set vi mode for copy mode
      set-window-option -g mode-keys vi

      # Enable mouse support
      set -g mouse on
    '';

   # xdg.configFile."tmuxai/config.yaml".text = '' Enable after Tmuxai package is installed
     # local-llama:
     # provider: "openai"
     # model: "gemma3:1b"
     # api_key: "dummy-ollama-key"
     # base_url: "http://localhost:11434/v1"
   # '';
  };

  # ---------------------------------------------------
  # Home Manager - Services (create separate file & /import)
  # ---------------------------------------------------

    services.ollama = {
      enable = true;
      acceleration = "cuda";
      loadModels = [ "gemma3:1b" ];
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

  home.stateVersion = "25.11";
}
