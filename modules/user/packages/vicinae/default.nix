# ==========================================================================
# Home Manager Vicinae Conf
# ==========================================================================

{ 
  config,
  inputs,
  pkgs,
  ... 
}:

{

# Vicinae theme is currently set using the Catppuccin Flake. 
# To apply the theme defined in the .toml file, remove the curly braces, and uncomment lines 16, 19, 21, 23-25, 28, and 51.

#let
  
  #rawThemeData = builtins.fromTOML (builtins.readFile ./rose-pine-moon.toml);

#in {

  #imports = [
  #  inputs.vicinae.homeManagerModules.default
  #];
  
  #home.file.".config/vicinae/themes/icons/rose-pine-moon.png".source = ./rose-pine.png;

  # Enable vicinae
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    useLayerShell = true;
    settings = {
      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = true;
      search_files_in_root = true;
      favicon_service = "twenty";
      font = {
        normal = {
          size = 12;
          family = "Maple Nerd Font";
        };
      };
    };
    #themes.rose-pine-moon = rawThemeData;
  };

}
