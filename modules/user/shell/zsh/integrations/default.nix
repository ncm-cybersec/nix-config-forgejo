# ==========================================================================
# Zsh Integrations
# ==========================================================================

{ 
  ... 
}:

{
  
  programs = {
    atuin = {
      enable = true;
      enableZshIntegration = true;
      daemon = {
        enable = true;
        logLevel = "warn";
      };
      
      settings = builtins.fromTOML (builtins.readFile ../atuin/config.toml);
    };
    
    eza = {
      enable = true;
      enableZshIntegration = true;
      colors = "auto";
      icons = "auto";
      git = true;
    };
    
    fastfetch = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ../fastfetch/fastfetch7.json);
    };
    
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    
    ripgrep = {
      enable = true;
      arguments = [
        "RIPGREP_CONFIG_PATH=~/.config/ripgreprc"
      ];
    };
    
    ripgrep-all = {
      enable = true;
    };
    
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ../starship/starship.toml);
    };
    
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
