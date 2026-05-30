# ---------------------------------------------------
# Home Manager - zsh configuration
# ---------------------------------------------------

{ ... }:

{
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

  # Extend ZSH functionality with additional programs
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./fastfetch25.jsonc);
  };
  
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
 
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
 
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  
}