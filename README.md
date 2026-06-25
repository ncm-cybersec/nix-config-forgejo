# NixOS Multi-Host Architecture and CI/CD Using Only Native Nix Options

I have been using NixOS exclusively as my daily driver on my primary desktop for the last six months. My laptop has since been switched to NixOS, as well as a Zima Board running NixOS as a server. NixOS has completely changed the way I approach system administration, which led me to work on unifying three hosts into a single repo so I could effectively manage all configurations from my desktop.

My first step was researching tools and frameworks to help implement this, but I did not want to rewrite my configurations or change the current modular structure. The Nix language is intelligent and powerful enough to handle this without any additional tools, requiring only some conditional formatting and Nix-native options to manage multiple hosts. Next, I needed to create a CI/CD to automatically push changes from my desktop to additional hosts, and ensure that synchronization was maintained. The nixos-upgrade systemd service was used for additional hosts to pull latest changes from remote via ssh before system.autoUpgrade triggers a rebuild. This is on a daily timer so my laptop stays up to date, and SOPS is used to manage secrets required for this process. 

This is the most involved NixOS project I have attempted thus far, and any thoughts or suggestions for improvement are welcome! I am workshopping a name for the CI; maybe something like "nixsync"?

Below is a high level outline of my config; I am currently working on a full write-up, and creating a template/blueprint of this architecture so anyone looking to implement a modular, multi-host configuration with a automated CI/CD, and without using additional tools or frameworks, can use this as a reference.

======================================================================================


- Refactored for multiple hosts sharing the same repo, each with their own
  top-level configuration (via configuration.nix), imported system modules based on hostname,
  and a shared home-manager configuration for uniformity across systems (but this can easily be separated).

- Defining username and hostname as the same value across top-level flake.nix, home.nix,  
  and respective configuration.nix allows nixos-rebuild to intelligently detect hosts,
  enforce locked inputs, and atomically build top-level configurations using "nixos-rebuild switch" without any flags.

- System (configuration.nix) and User (home.nix) modules are imported using
  a conditional list based on config.networking.hostName, defined by lib.optionals.

- SOPS is used for secrets management, and a automated CI/CD has been implemented using only
  nix-native options, and a scripted nixos-upgrade service to sync changes between hosts on a schedule.

======================================================================================