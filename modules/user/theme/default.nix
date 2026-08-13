# ==========================================================================
# Catppuccin Theme Configuration
# ==========================================================================

{ 
  pkgs, 
  inputs, 
  ... 
}: 

{

  # Additional theme packages
  home.packages = with pkgs; [

    # kde kwin-effects-glass flake module
    inputs.kwin-effects-glass.packages.${pkgs.system}.default 

    # kde
    kdePackages.kzones
    kde-rounded-corners

    # icons
    beauty-line-icon-theme
    kora-icon-theme
    papirus-folders
    papirus-icon-theme
    tela-circle-icon-theme
  ];

  # Set global theme using catppuccin flake
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    
    atuin = {
      enable = true;
      flavor = "macchiato";
      accent = "mauve";
    };
    
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
    
    kitty = {
      enable = true;
      flavor = "macchiato";
    };
    
    lazygit = {
      enable = true;
      accent = "mauve";
      flavor = "macchiato";
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
