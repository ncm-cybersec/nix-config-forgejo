# ==========================================================================
# Home Manager Tmux Configuration
# ==========================================================================

{ 
  pkgs,
  ... 
}:

{

  # Enable Tmux
  programs.tmux = {
    enable = true;
    shortcut = "a";
    clock24 = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    mouse = true;

    extraConfig = ''
      # Set vi mode for copy mode
      set-window-option -g mode-keys vi

      # Enable mouse support
      set -g mouse on
    '';
  };

}
