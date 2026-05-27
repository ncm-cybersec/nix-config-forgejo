# ---------------------------------------------------
# Home Manager - zsh configuration
# ---------------------------------------------------

{ ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        fastfetch
      '';
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  
}