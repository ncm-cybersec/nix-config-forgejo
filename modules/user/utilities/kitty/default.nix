# ==========================================================================
# Kitty Terminal Configuration
# ==========================================================================

{
  pkgs,
  pkgsUnstable,
  ...
}:

{
  programs = {
    kitty = {
      enable = true;
      package = pkgsUnstable.kitty;
      enableGitIntegration = true;
      shellIntegration.enableZshIntegration = true;

      font = {
        name = "FiraCode";
        package = pkgs.nerd-fonts.fira-code;
        size = "11";
      };

      quickAccessTerminalConfig = {
        lines = "40";
        columns = "80";
        edge = "top";
        layer = "overlay";
        background_opacity = 0.85;
        hide_on_focus_loss = true;
        grab_keyboard = false;
      };

      settings = {
        hide_window_decorations = false;
        initial_window_width = "1100";
        initial_window_height = "800";
        remember_window_position = true;
        remember_window_size = true;
      };

      extraConfig = builtins.readFile ./kitty.conf;
    };
  };
}
