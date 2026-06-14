# ==========================================================================
# Global Theme Configuration - Mimics Garuda Mokka
# ==========================================================================  

{
  config,
  pkgs,
  ...
}: {

  # Ensure the user-level theme packages are accessible
  home.packages = with pkgs; [

    # kde
    kdePackages.kzones
    kdePackages.qtstyleplugin-kvantum
    kde-rounded-corners

    # kvantum
    libsForQt5.kvantum
    rose-pine-kvantum

    # icons
    beauty-line-icon-theme
    catppuccin-papirus-folders
    kora-icon-theme
    papirus-folders
    papirus-icon-theme
    tela-circle-icon-theme
  ];

  # Configure the Rounded Corners KWin plugin to draw a purple border around windows
  xdg.configFile."kwinrc".text = ''
    [Plugins]
    rounded-cornersEnabled=true
    forceblurEnabled=true

    [Effect-Rounded-Corners]
    BorderColorActive=203,166,247,255
    BorderColorInactive=147,153,178,150
    BorderThickness=2
    CornerRadius=12
    OutlineEnabled=true
  '';

  # Set up the adaptive behavior rules for panels
  xdg.configFile."panel-colorizer/presets/MokkaPanel.json".text = ''
    {
      "panelOpacity": 0.0,
      "maximizedOpacity": 0.85,
      "touchingOpacity": 0.85,
      "blurEffect": true,
      "activeTheme": "Mokka Carbon",
      "enableFloating": true,
      "cornerRadius": 12,
      "padding": 6
    }
  '';
}