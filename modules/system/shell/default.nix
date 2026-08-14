# ==========================================================================
# Zsh Shell Configuration
# ==========================================================================

{ 
  config,
  pkgs, 
  ... 
}:

{
  
  # Create .zshrc to bypass ZSH setup wizard.
  system.userActivationScripts.zshrc = "touch .zshrc";
  
  environment = {
    
    shells =  with pkgs; [
      bashInteractive
      zsh
    ];
    
    pathsToLink = [
      "/share/zsh"
    ];
  };

  # Enable ZSH w/ ohMyZSH (further config at user level)
  programs = {
    zsh = {
      enable = true;
      enableGlobalCompInit = config.programs.zsh.enableCompletion;
      enableLsColors = true;
      histSize = 10000;
   
      shellAliases = {
        adblist = "adb shell pm list packages";
        adbtrim = "adb shell pm trim-caches 128G";
        appup = "update-appimages";
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
        nfu = "cd nix-config && nix flake update";
        nrb = "sudo nix-rebuild";
        nrda = "sudo nixos-rebuild dry-activate";
        nrs = "sudo nixos-rebuild switch";
        psyncup = "plasma-sync diff --update";
      };
    };
  };
}
