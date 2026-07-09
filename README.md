# NixOS Multi-Host Architecture and CI/CD Using Only Native Nix Options

I have been using NixOS exclusively as my daily driver on my primary desktop for the last year. As a student with only a handful of courses remaining for a BS of Information Technologies with a focus in Cybersecurity, I have been gaining experience by building a home lab environment, complete with a bare metal OPNsense router, OpenWrt AP, a Zima Board running NixOS as a server (running full Wazuh stack), and a 3-node Proxmox cluster. My laptop has since been switched to NixOS, but managing a separate configuration for it was unsustainable and inefficient. NixOS has completely changed the way I approach system administration, which led me to work on unifying three hosts into a single repo so I could effectively manage all configurations from my desktop.

My first step was researching tools and frameworks to help implement this, but I did not want to rewrite my configurations or change the current modular structure. The Nix language is intelligent and powerful enough to handle this without any additional tools, requiring only some conditional formatting and Nix-native options to manage multiple hosts. Next, I needed to create a CI/CD to automatically push changes from my desktop to additional hosts, and ensure that synchronization was maintained. The nixos-upgrade systemd service was used for additional hosts to pull latest changes from remote via ssh before system.autoUpgrade triggers a rebuild. This is on a daily timer so my laptop stays up to date, and SOPS is used to manage secrets required for this process. 

This is the most involved NixOS project I have attempted thus far, and any thoughts or suggestions for improvement are welcome! I am workshopping a name for the architecture/CI; maybe something like "nixsync"?

I am currently working on a full write-up, and creating a template/blueprint of this architecture so anyone looking to implement a modular, multi-host configuration with an automated CI/CD using only native Nix options, and without using additional tools or frameworks, can use this as a reference.

Below is a high level outline of my config:

- Refactored to manage multiple hosts from a single repo, each with their own
  top-level configuration (via configuration.nix), imported system modules based on hostname,
  and a shared home-manager configuration for uniformity across systems (but this can easily be separated). Flake.nix is shared by all systems, with new hosts being added by simply copying the host above, and changing the username & hostname to match the new device. Any nixosModules or homeModules can easily be added/removed based on the host.

- username and hostname are defined as the same value across top-level flake.nix, home.nix,  
  and respective configuration.nix allows nixos-rebuild to intelligently detect hosts,
  enforce locked inputs, and atomically build top-level configurations using "nixos-rebuild switch" without any flags.

- The nix-config directory is organized using a hosts folder that contains respective config.nix, hardware-config.nix, a boot module, and a desktop/GPU module. Modules are further separated into System and User, with System (configuration.nix) and User (home.nix) modules being imported in their respective top-level configurations using a conditional list based on config.networking.hostName, defined by lib.optionals.

- SOPS is used for secrets management, and a automated CI/CD has been implemented for additional hosts by connecting to my self-hosted forgejo instance via ssh, and running a scripted nixos-upgrade service on a daily timer to run a git pull, update flake.lock, and rebuild the system configuration.

