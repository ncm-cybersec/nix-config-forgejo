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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
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