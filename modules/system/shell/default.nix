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
  
  # Configure ZSH as default system shell; system.userActivationScripts.zshrc creates a .zshrc file in the user's home directory, bypassing the ZSH first-time setup wizard.
  system.userActivationScripts.zshrc = "touch .zshrc";
  environment.shells =  with pkgs; [ bashInteractive zsh ];

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
      gsc = "./scripts/git-stage-commit.zsh";
      gscym = "./scripts/git-stage-commit.zsh -y -m";
      gs = "git status";
      gsp = "git status -s -b";
      gpm = "git push -u origin main";
      ipas = "ip addr show";
      ll = "ls -la";
      ncatup = "update-netcatty";
      nfu = "cd nix-config && nix flake update";
      nrda = "sudo nixos-rebuild dry-activate";
      nrs = "sudo nixos-rebuild switch";
      psyncup = "plasma-sync diff --update";
      wup = "update-warp";
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