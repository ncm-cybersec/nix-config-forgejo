# ---------------------------------------------------
# Home Manager - zsh configuration
# ---------------------------------------------------

{ ... }:

{
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