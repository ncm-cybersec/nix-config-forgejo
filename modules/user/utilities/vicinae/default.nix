# ==========================================================================
# Home Manager Vicinae Conf
# ==========================================================================

{ 
  ... 
}:

{

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
