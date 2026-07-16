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
  
  # Create .zshrc to bypass ZSH setup wizard.
  system.userActivationScripts.zshrc = "touch .zshrc";
  
  environment = {
    
    # System shells
    shells =  with pkgs; [
      bashInteractive
      zsh
    ];
    
    # Paths
    pathsToLink = [
      "/share/zsh"
    ];
  };

  # Enable ZSH w/ ohMyZSH (further config at user level)
  programs.zsh = {
    enable = true;
    histSize = 10000;
   
    shellAliases = {
      adblist = "adb shell pm list packages";
      adbtrim = "adb shell pm trim-caches 128G";
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
  };
}
