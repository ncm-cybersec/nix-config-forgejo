# ---------------------------------------------------
# Nixos Zsh Configuration
# ---------------------------------------------------

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nerd-fonts.fira-code
    starship
  ];
  
  system.userActivationScripts.zshrc = "touch .zshrc";
  environment.shells =  with pkgs; [ bashInteractive zsh ];
  environment.loginShellInit = ''
    export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

    eval "$(starship init zsh)"

    fastfetch
  '';

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