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

  # Import the sops-nix Home Manager module
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  # Set global theme using catppuccin flake input, mimicking Garuda Mokka theme
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    btop = {
      enable = "catppuccin.enable";
      flavor = "catppuccin.macchiato";
    };
    cache = {
      enable = true;
    };
    cursors = {
      enable = true;
      flavor = "catppuccin.macchiato";
      accent = "mauve";
    };
    eza = {
      enable = true;
      accent = "catppuccin.mauve";
    };
    fzf = {
      enable = "catppuccin.enable";
      accent = "catppuccin.mauve";
      flavor = "catppuccin.macchiato";
    };
    gtk = {
      icon = {
        enable = "catppuccin.enable";
        accent = "catppuccin.mauve";
        flavor = "catppuccin.macchiato";
      };
    };
    nushell = {
      enable = "catppuccin.enable";
      flavor = "catppuccin.macchiato";
    };
    obs = {
      enable = "catppuccin.enable";
      flavor = "catppuccin.macchiato";
    };
    opencode = {
      enable = "catppuccin.enable";
      flavor = "catppuccin.macchiato";
    };
    spotify-player = {
      enable = "catppuccin.enable";
      flavor = "catppuccin.macchiato";
    };
    tmux = {
      enable = "catppuccin.enable";
      flavor = "catppuccin.macchiato";
    };
    vicinae = {
      enable = "catppuccin.enable";
      accent = "catppuccin.mauve";
    };
    zsh-syntax-highlighting = {
      enable = "catppuccin.enable";
      accent = "catppuccin.mauve";
    };

  };

}