# ==========================================================================
# Home Manager Vicinae Conf
# ==========================================================================

{ 
  config,
  inputs,
  pkgs,
  ... 
}:

let
  # Vicinae theme data is tracked in this repo, with the function below parsing the .toml file into a Nix attrset, while also symlinking to the correct path for Vicinae ~/.config/vicinae/themes/.
  rawThemeData = builtins.fromTOML (builtins.readFile ./rose-pine-moon.toml);

in {

  imports = [
    inputs.vicinae.homeModules.default
  ];
  
  # Links rose-pine-moon.png to the correct path for Vicinae ~/.config/vicinae/themes/icons/.
  home.file.".config/vicinae/themes/icons/rose-pine-moon.png".source = ./rose-pine.png;

    
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
    themes.rose-pine-moon = rawThemeData;
  };

}
