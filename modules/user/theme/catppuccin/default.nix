# ==========================================================================
# Catppuccin Theme Configuration
# ==========================================================================

{ 
  config, 
  pkgs, 
  inputs, 
  ... 
}: 

{

  # Import the catppuccin flake module
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  # Set global theme using catppuccin flake input, to create a theme similar to Garuda Mokka
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    btop = {
      enable = true;
      flavor = "macchiato";
    };
    cache = {
      enable = true;
    };
    cursors = {
      enable = true;
      flavor = "macchiato";
      accent = "mauve";
    };
    eza = {
      enable = true;
      accent = "mauve";
    };
    fzf = {
      enable = true;
      accent = "mauve";
      flavor = "macchiato";
    };
    gtk = {
      icon = {
        enable = true;
        accent = "mauve";
        flavor = "macchiato";
      };
    };
    nushell = {
      enable = true;
      flavor = "macchiato";
    };
    obs = {
      enable = true;
      flavor = "macchiato";
    };
    opencode = {
      enable = true;
      flavor = "macchiato";
    };
    spotify-player = {
      enable = true;
      flavor = "macchiato";
    };
    tmux = {
      enable = true;
      flavor = "macchiato";
    };
    vicinae = {
      enable = true;
      accent = "mauve";
    };
    zsh-syntax-highlighting = {
      enable = true;
      flavor = "macchiato";
    };

  };

}