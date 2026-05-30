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
  
}