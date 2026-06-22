# ==========================================================================
# Zsh Shell Configuration
# ==========================================================================

{ 
  pkgs, 
  ... 
}:

{
  environment.systemPackages = with pkgs; [
    nerd-fonts.fira-code
    starship
  ];
  
  # Configure ZSH as default system shell. Configuring for system and user was required for oh-my-zsh to work. Declaring system.userActivationScripts.zshrc creates a .zshrc file in the user's home directory, bypassing the ZSH first-time setup wizard.
  system.userActivationScripts.zshrc = "touch .zshrc";
  environment.shells =  with pkgs; [ bashInteractive zsh ];

  # Thank you to https://github[.]com/sircam-html/nixos-conf for "fastfetch -c examples/25"!
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    shellAliases = {
      c = "clear";
      cdu = "cd ..";
      et = "eza --tree";
      ga = "git add .";
      gb = "git branch -m main";
      gi = "git init";
      gm = "git commit -m";
      gs = "git status";
      gsp = "git status -s -b";
      gpm = "git push -u origin main";
      ipas = "ip addr show";
      ll = "ls -la";
      nfu = "cd nix-config && nix flake update";
      nrs = "sudo nixos-rebuild switch";
    };
    ohMyZsh = {
      enable = true;
      plugins = [
        "branch"
        "git"
        "ssh-agent"
        "ssh"
        "starship"
        "systemd"
        "tailscale"
      ];
    };
  };
}